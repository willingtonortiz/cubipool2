import 'package:cubipool2/shared/pages/not_found_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:cubipool2/modules/reservation/domain/entities/reservation.dart';
import 'package:cubipool2/modules/reservation/presentation/pages/reservation_detail_page.dart';
import 'package:cubipool2/modules/reservation/domain/entities/campus.dart';

class ReservationSearchResultsPage extends StatelessWidget {
  final List<Reservation> reservations;
  final Campus campus;
  final DateTime startHour;
  final int hoursCount;

  const ReservationSearchResultsPage({
    Key? key,
    required this.reservations,
    required this.campus,
    required this.startHour,
    required this.hoursCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado de búsqueda'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildChips(),
              _buildCubicleList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChips() {
    final padding = const EdgeInsets.symmetric(
      vertical: -2.0,
      horizontal: 4.0,
    );

    final endHour = startHour.add(Duration(hours: hoursCount));
    final formatter = DateFormat.Hm();
    final formattedStartHour = formatter.format(startHour);
    final formattedEndHour = formatter.format(endHour);

    return Wrap(
      spacing: 8.0,
      children: [
        Chip(
          label: Text('Campus ${campus.name}'),
          labelPadding: padding,
        ),
        Chip(
          label: Text('$formattedStartHour - $formattedEndHour'),
          labelPadding: padding,
        ),
      ],
    );
  }

  Widget _buildCubicleList(BuildContext context) {
    if (reservations.isEmpty) {
      return Expanded(
        child:
            NotFoundPage.fromMonitaChina('No encontré cubiculos, lo siento...'),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: reservations.length,
        itemBuilder: (_, index) => _buildCubicleListItem(
          context,
          reservations[index],
        ),
      ),
    );
  }

  Widget _buildCubicleListItem(
    BuildContext context,
    Reservation reservation,
  ) {
    final formatter = DateFormat.Hm();
    final formattedStartHour = formatter.format(reservation.startHour);
    final formattedEndHour = formatter.format(reservation.endHour);

    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.tab_outlined),
                        const SizedBox(width: 8.0),
                        Text('Cubículo ${reservation.cubicleCode}'),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(Icons.watch_later_outlined),
                        const SizedBox(width: 8.0),
                        Text('$formattedStartHour - $formattedEndHour'),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
      onTap: () async {
        await Navigator.push<String>(
          context,
          MaterialPageRoute(
            builder: (context) => ReservationDetailPage(
              campus: campus,
              reservation: reservation,
            ),
          ),
        );
      },
    );
  }
}
