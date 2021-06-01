import 'dart:convert';

class ShareCubicleInfo {
  final String reservationId;
  final String description;
  final int sharedSeats;

  ShareCubicleInfo({
    required this.reservationId,
    required this.description,
    required this.sharedSeats,
  });

  Map<String, dynamic> toMap() {
    return {
      'reservationId': reservationId,
      'description': description,
      'sharedSeats': sharedSeats,
    };
  }

  factory ShareCubicleInfo.fromMap(Map<String, dynamic> map) {
    return ShareCubicleInfo(
      reservationId: map['reservationId'],
      description: map['description'],
      sharedSeats: map['sharedSeats'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShareCubicleInfo.fromJson(String source) =>
      ShareCubicleInfo.fromMap(json.decode(source));
}
