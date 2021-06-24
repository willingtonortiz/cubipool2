import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/profile/domain/entities/point_history.dart';

abstract class PointsRepository {
  Future<Either<Failure, List<PointHistory>>> getPointsHistory();
}
