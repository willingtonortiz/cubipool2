import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/profile/domain/entities/reward.dart';
import 'package:cubipool2/modules/profile/domain/repositories/rewards_repository.dart';
import 'package:dartz/dartz.dart';

class ClaimRewardParams {
  ClaimRewardParams({
    required this.reward,
    required this.availablePoints,
  });

  final Reward reward;
  final int availablePoints;
}

class ClaimReward implements UseCase<bool, ClaimRewardParams> {
  const ClaimReward(this._repository);

  final RewardsRepository _repository;

  @override
  Future<Either<Failure, bool>> execute(ClaimRewardParams params) async {
    final availablePoints = params.availablePoints;
    final reward = params.reward;

    if (availablePoints < reward.points) {
      return Left(ServerFailure(['No tiene suficiente puntos']));
    }

    return _repository.claimReward(reward.id);
  }
}
