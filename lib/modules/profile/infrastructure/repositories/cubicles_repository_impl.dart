import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:cubipool2/shared/extensions/int_status_code_extension.dart';
import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:cubipool2/modules/profile/domain/dtos/share_cubicle_info.dart';
import 'package:cubipool2/modules/profile/domain/repositories/cubicles_repository.dart';

class CubiclesRepositoryImpl implements CubiclesRepository {
  @override
  Future<Either<Failure, bool>> shareCubicle(
    ShareCubicleInfo information,
  ) async {
    try {
      final url = Uri.parse('$BASE_URL/publications');
      final token = await JwtService.getToken();
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: information.toJson(),
      );

      if (response.statusCode.isNotCreated) {
        final decoded = jsonDecode(response.body);
        final responseError = ServerFailure.fromMap(decoded);
        return Left(responseError);
      }

      return Right(true);
    } catch (e) {
      return Left(ServerFailure(['Error inesperado, inténtalo nuevamente']));
    }
  }
}
