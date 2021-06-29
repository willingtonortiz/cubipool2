import 'package:dartz/dartz.dart';

import 'package:cubipool2/modules/profile/infrastructure/repositories/rewards_repository_impl.dart';
import 'package:cubipool2/core/error/failures.dart';

abstract class RewardsRepository {
  Future<Either<Failure, GetAvailableRewardsResponse>> getAvailableRewards();

  Future<Either<Failure, bool>> claimReward(String rewardId);
}
