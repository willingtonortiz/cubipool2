import 'dart:convert';

import 'package:cubipool2/modules/reservation/domain/entities/campus.dart';

class GetAllCampusResponseDto {
  final List<Campus> campus;

  GetAllCampusResponseDto({
    required this.campus,
  });

  Map<String, dynamic> toMap() {
    return {
      'campus': campus.map((x) => x.toMap()).toList(),
    };
  }

  factory GetAllCampusResponseDto.fromMap(Map<String, dynamic> map) {
    return GetAllCampusResponseDto(
      campus: List<Campus>.from(
        map['campus']?.map((x) => Campus.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllCampusResponseDto.fromJson(String source) =>
      GetAllCampusResponseDto.fromMap(json.decode(source));
}
