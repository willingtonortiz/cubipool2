import 'package:cubipool2/modules/search/domain/entities/publication.dart';
import 'package:cubipool2/modules/search/domain/repositories/publications_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';

class SearchAllPublicationsParams {
  final String campusId;
  final int hoursCount;

  SearchAllPublicationsParams({
    required this.campusId,
    required this.hoursCount,
  });
}

class SearchAllPublications
    implements UseCase<List<Publication>, SearchAllPublicationsParams> {
  final PublicationsRepository _repository;

  SearchAllPublications(this._repository);

  @override
  Future<Either<Failure, List<Publication>>> execute(
      SearchAllPublicationsParams params) async {
    final publicationsEither = await _repository.getAllPublications(
      campusId: params.campusId,
      hoursCount: params.hoursCount,
    );

    return publicationsEither.fold(
      left,
      (values) {
        final parsedValues = values.map(
          (e) {
            final startHour = DateTime.parse(e.startTime).toLocal();
            final endHour =
                DateTime.parse(e.startTime).add(Duration(hours: 2)).toLocal();

            return Publication(
              cubicleId: e.cubicleId,
              cubicleCode: e.cubicleCode,
              description: e.description,
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
