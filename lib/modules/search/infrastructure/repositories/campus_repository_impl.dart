import 'dart:io';
import 'dart:convert';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/search/domain/entities/campus.dart';
import 'package:cubipool2/modules/search/domain/repositories/campus_repository.dart';

class CampusRepositoryPublicationImpl implements CampusRepositoryPublication {
  @override
  Future<Either<Failure, List<Campus>>> getAllCampus() async {
    final url = Uri.parse('$BASE_URL/campuses');
    final token = await JwtService.getToken();
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != HttpStatus.ok) {
      final responseError = ServerFailure.fromMap(
        jsonDecode(response.body),
      );
      return Left(responseError);
    }

    final decodedBody = jsonDecode(response.body);

    final data = List<Campus>.from(decodedBody.map((x) => Campus.fromMap(x)));

    return Right(data);
  }
}
