class Reservation {
  final String cubicleId;
  final String cubicleCode;
  final DateTime startHour;
  final DateTime endHour;

  Reservation({
    required this.cubicleId,
    required this.cubicleCode,
    required this.startHour,
    required this.endHour,
  });

  @override
  String toString() {
    return 'Reservation(cubicleId: $cubicleId, cubicleCode: $cubicleCode, startHour: $startHour, endHour: $endHour)';
  }
}
