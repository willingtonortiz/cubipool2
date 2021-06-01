import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/profile/domain/dtos/share_cubicle_info.dart';
import 'package:cubipool2/modules/profile/domain/repositories/cubicles_repository.dart';
import 'package:dartz/dartz.dart';

class ShareCubicleParams {
  final String reservationId;
  final int sharedSeats;
  final String description;

  ShareCubicleParams({
    required this.reservationId,
    required this.sharedSeats,
    required this.description,
  });

  ShareCubicleInfo toSharedCubicleInfo() {
    return ShareCubicleInfo(
      reservationId: reservationId,
      description: description,
      sharedSeats: sharedSeats,
    );
  }
}

class ShareCubicle implements UseCase<bool, ShareCubicleParams> {
  final CubiclesRepository repository;

  ShareCubicle(this.repository);

  @override
  Future<Either<Failure, bool>> execute(ShareCubicleParams params) {
    final info = params.toSharedCubicleInfo();
    return this.repository.shareCubicle(info);
  }
}
