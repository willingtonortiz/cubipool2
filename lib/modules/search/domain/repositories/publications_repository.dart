import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/modules/search/infrastructure/dto/get_all_publications_response_dto.dart';

abstract class PublicationsRepository {
  Future<Either<Failure, List<GetAllPublicationsResponseItem>>>
      getAllPublications({
    required String campusId,
  });
}
