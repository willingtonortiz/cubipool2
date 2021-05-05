import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:cubipool2/shared/widgets/async_confirmation_dialog.dart';
import 'package:cubipool2/modules/reservation/domain/entities/reservation.dart';
import 'package:cubipool2/modules/reservation/domain/entities/campus.dart';

class ReservationDetailPage extends StatelessWidget {
  final Reservation reservation;
  final DateTime startHour;
  final Campus campus;
  final int hoursCount;

  const ReservationDetailPage({
    Key? key,
    required this.reservation,
    required this.campus,
    required this.startHour,
    required this.hoursCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final endHour = startHour.add(Duration(hours: hoursCount));
    final formatter = DateFormat.Hm();
    final formattedStartHour = formatter.format(startHour);
    final formattedEndHour = formatter.format(endHour);

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado de búsqueda'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 32.0),
              Image.asset('assets/logos/books.png'),
              const SizedBox(height: 32.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.ac_unit),
                      const SizedBox(width: 8.0),
                      Text('Campus ${campus.name}'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.ac_unit),
                      const SizedBox(width: 8.0),
                      Text('Cubículo ${reservation.code}'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.ac_unit),
                      const SizedBox(width: 8.0),
                      Text('$formattedStartHour - $formattedEndHour'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Spacer(),
              _buildReservationButton(context),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReservationButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final dialog = AsyncConfirmationDialog(
          title: '¿Esta seguro de reservar este cubiculo?',
          onOk: () async {
            await Future.delayed(Duration(seconds: 1));
          },
          onCancel: () async {},
        );

        showDialog(
          context: context,
          builder: (context) => dialog,
          barrierDismissible: false,
        );
      },
      child: Text('Reservar'),
    );
  }
}

// class ReservationDetailPage extends StatefulWidget {
//   ReservationDetailPage({Key? key}) : super(key: key);

//   @override
//   _ReservationDetailPageState createState() => _ReservationDetailPageState();
// }

// class _ReservationDetailPageState extends State<ReservationDetailPage> {
//   @override
//   Widget build(BuildContext context) {

//   }
// }
