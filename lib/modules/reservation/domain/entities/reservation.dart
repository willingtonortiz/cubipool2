import 'dart:convert';

class Reservation {
  final String id;
  final String code;
  final DateTime startHour;

  Reservation({
    required this.id,
    required this.code,
    required this.startHour,
  });

  @override
  String toString() =>
      'Reservation(id: $id, code: $code, startHour: $startHour)';

  Reservation copyWith({
    String? id,
    String? code,
    DateTime? startHour,
  }) {
    return Reservation(
      id: id ?? this.id,
      code: code ?? this.code,
      startHour: startHour ?? this.startHour,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'startHour': startHour.millisecondsSinceEpoch,
    };
  }

  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      id: map['id'],
      code: map['code'],
      startHour: DateTime.fromMillisecondsSinceEpoch(map['startHour']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Reservation.fromJson(String source) =>
      Reservation.fromMap(json.decode(source));
}
