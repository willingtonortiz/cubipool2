import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';
import 'package:cubipool2/modules/profile/domain/repositories/assistance_repository.dart';

final assistsData = [
  Reservation(
    id: '1',
    cubicleCode: '103',
    campusName: 'Villa',
    startDateTime: DateTime.utc(2021, 5, 23, 15),
    endDateTime: DateTime.utc(2021, 5, 23, 16),
    seats: 4,
    type: ReservationStatus.SHARED,
  ),
  Reservation(
    id: '2',
    cubicleCode: '104',
    campusName: 'Villa',
    startDateTime: DateTime.utc(2021, 5, 23, 15),
    endDateTime: DateTime.utc(2021, 5, 23, 16),
    seats: 4,
    type: ReservationStatus.ACTIVE,
  ),
  Reservation(
    id: '3',
    cubicleCode: '105',
    campusName: 'Villa',
    startDateTime: DateTime.utc(2021, 5, 23, 15),
    endDateTime: DateTime.utc(2021, 5, 23, 16),
    seats: 4,
    type: ReservationStatus.SHARED,
  ),
];

class AssistanceRepositoryImpl implements AssistanceRepository {
  @override
  Future<Either<Failure, List<Reservation>>> getMyAssistance() async {
    // TODO: Add roles to url
    final url =
        Uri.parse('$BASE_URL/reservations/me?userReservationRoles=OWNER');

    final token = await JwtService.getToken();
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    final decodedBody = jsonDecode(response.body);
    if (response.statusCode != HttpStatus.ok) {
      final responseError = ServerFailure.fromMap(decodedBody);
      return Left(responseError);
    }

    // final data =
    //     GetAllReservationResponseDto.fromMap(decodedBody);
    // return Left(ServerFailure(['Error inesperado']));
    return Right(assistsData);
  }
}
