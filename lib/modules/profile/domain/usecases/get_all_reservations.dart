import 'package:dartz/dartz.dart';

import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';
import 'package:cubipool2/modules/profile/domain/repositories/reservations_repository.dart';
import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/core/utils/extensions.dart';

class GetMyReservationsResult {
  final Reservation? active;
  final List<Reservation> reservations;

  GetMyReservationsResult({
    this.active,
    required this.reservations,
  });
}

class GetAllReservations implements UseCase<GetMyReservationsResult, NoParams> {
  final MyReservationRepository repository;

  GetAllReservations(this.repository);

  @override
  Future<Either<Failure, GetMyReservationsResult>> execute(
      NoParams params) async {
    final either = await repository.getAllReservations();
    return either.fold(left, getReservationsResult);
  }

  Either<Failure, GetMyReservationsResult> getReservationsResult(
      List<Reservation> assists) {
    final mappedAssists = mapDatesToLocal(assists);
    final active = findActiveReservation(mappedAssists);
    final oldAssistance = findOldReservations(mappedAssists);

    final result = GetMyReservationsResult(
      active: active,
      reservations: oldAssistance,
    );
    return Right(result);
  }

  List<Reservation> mapDatesToLocal(List<Reservation> reservations) {
    return reservations
        .map((item) => item.copyWith(
              startDateTime: item.startDateTime.toLocal(),
              endDateTime: item.endDateTime.toLocal(),
            ))
        .toList();
  }

  Reservation? findActiveReservation(List<Reservation> reservations) {
    return reservations.firstWhereOrNull(
        (item) => item.isActive() || item.isNotActive() || item.isShared());
  }

  List<Reservation> findOldReservations(List<Reservation> reservations) {
    return reservations
        .where((item) => item.isCancelled() || item.isFinished())
        .toList();
  }
}
