import 'package:cubipool2/modules/search/domain/entities/campus.dart';
import 'package:cubipool2/modules/search/domain/entities/publication.dart';
import 'package:cubipool2/shared/widgets/async_confirmation_dialog.dart';
import 'package:cubipool2/shared/widgets/notification_dialog.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class PublicationDetailPage extends StatelessWidget {
  final Publication publication;
  final Campus campus;

  const PublicationDetailPage({
    Key? key,
    required this.campus,
    required this.publication,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.Hm();
    final formattedStartHour = formatter.format(publication.startHour);
    final formattedEndHour = formatter.format(publication.endHour);

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
                      Text('Cubículo ${publication.cubicleCode}'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.business),
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
                      Text('$formattedStartHour - $formattedEndHour'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Expanded(
                child: Container(
                    padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: Text(publication.description)),
              ),
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
        bool isJoinSuccessful = false;
        bool hasCancelled = false;
        final dialog = AsyncConfirmationDialog(
          title: 'Confirmación de Asistencia',
          content: '¿Estás seguro que quieres asistir a este cubículo?',
          onOk: () async {
            // TODO
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

        final notificationMessage = isJoinSuccessful
            ? 'Confirmación de Reserva'
            : 'Algo salío mal... :c';

        final reserveNotification = NotificationDialog(
          title: notificationMessage,
          onOk: () async {
            if (isJoinSuccessful) {
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
      child: Text('Asistir'),
    );
  }
}
