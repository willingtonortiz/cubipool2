class User {
  final String studentCode;
  final int points;

  User({
    required this.studentCode,
    required this.points,
  });

  @override
  String toString() => 'User(studentCode: $studentCode, points: $points)';

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      studentCode: map['studentCode'],
      points: map['points'],
    );
  }
}
