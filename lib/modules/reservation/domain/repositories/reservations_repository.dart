import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/reservation/infrastructure/dto/get_all_reservations_response_dto.dart';

abstract class ReservationsRepository {
  Future<Either<Failure, List<GetAllReservationsResponseItem>>>
      getAllReservations({
    required String campusId,
    required DateTime startHour,
    required int hoursCount,
  });
}
