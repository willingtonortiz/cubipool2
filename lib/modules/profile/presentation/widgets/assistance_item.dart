import 'package:cubipool2/core/utils/reservation_status_translate.dart';
import 'package:cubipool2/modules/profile/presentation/pages/assistance_detail_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';

class AssistanceItem extends StatelessWidget {
  const AssistanceItem({
    Key? key,
    required this.assistance,
  }) : super(key: key);

  final Reservation assistance;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd/MM/yyyy');
    final hourFormatter = DateFormat.Hm();
    final formattedDate = dateFormatter.format(assistance.startDateTime);
    final startHour = hourFormatter.format(assistance.startDateTime);
    final endHour = hourFormatter.format(assistance.endDateTime);

    return InkWell(
      onTap: () {
        Navigator.push<String>(
          context,
          MaterialPageRoute(
            builder: (context) => AssistanceDetailPage(
              assistance: assistance,
            ),
          ),
        );
      },
      child: Row(children: [
        Expanded(
          child: Column(children: [
            Row(children: [
              Icon(Icons.biotech),
              const SizedBox(width: 8),
              Text('Cubículo ${assistance.cubicleCode}'),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Icon(Icons.access_time),
              const SizedBox(width: 8),
              Text('$startHour - $endHour'),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Icon(Icons.calendar_today),
              const SizedBox(width: 8),
              Text(formattedDate),
            ]),
          ]),
        ),
        Expanded(
          child: Column(children: [
            Row(children: [
              Icon(Icons.business),
              const SizedBox(width: 8),
              Text('Campus ${assistance.campusName}'),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              Icon(Icons.library_books_rounded),
              const SizedBox(width: 8),
              Text(ReservationStatusTranslate.getTranslation(assistance.type)),
            ]),
          ]),
        ),
        Icon(Icons.chevron_right),
      ]),
    );
  }
}
