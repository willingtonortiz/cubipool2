import 'dart:convert';
import 'dart:io';

import 'package:cubipool2/modules/search/domain/repositories/publications_repository.dart';
import 'package:cubipool2/modules/search/infrastructure/dto/get_all_publications_response_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';

class PublicationsRepositoryImpl implements PublicationsRepository {
  @override
  Future<Either<Failure, List<GetAllPublicationsResponseItem>>>
      getAllPublications({
    required String campusId,
  }) async {
    final url = Uri.https(
      BASE_HOST,
      '/campuses/$campusId/publications',
      {
        "campusId": campusId,
      },
    );

    final token = await JwtService.getToken();
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != HttpStatus.ok) {
      final serverFailure = ServerFailure.fromMap(
        jsonDecode(response.body),
      );
      return Left(serverFailure);
    }
    final decodedBody = jsonDecode(response.body);
    final data = List<GetAllPublicationsResponseItem>.from(
      decodedBody.map((x) => GetAllPublicationsResponseItem.fromMap(x)),
    );
    return Right(data);
  }
}
