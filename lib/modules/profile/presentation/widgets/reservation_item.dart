import 'package:cubipool2/core/utils/reservation_status_translate.dart';
import 'package:cubipool2/modules/profile/presentation/pages/detail_my_reservation_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem({
    Key? key,
    required this.reservation,
    required this.onRefresh,
  }) : super(key: key);

  final Reservation reservation;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd/MM/yyyy');
    final hourFormatter = DateFormat.Hm();
    final formattedDate = dateFormatter.format(reservation.startDateTime);
    final startHour = hourFormatter.format(reservation.startDateTime);
    final endHour = hourFormatter.format(reservation.endDateTime);

    return InkWell(
      onTap: () async {
        await Navigator.push<String>(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailMyReservationPage(reservation: reservation),
          ),
        );
        onRefresh();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.biotech),
                        const SizedBox(width: 8.0),
                        Text('Cubículo ' + reservation.cubicleCode),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time),
                        const SizedBox(width: 8.0),
                        Text('$startHour - $endHour'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today),
                        const SizedBox(width: 8.0),
                        Text(formattedDate),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.business),
                        const SizedBox(width: 8.0),
                        Text('Campus ${reservation.campusName}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.person),
                        const SizedBox(width: 8.0),
                        Text(reservation.seats.toString() + ' asientos'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.sticky_note_2_outlined),
                        const SizedBox(width: 8.0),
                        Text(ReservationStatusTranslate.getTranslation(
                            reservation.type)),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios),
            ]),
            SizedBox(height: 15),
            Divider(
              color: Colors.black,
              height: 0.5,
              indent: 5,
              endIndent: 5,
            )
          ],
        ),
      ),
    );
  }
}
