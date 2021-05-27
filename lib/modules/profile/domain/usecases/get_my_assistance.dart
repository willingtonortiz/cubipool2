import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/utils/extensions.dart';
import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';
import 'package:cubipool2/modules/profile/domain/repositories/assistance_repository.dart';

class GetMyAssistanceResult {
  final Reservation? active;
  final List<Reservation> reservations;

  GetMyAssistanceResult({
    this.active,
    required this.reservations,
  });
}

class GetMyAssistance implements UseCase<GetMyAssistanceResult, NoParams> {
  final AssistanceRepository repository;

  GetMyAssistance(this.repository);

  @override
  Future<Either<Failure, GetMyAssistanceResult>> execute(
    NoParams params,
  ) async {
    final either = await repository.getMyAssistance();
    return either.fold(left, getAssistanceResult);
  }

  Either<Failure, GetMyAssistanceResult> getAssistanceResult(
      List<Reservation> assists) {
    final mappedAssists = mapDatesToLocal(assists);
    final active = findActiveAssistance(mappedAssists);
    final oldAssistance = findOldAsissts(mappedAssists);

    final result = GetMyAssistanceResult(
      active: active,
      reservations: oldAssistance,
    );
    return Right(result);
  }

  List<Reservation> mapDatesToLocal(List<Reservation> assists) {
    return assists
        .map((item) => item.copyWith(
              startDateTime: item.startDateTime.toLocal(),
              endDateTime: item.endDateTime.toLocal(),
            ))
        .toList();
  }

  Reservation? findActiveAssistance(List<Reservation> assists) {
    // TODO: Find Active or Shared state
    return assists.firstWhereOrNull((item) => item.isActive());
  }

  List<Reservation> findOldAsissts(List<Reservation> assists) {
    return assists.where((item) => !item.isActive()).toList();
  }
}
