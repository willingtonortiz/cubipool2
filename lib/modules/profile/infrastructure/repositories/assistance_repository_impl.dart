import 'dart:io';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:cubipool2/core/constants/user_reservation_role.dart';
import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';
import 'package:cubipool2/modules/profile/domain/repositories/assistance_repository.dart';

class _GetMyAssistanceResponse {
  final String cubicleCode;
  final String campusName;
  final String startDateTime;
  final String endDateTime;
  final int seats;
  final String type;
  final String reservationId;

  const _GetMyAssistanceResponse({
    required this.cubicleCode,
    required this.campusName,
    required this.startDateTime,
    required this.endDateTime,
    required this.seats,
    required this.type,
    required this.reservationId,
  });

  Map<String, dynamic> toMap() {
    return {
      'cubicleCode': cubicleCode,
      'campusName': campusName,
      'startDateTime': startDateTime,
      'endDateTime': endDateTime,
      'seats': seats,
      'type': type,
      'reservationId': reservationId,
    };
  }

  factory _GetMyAssistanceResponse.fromMap(Map<String, dynamic> map) {
    return _GetMyAssistanceResponse(
      cubicleCode: map['cubicleCode'],
      campusName: map['campusName'],
      startDateTime: map['startDateTime'],
      endDateTime: map['endDateTime'],
      seats: map['seats'],
      type: map['type'],
      reservationId: map['reservationId'],
    );
  }

  String toJson() => json.encode(toMap());
}

class AssistanceRepositoryImpl implements AssistanceRepository {
  @override
  Future<Either<Failure, List<Reservation>>> getMyAssistance() async {
    try {
      final url =
          '$BASE_URL/reservations/me?userReservationRoles=${UserReservationRole.GUEST}&userReservationRoles=${UserReservationRole.ACTIVATOR}';
      final uri = Uri.parse(url);
      final token = await JwtService.getToken();

      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      final decodedBody = jsonDecode(response.body);

      if (response.statusCode != HttpStatus.ok) {
        final responseError = ServerFailure.fromMap(decodedBody);
        return Left(responseError);
      }

      final data = List<_GetMyAssistanceResponse>.from(
        decodedBody.map((x) => _GetMyAssistanceResponse.fromMap(x)),
      );

      final assistance = data
          .map(
            (e) => Reservation(
              campusName: e.campusName,
              cubicleCode: e.cubicleCode,
              endDateTime: DateTime.parse(e.endDateTime),
              startDateTime: DateTime.parse(e.startDateTime),
              seats: e.seats,
              id: e.reservationId,
              type: e.type,
            ),
          )
          .toList();
      return Right(assistance);
    } catch (e) {
      return Left(ServerFailure(['Ocurrió un error, intente más tarde']));
    }
  }
}
