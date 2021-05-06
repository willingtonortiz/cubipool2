import 'dart:io';
import 'dart:convert';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:cubipool2/modules/reservation/infrastructure/dto/get_all_campus_response_dto.dart';
import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/reservation/domain/entities/campus.dart';
import 'package:cubipool2/modules/reservation/domain/repositories/campus_repository.dart';

class CampusRepositoryImpl implements CampusRepository {
  @override
  Future<Either<Failure, List<Campus>>> getAllCampus() async {
    // await Future.delayed(Duration(seconds: 2));

    // final campusList = [
    //   Campus(id: '1', name: 'VILLA'),
    //   Campus(id: '2', name: 'SAN MIGUEL'),
    //   Campus(id: '3', name: 'SAN ISIDRO'),
    //   Campus(id: '4', name: 'MONTERRICO'),
    // ];
    // return Right(campusList);

    final url = Uri.parse('$BASE_URL/campuses');
    final token = await JwtService().getToken();
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

    final decodeBody = jsonDecode(response.body);
    final data = List<Campus>.from(decodeBody.map((x) => Campus.fromMap(x)));

    return Right(data);
  }
}
