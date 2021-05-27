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
        final parsedValues = values.map(
          (e) {
            final startHour = DateTime.parse(e.startTime).toLocal();
            final endHour =
                DateTime.parse(e.startTime).add(Duration(hours: 2)).toLocal();

            return Reservation(
              cubicleId: e.cubicleId,
              cubicleCode: e.cubicleCode,
              startHour: startHour,
              endHour: endHour,
            );
          },
        ).toList();

        return Right(parsedValues);
      },
    );
  }
}
