import 'package:cubipool2/core/error/failures.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:cubipool2/injection_container.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';
import 'package:cubipool2/modules/profile/presentation/provider/providers.dart';
import 'package:cubipool2/modules/profile/domain/usecases/get_all_reservations.dart';
import 'package:cubipool2/modules/profile/presentation/widgets/reservation_item.dart';

class MyReservationsPage extends StatefulWidget {
  static const PAGE_ROUTE = '/profile/my-reservations';

  MyReservationsPage({Key? key}) : super(key: key);

  @override
  _MyReservationsPageState createState() => _MyReservationsPageState();
}

class _MyReservationsPageState extends State<MyReservationsPage> {
  late final GetAllReservations getMyReservationsUseCase;
  List<Reservation> items = [];
  Reservation? active;
  bool isLoading = true;

  _MyReservationsPageState();

  @override
  void initState() {
    getMyReservationsUseCase = injector.get<GetAllReservations>();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      loadReservations();
    });
    super.initState();
  }

  Future<void> loadReservations() async {
    final either = await getAllReservations.execute(NoParams());

    setState(() => isLoading = false);

    either.fold(
      (failure) {
        if (failure is ServerFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(failure.firstError),
          ));
        }
      },
      (result) {
        setState(() {
          active = result.active;
          items = result.reservations;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mis Reservas'),
        ),
        body: SafeArea(
          child: Center(
              child: Column(children: [
            const SizedBox(height: 20.0),
            Text('Activas'),
            const SizedBox(height: 10.0),
            _buildActiveReservation(active),
            const SizedBox(height: 20.0),
            Text('Finalizadas'),
            _buildFinishedReservations(items),
            const SizedBox(height: 10.0)
          ])),
        ));
  }

  Widget _buildActiveReservation(Reservation? reservation) {
    final centeredContainer = (Widget widget) => Container(
          height: 64,
          child: Center(child: widget),
        );

    if (isLoading) {
      return centeredContainer(CircularProgressIndicator());
    }
    if (reservation == null) {
      return centeredContainer(Text('No hay reservas para asistir'));
    }

    return ReservationItem(reservation: reservation);
  }

  Widget _buildFinishedReservations(List<Reservation> reservations) {
    if (isLoading) {
      return Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return (reservations.length > 0)
        ? Expanded(
            child: ListView.builder(
              itemCount: reservations.length,
              itemBuilder: (_, index) =>
                  ReservationItem(reservation: reservations[index]),
            ),
          )
        : Text('No cuentas con reservas finalizadas');
  }
}
