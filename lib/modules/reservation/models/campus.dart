class Campus {
  final String id;
  final String name;

  Campus({
    required this.id,
    required this.name,
  });

  @override
  String toString() => 'Campus(id: $id, name: $name)';
}
