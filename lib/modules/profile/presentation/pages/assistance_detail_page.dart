import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';

class AssistanceDetailPage extends StatefulWidget {
  final Reservation assistance;

  AssistanceDetailPage({
    Key? key,
    required this.assistance,
  }) : super(key: key);

  @override
  _AssistanceDetailPageState createState() => _AssistanceDetailPageState();
}

class _AssistanceDetailPageState extends State<AssistanceDetailPage> {
  @override
  Widget build(BuildContext context) {
    final assistance = widget.assistance;
    final dateFormatter = DateFormat('dd/MM/yyyy');
    final hourFormatter = DateFormat.Hm();
    final formattedDate = dateFormatter.format(assistance.startDateTime);
    final startHour = hourFormatter.format(assistance.startDateTime);
    final endHour = hourFormatter.format(assistance.endDateTime);

    return Scaffold(
      appBar: AppBar(title: Text('Detalle de la asistancia')),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.biotech),
                  const SizedBox(width: 8),
                  Text('Cubículo ${assistance.cubicleCode}'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.access_time),
                  const SizedBox(width: 8),
                  Text('$startHour - $endHour'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.business),
                  const SizedBox(width: 8),
                  Text('Campus ${assistance.campusName}'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.library_books_rounded),
                  const SizedBox(width: 8),
                  Text(assistance.type),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                  Text(formattedDate),
                ],
              ),
              const Spacer(),
              _buildShowQrButton(assistance),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShowQrButton(Reservation assistance) {
    if (!assistance.isActive()) {
      return SizedBox();
    }

    return ElevatedButton(
      onPressed: () {
        // TODO: Show QR Code
      },
      child: Text('Mostrar código QR'),
    );
  }
}
