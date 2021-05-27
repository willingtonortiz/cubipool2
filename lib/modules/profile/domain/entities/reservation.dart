import 'dart:convert';

import 'package:cubipool2/core/constants/reservation_status.dart';
import 'package:intl/intl.dart';

class Reservation {
  final String id;
  final String cubicleCode;
  final String campusName;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final int seats;
  final String type;

  Reservation({
    required this.id,
    required this.cubicleCode,
    required this.campusName,
    required this.startDateTime,
    required this.endDateTime,
    required this.seats,
    required this.type,
  });

  bool isShared() => type == ReservationStatus.SHARED;
  bool isActive() => type == ReservationStatus.ACTIVE;
  bool isNotActive() => type == ReservationStatus.NOT_ACTIVE;
  bool isFinished() => type == ReservationStatus.FINISHED;
  bool isCancelled() => type == ReservationStatus.CANCELLED;

  String getDDMMYYYYStartDate() =>
      DateFormat('dd/MM/yyyy').format(startDateTime);

  String getHourInterval() =>
      '${startDateTime.hour}:00 - ${endDateTime.hour}:00';

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

  Reservation copyWith({
    String? id,
    String? cubicleCode,
    String? campusName,
    DateTime? startDateTime,
    DateTime? endDateTime,
    int? seats,
    String? type,
  }) {
    return Reservation(
      id: id ?? this.id,
      cubicleCode: cubicleCode ?? this.cubicleCode,
      campusName: campusName ?? this.campusName,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      seats: seats ?? this.seats,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reservation && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        cubicleCode.hashCode ^
        campusName.hashCode ^
        startDateTime.hashCode ^
        endDateTime.hashCode ^
        seats.hashCode ^
        type.hashCode;
  }
}
