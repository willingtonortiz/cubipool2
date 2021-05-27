import 'package:cubipool2/modules/search/domain/entities/campus.dart';
import 'package:cubipool2/modules/search/domain/entities/publication.dart';
import 'package:cubipool2/modules/search/domain/usecases/get_all_campus.dart';
import 'package:cubipool2/modules/search/domain/usecases/search_all_publications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';

// States

abstract class SearchPublicationsState {
  const SearchPublicationsState();
}

class InitialState extends SearchPublicationsState {
  final List<Campus> campus;

  const InitialState(this.campus);
}

class PublicationsFoundState extends SearchPublicationsState {
  final List<Publication> publications;

  PublicationsFoundState(this.publications);
}

class LoadingState extends SearchPublicationsState {}

class ErrorState extends SearchPublicationsState {
  final String message;
  const ErrorState(this.message);
}

class PublicationNotifier extends StateNotifier<SearchPublicationsState> {
  final GetAllCampusPublications _getAllCampus;
  final SearchAllPublications _searchAllPublications;

  PublicationNotifier(
    this._getAllCampus,
    this._searchAllPublications,
  ) : super(LoadingState()) {
    getInitialData();
  }

  Future<void> getInitialData() async {
    state = LoadingState();

    final campusEither = await _getAllCampus.execute(NoParams());

    state = campusEither.fold(
      _mapFailureToMessage,
      (values) => InitialState(
        values,
      ),
    );
  }

  Future<void> searchPublications(
    Campus campus,
    int hoursCount,
  ) async {
    state = LoadingState();

    final reservationsEither = await _searchAllPublications.execute(
      SearchAllPublicationsParams(
        campusId: campus.id,
        hoursCount: hoursCount,
      ),
    );

    reservationsEither.fold(
      _mapFailureToMessage,
      (publications) {
        state = PublicationsFoundState(publications);
      },
    );
  }

  ErrorState _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return ErrorState(failure.firstError);
    }

    return ErrorState('Error inesperado');
  }
}
