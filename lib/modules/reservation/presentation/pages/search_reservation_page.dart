import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cubipool2/modules/reservation/presentation/pages/reservation_search_results_page.dart';
import 'package:cubipool2/modules/reservation/presentation/provider/providers.dart';
import 'package:cubipool2/modules/reservation/presentation/provider/search_reservation_state.dart';
import 'package:cubipool2/modules/reservation/domain/entities/campus.dart';

const DEFAULT_RESERVATION_HOURS = [1, 2];
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
  Campus? _selectedCampus;
  DateTime? _selectedStartHour;
  int? _selectedHoursCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar cubículos'),
      ),
      body: SafeArea(
        child: _buildApp(),
      ),
    );
  }

  Widget _buildApp() {
    return ProviderListener<SearchReservationsState>(
      provider: reservationNotifierProvider.state,
      onChange: (context, state) async {
        if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is ReservationsFoundState) {
          Navigator.push<String>(
            context,
            MaterialPageRoute(
              builder: (context) => ReservationSearchResultsPage(
                reservations: state.reservations,
                campus: _selectedCampus!,
                startHour: _selectedStartHour!,
                hoursCount: _selectedHoursCount!,
              ),
            ),
          );

          context.read(reservationNotifierProvider).getInitialData();
        }
      },
      child: Consumer(
        builder: (context, watch, child) {
          final state = watch(reservationNotifierProvider.state);

          if (state is InitialState) {
            return _buildInitialState(context, state);
          } else if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildInitialState(
    BuildContext context,
    InitialState state,
  ) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 32.0),
          Image.asset('assets/logos/books.png'),
          const SizedBox(height: 32.0),
          _buildCampusDropdown(context, state.campus),
          const SizedBox(height: 16.0),
          _buildStartHour(context, state.startHours),
          const SizedBox(height: 16.0),
          _buildHoursCount(DEFAULT_RESERVATION_HOURS),
          const SizedBox(height: 16.0),
          _buildSearchButton(context),
        ],
      ),
    );
  }

  Widget _buildCampusDropdown(
    BuildContext context,
    List<Campus> campus,
  ) {
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
        items: campus
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(item.name),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildStartHour(
    BuildContext context,
    List<DateTime> startHours,
  ) {
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

  Widget _buildSearchButton(BuildContext context) {
    return ElevatedButton(
      onPressed: hasAllOptionsSelected()
          ? () {
              context.read(reservationNotifierProvider).searchCubicles(
                    _selectedCampus!,
                    _selectedStartHour!,
                    _selectedHoursCount!,
                  );
            }
          : null,
      child: Text('Buscar'),
    );
  }

  bool hasAllOptionsSelected() {
    return _selectedCampus != null &&
        _selectedHoursCount != null &&
        _selectedStartHour != null;
  }
}
