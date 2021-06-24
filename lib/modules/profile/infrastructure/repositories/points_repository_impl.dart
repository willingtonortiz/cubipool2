import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:cubipool2/modules/profile/domain/entities/point_history.dart';
import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:cubipool2/modules/profile/domain/repositories/points_repository.dart';

class PointsRepositoryImpl implements PointsRepository {
  @override
  Future<Either<Failure, List<PointHistory>>> getPointsHistory() async {
    try {
      final url = Uri.parse('$BASE_URL/users/points');
      final token = await JwtService.getToken();
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode != HttpStatus.ok) {
        final responseError = ServerFailure.fromMap(decoded);
        return Left(responseError);
      }

      final result =
          List<PointHistory>.from(decoded.map((x) => PointHistory.fromMap(x)));

      return Right(result);
    } catch (e) {
      return Left(ServerFailure(['Ha ocurrido un error inesperado']));
    }
  }
}
