class Publication {
  final String cubicleId;
  final String cubicleCode;
  final String description;
  final DateTime startHour;
  final DateTime endHour;

  Publication({
    required this.cubicleId,
    required this.cubicleCode,
    required this.description,
    required this.startHour,
    required this.endHour,
  });

  @override
  String toString() {
    return 'Publication(cubicleId: $cubicleId, cubicleCode: $cubicleCode, description: $description, startHour: $startHour, endHour: $endHour)';
  }
}
