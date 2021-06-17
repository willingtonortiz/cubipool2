import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:cubipool2/modules/profile/domain/repositories/rewards_repository.dart';

class _Prize {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int pointsNeeded;

  _Prize({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.pointsNeeded,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'pointsNeeded': pointsNeeded,
    };
  }

  factory _Prize.fromMap(Map<String, dynamic> map) {
    return _Prize(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      pointsNeeded: map['pointsNeeded'],
    );
  }

  String toJson() => json.encode(toMap());
}

class GetAvailableRewardsResponse {
  final int userAvailablePoints;
  final List<_Prize> prizes;

  GetAvailableRewardsResponse({
    required this.userAvailablePoints,
    required this.prizes,
  });

  Map<String, dynamic> toMap() {
    return {
      'userAvailablePoints': userAvailablePoints,
      'prizes': prizes.map((x) => x.toMap()).toList(),
    };
  }

  factory GetAvailableRewardsResponse.fromMap(Map<String, dynamic> map) {
    return GetAvailableRewardsResponse(
      userAvailablePoints: map['userAvailablePoints'],
      prizes: List<_Prize>.from(map['prizes']?.map((x) => _Prize.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAvailableRewardsResponse.fromJson(String source) =>
      GetAvailableRewardsResponse.fromMap(json.decode(source));
}

class RewardsRepositoryImpl implements RewardsRepository {
  @override
  Future<Either<Failure, GetAvailableRewardsResponse>>
      getAvailableRewards() async {
    final url = '$BASE_URL/prizes';
    final uri = Uri.parse(url);
    final token = await JwtService.getToken();
    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    final decodedBody = jsonDecode(response.body);
    print(decodedBody);

    if (response.statusCode != HttpStatus.ok) {
      final responseError = ServerFailure.fromMap(decodedBody);
      return Left(responseError);
    }

    final data = GetAvailableRewardsResponse.fromMap(decodedBody);

    return Right(data);
  }
}
