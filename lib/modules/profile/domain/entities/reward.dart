class Reward {
  final String id;
  final String name;
  final int points;
  final String description;
  final String imageUrl;

  Reward({
    required this.id,
    required this.name,
    required this.points,
    required this.description,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'Reward(id: $id, name: $name, points: $points, description: $description, imageUrl: $imageUrl)';
  }
}
