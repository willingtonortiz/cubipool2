import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/profile/domain/entities/point_history.dart';
import 'package:cubipool2/modules/profile/domain/repositories/points_repository.dart';
import 'package:dartz/dartz.dart';

class GetPointsHistory implements UseCase<List<PointHistory>, NoParams> {
  GetPointsHistory(this._repository);

  final PointsRepository _repository;

  @override
  Future<Either<Failure, List<PointHistory>>> execute(NoParams params) {
    return _repository.getPointsHistory();
  }
}
