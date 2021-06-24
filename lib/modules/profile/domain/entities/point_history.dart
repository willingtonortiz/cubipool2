import 'dart:convert';

class PointHistory {
  final String name;
  final int points;
  final String date;

  PointHistory({
    required this.name,
    required this.points,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'points': points,
      'date': date,
    };
  }

  factory PointHistory.fromMap(Map<String, dynamic> map) {
    return PointHistory(
      name: map['name'],
      points: map['points'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PointHistory.fromJson(String source) =>
      PointHistory.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PointHistory &&
        other.name == name &&
        other.points == points &&
        other.date == date;
  }

  @override
  int get hashCode => name.hashCode ^ points.hashCode ^ date.hashCode;

  @override
  String toString() =>
      'PointHistory(name: $name, points: $points, date: $date)';
}
