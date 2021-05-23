import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';

abstract class AssistanceRepository {
  Future<Either<Failure, List<Reservation>>> getMyAssistance();
}
