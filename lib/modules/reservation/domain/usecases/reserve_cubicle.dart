import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/reservation/domain/repositories/reservations_repository.dart';
import 'package:dartz/dartz.dart';

class ReserveCubicleParams {
  final String cubicleId;
  final DateTime startTime;
  final DateTime endTime;

  ReserveCubicleParams({
    required this.cubicleId,
    required this.startTime,
    required this.endTime,
  });
}

class ReserveCubicle implements UseCase<void, ReserveCubicleParams> {
  final ReservationsRepository repository;

  ReserveCubicle(this.repository);

  @override
  Future<Either<Failure, void>> execute(ReserveCubicleParams params) async {
    return await repository.reserveCubicle(
      cubicleId: params.cubicleId,
      startTime: params.startTime,
      endTime: params.endTime,
    );
  }
}
