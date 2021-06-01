import 'package:cubipool2/modules/profile/domain/dtos/share_cubicle_info.dart';
import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';

abstract class CubiclesRepository {
  Future<Either<Failure, bool>> shareCubicle(ShareCubicleInfo information);
}
