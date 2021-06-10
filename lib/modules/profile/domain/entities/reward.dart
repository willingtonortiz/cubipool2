class Reward {
  final String id;
  final String name;
  final int points;
  final String description;
  final String type;

  Reward({
    required this.id,
    required this.name,
    required this.points,
    required this.description,
    required this.type,
  });

  @override
  String toString() {
    return 'Reward(id: $id, name: $name, points: $points, description: $description, type: $type)';
  }
}
