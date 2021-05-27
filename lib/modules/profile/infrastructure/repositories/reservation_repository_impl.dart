import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';
import 'package:cubipool2/modules/profile/domain/repositories/reservations_repository.dart';
import 'package:cubipool2/modules/profile/infrastructure/dto/get_all_reservations_response.dto.dart';

import 'package:cubipool2/core/error/failures.dart';

class ReservationRepositoryImpl implements MyReservationRepository {
  @override
  Future<Either<Failure, List<Reservation>>> getAllReservations() async {
    final url =
        Uri.parse('$BASE_URL/reservations/me?userReservationRoles=OWNER');
    final token = await JwtService.getToken();
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode != HttpStatus.ok) {
      final responseError = ServerFailure.fromMap(
        jsonDecode(response.body),
      );
      return Left(responseError);
    }

    final data =
        GetAllReservationResponseDto.fromMap(jsonDecode(response.body));
    return Right(data.reservations);
  }
}
