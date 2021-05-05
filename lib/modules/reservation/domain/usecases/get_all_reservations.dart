import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/reservation/domain/entities/reservation.dart';
import 'package:cubipool2/modules/reservation/domain/repositories/reservations_repository.dart';

class GetAllReservationsParams {
  final String campusId;
  final DateTime startHour;
  final int hoursCount;

  GetAllReservationsParams({
    required this.campusId,
    required this.startHour,
    required this.hoursCount,
  });
}

class SearchAllReservations
    implements UseCase<List<Reservation>, GetAllReservationsParams> {
  final ReservationsRepository repository;

  SearchAllReservations(this.repository);

  @override
  Future<Either<Failure, List<Reservation>>> execute(
      GetAllReservationsParams params) async {
    return repository.getAllReservations(
      campusId: params.campusId,
      startHour: params.startHour,
      hoursCount: params.hoursCount,
    );
  }
}
