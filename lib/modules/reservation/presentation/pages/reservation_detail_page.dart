import 'package:cubipool2/modules/reservation/domain/usecases/reserve_cubicle.dart';
import 'package:cubipool2/modules/reservation/presentation/provider/providers.dart';
import 'package:cubipool2/shared/widgets/notification_dialog.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:cubipool2/shared/widgets/async_confirmation_dialog.dart';
import 'package:cubipool2/modules/reservation/domain/entities/reservation.dart';
import 'package:cubipool2/modules/reservation/domain/entities/campus.dart';

class ReservationDetailPage extends StatelessWidget {
  final Reservation reservation;
  final Campus campus;

  const ReservationDetailPage({
    Key? key,
    required this.campus,
    required this.reservation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.Hm();
    final formattedStartHour = formatter.format(reservation.startHour);
    final formattedEndHour = formatter.format(reservation.endHour);

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
                      Icon(Icons.biotech),
                      const SizedBox(width: 8.0),
                      Text('Campus ${campus.name}'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time),
                      const SizedBox(width: 8.0),
                      Text('Cubículo ${reservation.cubicleCode}'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_today),
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
        bool isReservationSuccessful = false;
        bool hasCancelled = false;

        final dialog = AsyncConfirmationDialog(
          title: 'Confirmación de reserva',
          content: '¿Estás seguro que quieres reservar este cubículo?',
          onOk: () async {
            final either = await reserveCubicle.execute(ReserveCubicleParams(
              cubicleId: reservation.cubicleId,
              startTime: reservation.startHour,
              endTime: reservation.endHour,
            ));

            either.fold(
              (l) => isReservationSuccessful = false,
              (r) => isReservationSuccessful = true,
            );
          },
          onCancel: () async => hasCancelled = true,
        );
        await showDialog(
          context: context,
          builder: (context) => dialog,
          barrierDismissible: false,
        );

        if (hasCancelled) {
          return;
        }

        final notificationMessage =
            isReservationSuccessful ? 'Reserva exitosa' : 'Falló la reserva';

        final reserveNotification = NotificationDialog(
          title: notificationMessage,
          onOk: () async {
            if (isReservationSuccessful) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
          },
        );
        await showDialog(
          context: context,
          builder: (context) => reserveNotification,
          barrierDismissible: false,
        );
      },
      child: Text('Reservar'),
    );
  }
}
