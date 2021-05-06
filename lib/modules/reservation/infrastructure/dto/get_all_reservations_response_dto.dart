import 'dart:convert';

class GetAllReservationsResponseItem {
  final String cubicleId;
  final String cubicleCode;
  final String startTime;
  final String endTime;

  GetAllReservationsResponseItem({
    required this.cubicleId,
    required this.cubicleCode,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'cubicleId': cubicleId,
      'cubicleCode': cubicleCode,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory GetAllReservationsResponseItem.fromMap(Map<String, dynamic> map) {
    return GetAllReservationsResponseItem(
      cubicleId: map['cubicleId'],
      cubicleCode: map['cubicleCode'],
      startTime: map['startTime'],
      endTime: map['endTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllReservationsResponseItem.fromJson(String source) =>
      GetAllReservationsResponseItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GetAllReservationsResponseItem(cubicleId: $cubicleId, cubicleCode: $cubicleCode, startTime: $startTime, endTime: $endTime)';
  }
}
