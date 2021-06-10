import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/profile/domain/entities/reward.dart';
import 'package:cubipool2/modules/profile/domain/repositories/rewards_repository.dart';

class GetAvailableRewardsOutput {
  final int availablePoints;
  final List<Reward> rewards;

  GetAvailableRewardsOutput({
    required this.availablePoints,
    required this.rewards,
  });
}

class GetAvailableRewards
    implements UseCase<GetAvailableRewardsOutput, NoParams> {
  final RewardsRepository repository;

  GetAvailableRewards(this.repository);

  @override
  Future<Either<Failure, GetAvailableRewardsOutput>> execute(
    NoParams params,
  ) async {
    final result = await this.repository.getAvailableRewards();

    return result.fold(left, (data) {
      final mapped = GetAvailableRewardsOutput(
        availablePoints: data.userAvailablePoints,
        rewards: data.prizes
            .map((e) => Reward(
                  id: e.id,
                  name: e.name,
                  points: e.pointsNeeded,
                  description: e.description,
                  type: 'type',
                ))
            .toList(),
      );

      return Right(mapped);
    });
  }
}
