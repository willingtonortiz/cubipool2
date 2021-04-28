import 'dart:convert';

class Campus {
  final String id;
  final String name;

  Campus({
    required this.id,
    required this.name,
  });

  @override
  String toString() => 'Campus(id: $id, name: $name)';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Campus.fromMap(Map<String, dynamic> map) {
    return Campus(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Campus.fromJson(String source) => Campus.fromMap(json.decode(source));
}
