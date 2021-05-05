import 'dart:convert';

import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';

class GetAllReservationResponseDto {
  final List<Reservation> reservations;

  GetAllReservationResponseDto({
    required this.reservations,
  });

  Map<String, dynamic> toMap() {
    return {
      'reservations': reservations.map((x) => x.toMap()).toList(),
    };
  }

  factory GetAllReservationResponseDto.fromMap(List<dynamic> data) {
    return GetAllReservationResponseDto(
      reservations: List<Reservation>.from(
        data.map((x) => Reservation.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllReservationResponseDto.fromJson(String source) =>
      GetAllReservationResponseDto.fromMap(json.decode(source));
}
