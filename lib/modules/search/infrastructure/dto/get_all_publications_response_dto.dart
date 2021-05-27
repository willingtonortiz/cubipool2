import 'dart:convert';

class GetAllPublicationsResponseItem {
  final String cubicleId;
  final String cubicleCode;
  final String description;
  final String startTime;
  final String endTime;

  GetAllPublicationsResponseItem({
    required this.cubicleId,
    required this.cubicleCode,
    required this.description,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'cubicleId': cubicleId,
      'cubicleCode': cubicleCode,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory GetAllPublicationsResponseItem.fromMap(Map<String, dynamic> map) {
    return GetAllPublicationsResponseItem(
      cubicleId: map['cubicleId'],
      cubicleCode: map['cubicleCode'],
      description: map['description'],
      startTime: map['startTime'],
      endTime: map['endTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllPublicationsResponseItem.fromJson(String source) =>
      GetAllPublicationsResponseItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetAllPublicationsResponseItem(cubicleId: $cubicleId, cubicleCode: $cubicleCode, description: $description, startTime: $startTime, endTime: $endTime)';
  }
}
