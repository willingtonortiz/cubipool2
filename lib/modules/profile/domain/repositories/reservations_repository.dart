import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';
import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';

abstract class MyReservationRepository {
  Future<Either<Failure, List<Reservation>>> getAllReservations();
}
