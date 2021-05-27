import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/search/domain/entities/campus.dart';

abstract class CampusRepositoryPublication {
  Future<Either<Failure, List<Campus>>> getAllCampus();
}
