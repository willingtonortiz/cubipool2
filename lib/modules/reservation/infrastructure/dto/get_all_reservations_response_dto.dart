import 'dart:convert';

import 'package:cubipool2/modules/reservation/domain/entities/reservation.dart';

class GetAllReservationsResponseDto {
  final List<Reservation> reservations;

  GetAllReservationsResponseDto({
    required this.reservations,
  });

  Map<String, dynamic> toMap() {
    return {
      'reservations': reservations.map((x) => x.toMap()).toList(),
    };
  }

  factory GetAllReservationsResponseDto.fromMap(Map<String, dynamic> map) {
    return GetAllReservationsResponseDto(
      reservations: List<Reservation>.from(
          map['reservations']?.map((x) => Reservation.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllReservationsResponseDto.fromJson(String source) =>
      GetAllReservationsResponseDto.fromMap(json.decode(source));
}
