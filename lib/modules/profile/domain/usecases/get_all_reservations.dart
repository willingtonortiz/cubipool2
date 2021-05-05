import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';
import 'package:cubipool2/modules/profile/domain/repositories/reservations_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';

class GetAllReservations implements UseCase<List<Reservation>, NoParams> {
  final ReservationRepository repository;

  GetAllReservations(this.repository);

  @override
  Future<Either<Failure, List<Reservation>>> execute(NoParams params) async {
    return await repository.getAllReservations();
  }
}