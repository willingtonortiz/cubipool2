import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cubipool2/modules/reservation/models/campus.dart';

final campusList = [
  Campus(id: '1', name: 'VILLA'),
  Campus(id: '2', name: 'SAN MIGUEL'),
  Campus(id: '3', name: 'SAN ISIDRO'),
  Campus(id: '4', name: 'MONTERRICO'),
];

final reservationHours = [1, 2];
const FIRST_RESERVATION_HOUR = 7;
const LAST_RESERVATION_HOUR = 22;
bool isValidReservationHour(DateTime dateTime) {
  return (FIRST_RESERVATION_HOUR <= dateTime.hour &&
      dateTime.hour <= LAST_RESERVATION_HOUR);
}

List<DateTime> generateDateStartHoursList() {
  final now = DateTime.now();
  final addHour = now.minute != 0 ? 1 : 0;
  final startHour = DateTime(now.year, now.month, now.day, now.hour + addHour);
  // final endHour = DateTime(now.year, now.month, now.day, 11);
  final endHour = startHour.add(Duration(days: 1));
  final hoursBetween = endHour.difference(startHour);

  return List.generate(
    hoursBetween.inHours,
    (index) => startHour.add(Duration(hours: index)),
  ).where((item) => isValidReservationHour(item)).toList();
}

class ReservationPage extends StatefulWidget {
  ReservationPage({Key? key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  List<DateTime> startHours = [];

  Campus? _selectedCampus;
  DateTime? _selectedStartHour;
  int? _selectedHoursCount;

  @override
  void initState() {
    super.initState();
    _selectedHoursCount = 1;
    startHours = generateDateStartHoursList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar cubículos'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 32.0),
              Image.asset('assets/logos/books.png'),
              const SizedBox(height: 32.0),
              _buildCampusDropdown(campusList),
              const SizedBox(height: 16.0),
              _buildStartHour(startHours),
              const SizedBox(height: 16.0),
              _buildHoursCount(reservationHours),
              const SizedBox(height: 16.0),
              _buildSearchButton(),
              TextButton(
                onPressed: () {
                  generateDateStartHoursList();
                },
                child: Text('PRESS'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCampusDropdown(List<Campus> campus) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: DropdownButton(
        isExpanded: true,
        hint: Text('Seleccione la sede'),
        value: _selectedCampus,
        underline: Container(
          height: 2,
          color: Theme.of(context).primaryColor,
        ),
        onChanged: (Campus? item) {
          setState(() {
            _selectedCampus = item;
          });
        },
        items: campus.map(
          (item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item.name),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildStartHour(List<DateTime> startHours) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: DropdownButton<DateTime>(
        isExpanded: true,
        hint: Text('Hora de inicio'),
        value: _selectedStartHour,
        underline: Container(
          height: 2,
          color: Theme.of(context).primaryColor,
        ),
        onChanged: setStartHour,
        items: startHours.map(
          (item) {
            final parsedDate = DateFormat('d/MM - hh:mm a').format(item);

            return DropdownMenuItem(
              value: item,
              child: Text(parsedDate),
            );
          },
        ).toList(),
      ),
    );
  }

  void setStartHour(DateTime? item) {
    setState(() {
      _selectedStartHour = item;
      _selectedHoursCount = 1;
    });
  }

  Widget _buildHoursCount(List<int> hours) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('Cantidad de horas'),
          ...hours.map((hour) {
            return Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<int>(
                    groupValue: _selectedHoursCount,
                    value: hour,

                    // focusColor: Colors.blue,
                    // activeColor: Colors.blue,
                    onChanged:
                        isHourAvailableForStartHour(_selectedStartHour, hour)
                            ? setHoursCount
                            : null,
                  ),
                  Text('$hour'),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  bool isHourAvailableForStartHour(DateTime? startHour, int hour) {
    if (startHour == null) return false;
    final endHour = startHour.add(Duration(hours: hour));
    return isValidReservationHour(endHour);
  }

  void setHoursCount(int? value) {
    setState(() {
      _selectedHoursCount = value;
    });
  }

  Widget _buildSearchButton() {
    return ElevatedButton(
      onPressed: () {
        print(_selectedCampus);
        print(_selectedStartHour);
        print(_selectedHoursCount);
      },
      child: Text('Buscar'),
    );
  }
}
