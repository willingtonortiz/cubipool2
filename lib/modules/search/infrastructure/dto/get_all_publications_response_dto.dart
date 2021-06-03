import 'dart:convert';

class GetAllPublicationsResponseItem {
  final String publicationId;
  final String cubicleCode;
  final String description;
  final String startTime;
  final String endTime;

  GetAllPublicationsResponseItem({
    required this.publicationId,
    required this.cubicleCode,
    required this.description,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'publicationId': publicationId,
      'cubicleCode': cubicleCode,
      'description': description,
      'publicationStartTime': startTime,
      'publicationEndTime': endTime,
    };
  }

  factory GetAllPublicationsResponseItem.fromMap(Map<String, dynamic> map) {
    return GetAllPublicationsResponseItem(
      publicationId: map['publicationId'],
      cubicleCode: map['cubicleCode'],
      description: map['publicationDescription'],
      startTime: map['publicationStartTime'],
      endTime: map['publicationEndTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllPublicationsResponseItem.fromJson(String source) =>
      GetAllPublicationsResponseItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetAllPublicationsResponseItem(publicationId: $publicationId, cubicleCode: $cubicleCode, description: $description, startTime: $startTime, endTime: $endTime)';
  }
}
  