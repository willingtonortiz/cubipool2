import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/reservation/domain/entities/reservation.dart';

abstract class ReservationsRepository {
  Future<Either<Failure, List<Reservation>>> getAllReservations({
    required String campusId,
    required DateTime startHour,
    required int hoursCount,
  });
}
