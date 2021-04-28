import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/reservation/domain/entities/campus.dart';

abstract class CampusRepository {
  Future<Either<Failure, List<Campus>>> getAllCampus();
}
