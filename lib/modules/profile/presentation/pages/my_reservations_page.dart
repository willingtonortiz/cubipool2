import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyReservationsPage extends StatefulWidget {
  static const PAGE_ROUTE = '/profile/my-reservations';
  final List<Reservation> reservations;

  MyReservationsPage({Key? key, required this.reservations}) : super(key: key);

  @override
  _MyReservationsPageState createState() =>
      _MyReservationsPageState(reservations: this.reservations);
}

class _MyReservationsPageState extends State<MyReservationsPage> {
  List<Reservation> reservations;
  Reservation? _activeReservation;

  _MyReservationsPageState({required this.reservations});

  @override
  Widget build(BuildContext context) {
    validateActiveReservation();

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
            _buildActiveReservation(context, _activeReservation),
            const SizedBox(height: 20.0),
            Text('Finalizadas'),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (_, index) => _buildReservationItem(
                  context,
                  reservations[index],
                ),
              ),
            )
          ])),
        ));
  }

  Widget _buildActiveReservation(
      BuildContext context, Reservation? reservation) {
    return (reservation != null)
        ? _buildReservationItem(context, reservation)
        : Text('No cuentas con reservas activas');
  }

  void validateActiveReservation() {
    this
        .reservations
        .sort((r1, r2) => r2.startDateTime.compareTo(r1.startDateTime));

    if (this.reservations[0].type != "FINISHED") {
      setState(() {
        _activeReservation = this.reservations[0];
        reservations = this.reservations.sublist(1);
      });
    } else {
      setState(() {
        _activeReservation = null;
      });
    }
  }

  Widget _buildReservationItem(BuildContext context, Reservation reservation) {
    return InkWell(
        onTap: () {
          print(reservation.id);
        },
        child: Container(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(children: [
                  Row(children: [
                    Expanded(
                        child: Column(children: [
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
                          Text(reservation.getHourInterval()),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today),
                          const SizedBox(width: 8.0),
                          Text(reservation.getDate()),
                        ],
                      ),
                    ])),
                    Expanded(
                        child: Column(children: [
                      Row(
                        children: [
                          Icon(Icons.business),
                          const SizedBox(width: 8.0),
                          Text('Campus ' + reservation.campusName),
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
                          Text(reservation.type),
                        ],
                      ),
                    ])),
                    Icon(Icons.arrow_forward_ios),
                  ]),
                  SizedBox(height: 15),
                  Divider(
                    color: Colors.black,
                    height: 0.5,
                    indent: 5,
                    endIndent: 5,
                  )
                ]))));
  }
}