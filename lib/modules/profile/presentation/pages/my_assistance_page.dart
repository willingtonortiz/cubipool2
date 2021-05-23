import 'package:cubipool2/core/error/failures.dart';
import 'package:flutter/material.dart';

import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/injection_container.dart';
import 'package:cubipool2/modules/profile/domain/usecases/get_my_assistance.dart';
import 'package:cubipool2/modules/profile/presentation/widgets/assistance_item.dart';
import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';

class MyAssistancePage extends StatefulWidget {
  MyAssistancePage({Key? key}) : super(key: key);

  @override
  _MyAssistancePageState createState() => _MyAssistancePageState();
}

class _MyAssistancePageState extends State<MyAssistancePage> {
  late final GetMyAssistance getMyAssistanceUseCase;
  List<Reservation> items = [];
  Reservation? active;
  bool isLoading = true;

  @override
  void initState() {
    getMyAssistanceUseCase = injector.get<GetMyAssistance>();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      loadAssistance();
    });
    super.initState();
  }

  Future<void> loadAssistance() async {
    final either = await getMyAssistanceUseCase.execute(NoParams());

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
        title: Text('Asistencia de cubículos'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Activas'),
            ),
            _buildActiveAssistance(active),
            Divider(height: 24),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Finalizadas'),
            ),
            _buildOldAssists(items),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveAssistance(Reservation? reservation) {
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

    return AssistanceItem(assistance: reservation);
  }

  Widget _buildOldAssists(List<Reservation> reservations) {
    if (isLoading) {
      return Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Expanded(
      child: ListView.separated(
        itemCount: reservations.length,
        itemBuilder: (context, index) =>
            AssistanceItem(assistance: reservations[index]),
        separatorBuilder: (context, index) => Divider(height: 24),
      ),
    );
  }
}
