import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/search/domain/entities/campus.dart';
import 'package:cubipool2/modules/search/domain/repositories/campus_repository.dart';

class GetAllCampusPublications implements UseCase<List<Campus>, NoParams> {
  final CampusRepositoryPublication repository;

  GetAllCampusPublications(this.repository);

  @override
  Future<Either<Failure, List<Campus>>> execute(NoParams params) async {
    return await repository.getAllCampus();
  }
}
