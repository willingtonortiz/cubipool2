import 'dart:convert';

import 'package:cubipool2/core/utils/reservation_states.dart';
import 'package:intl/intl.dart';

class Reservation {
  final String id;
  final String cubicleCode;
  final String campusName;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final int seats;
  final ReserveStates type;

  Reservation({
    required this.id,
    required this.cubicleCode,
    required this.campusName,
    required this.startDateTime,
    required this.endDateTime,
    required this.seats,
    required this.type,
  });

  @override
  String toString() =>
      'Reservation(reservationId: $id, cubicleCode: $cubicleCode,campusName: $campusName, startDateTime: $startDateTime,endDateTime: $endDateTime,seats: $seats,type: $type)';

  Map<String, dynamic> toMap() {
    return {
      'reservationId': id,
      'cubicleCode': cubicleCode,
      'campusName': campusName,
      'startDateTime': startDateTime,
      'endDateTime': endDateTime,
      'seats': seats,
      'type': type,
    };
  }

  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      id: map['reservationId'],
      cubicleCode: map['cubicleCode'],
      campusName: map['campusName'],
      startDateTime: DateTime.parse(map['startDateTime']),
      endDateTime: DateTime.parse(map['endDateTime']),
      seats: map['seats'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Reservation.fromJson(String source) =>
      Reservation.fromMap(json.decode(source));

  String getDate() => DateFormat('dd/MM/yyyy').format(startDateTime);

  String getHourInterval() =>
      '${startDateTime.hour}:00 - ${endDateTime.hour}:00';
}
