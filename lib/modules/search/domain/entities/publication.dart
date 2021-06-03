class Publication {
  final String publicationId;
  final String cubicleCode;
  final String description;
  final DateTime startHour;
  final DateTime endHour;

  Publication({
    required this.publicationId,
    required this.cubicleCode,
    required this.description,
    required this.startHour,
    required this.endHour,
  });

  @override
  String toString() {
    return 'Publication(publicationId: $publicationId, cubicleCode: $cubicleCode, description: $description, startHour: $startHour, endHour: $endHour)';
  }
}
