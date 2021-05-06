import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/reservation/domain/entities/reservation.dart';
import 'package:cubipool2/modules/reservation/domain/repositories/reservations_repository.dart';

class SearchAllReservationsParams {
  final String campusId;
  final DateTime startHour;
  final int hoursCount;

  SearchAllReservationsParams({
    required this.campusId,
    required this.startHour,
    required this.hoursCount,
  });
}

class SearchAllReservations
    implements UseCase<List<Reservation>, SearchAllReservationsParams> {
  final ReservationsRepository _repository;

  SearchAllReservations(this._repository);

  @override
  Future<Either<Failure, List<Reservation>>> execute(
      SearchAllReservationsParams params) async {
    final reservationsEither = await _repository.getAllReservations(
      campusId: params.campusId,
      startHour: params.startHour,
      hoursCount: params.hoursCount,
    );

    return reservationsEither.fold(
      left,
      (values) {
        final parsedValues = values
            .map(
              (e) => Reservation(
                cubicleId: e.cubicleId,
                cubicleCode: e.cubicleCode,
                startHour: DateTime.parse(e.startTime),
                endHour: DateTime.parse(e.endTime),
              ),
            )
            .toList();

        return Right(parsedValues);
      },
    );
  }
}
