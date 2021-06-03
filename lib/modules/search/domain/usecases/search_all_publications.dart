import 'package:cubipool2/modules/search/domain/entities/publication.dart';
import 'package:cubipool2/modules/search/domain/repositories/publications_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';

class SearchAllPublicationsParams {
  final String campusId;

  SearchAllPublicationsParams({
    required this.campusId,
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
    );

    return publicationsEither.fold(
      left,
      (values) {
        final parsedValues = values.map(
          (e) {
            final startHour = DateTime.parse(e.startTime).toLocal();
            final endHour = DateTime.parse(e.endTime).toLocal();

            return Publication(
              publicationId: e.publicationId,
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
