import 'dart:io';
import 'dart:convert';
import 'package:cubipool2/modules/reservation/infrastructure/dto/get_all_reservations_response_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/modules/reservation/domain/entities/reservation.dart';
import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/reservation/domain/repositories/reservations_repository.dart';

class ReservationsRepositoryImpl implements ReservationsRepository {
  @override
  Future<Either<Failure, List<Reservation>>> getAllReservations({
    required String campusId,
    required DateTime startHour,
    required int hoursCount,
  }) async {
    // final url = Uri.https(
    //   BASE_URL,
    //   '/reservations',
    //   {
    //     "campusId": campusId,
    //     "startHour": startHour,
    //     "hoursCount": hoursCount,
    //   },
    // );
    // print(url);

    // final response = await http.get(url);
    // if (response.statusCode != HttpStatus.ok) {
    //   final serverFailure = ServerFailure.fromMap(
    //     jsonDecode(response.body),
    //   );
    //   return Left(serverFailure);
    // }

    // final data =
    //     GetAllReservationsResponseDto.fromMap(jsonDecode(response.body));
    // return Right(data.reservations);

    final results = List.generate(
      15,
      (index) => Reservation(
        id: '${index + 1}',
        code: 'CODE-${index + 1}',
        startHour: DateTime.now(),
      ),
    );
    return Right(results);
  }
}
