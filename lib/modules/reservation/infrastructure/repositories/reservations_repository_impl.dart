import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:cubipool2/modules/reservation/domain/repositories/reservations_repository.dart';
import 'package:cubipool2/modules/reservation/infrastructure/dto/get_all_reservations_response_dto.dart';

class ReservationsRepositoryImpl implements ReservationsRepository {
  @override
  Future<Either<Failure, List<GetAllReservationsResponseItem>>>
      getAllReservations({
    required String campusId,
    required DateTime startHour,
    required int hoursCount,
  }) async {
    final url = Uri.https(
      BASE_HOST,
      '/campuses/$campusId/cubicles/available',
      {
        "campusId": campusId,
        "startHour": startHour.toIso8601String(),
        "hours": "$hoursCount",
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
    final data = List<GetAllReservationsResponseItem>.from(
      decodedBody.map((x) => GetAllReservationsResponseItem.fromMap(x)),
    );

    return Right(data);
  }

  @override
  Future<Either<Failure, void>> reserveCubicle({
    required String cubicleId,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final url = Uri.parse('$BASE_URL/reservations');
    final token = await JwtService.getToken();
    final response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token'},
      body: {
        "cubicleId": cubicleId,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String()
      },
    );

    print(startTime.toIso8601String());
    print(endTime.toIso8601String());
    if (response.statusCode != HttpStatus.created) {
      final responseError = ServerFailure.fromMap(
        jsonDecode(response.body),
      );
      return Left(responseError);
    }
    return Right(null);
  }
}
