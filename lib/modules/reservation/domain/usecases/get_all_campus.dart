import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/reservation/domain/entities/campus.dart';
import 'package:cubipool2/modules/reservation/domain/repositories/campus_repository.dart';

class GetAllCampus implements UseCase<List<Campus>, NoParams> {
  final CampusRepository repository;

  GetAllCampus(this.repository);

  @override
  Future<Either<Failure, List<Campus>>> execute(NoParams params) async {
    return await repository.getAllCampus();
  }
}
