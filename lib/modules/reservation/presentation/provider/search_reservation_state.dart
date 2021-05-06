import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/reservation/domain/entities/reservation.dart';
import 'package:cubipool2/modules/reservation/domain/usecases/search_all_reservations.dart';
import 'package:cubipool2/modules/reservation/presentation/pages/search_reservation_page.dart';
import 'package:cubipool2/modules/reservation/domain/entities/campus.dart';
import 'package:cubipool2/modules/reservation/domain/usecases/get_all_campus.dart';

// States

abstract class SearchReservationsState {
  const SearchReservationsState();
}

class InitialState extends SearchReservationsState {
  final List<Campus> campus;
  final List<DateTime> startHours;

  const InitialState(this.campus, this.startHours);
}

class ReservationsFoundState extends SearchReservationsState {
  final List<Reservation> reservations;

  ReservationsFoundState(this.reservations);
}

class LoadingState extends SearchReservationsState {}

class ErrorState extends SearchReservationsState {
  final String message;
  const ErrorState(this.message);
}

class ReservationNotifier extends StateNotifier<SearchReservationsState> {
  final GetAllCampus _getAllCampus;
  final SearchAllReservations _searchAllReservations;

  ReservationNotifier(
    this._getAllCampus,
    this._searchAllReservations,
  ) : super(LoadingState()) {
    getInitialData();
  }

  Future<void> getInitialData() async {
    state = LoadingState();

    final campusEither = await _getAllCampus.execute(NoParams());
    final startHoursList = generateDateStartHoursList();

    state = campusEither.fold(
      _mapFailureToMessage,
      (values) => InitialState(
        values,
        startHoursList,
      ),
    );
  }

  Future<void> searchCubicles(
    Campus campus,
    DateTime startHour,
    int hoursCount,
  ) async {
    state = LoadingState();

    final reservationsEither = await _searchAllReservations.execute(
      SearchAllReservationsParams(
        campusId: campus.id,
        startHour: startHour,
        hoursCount: hoursCount,
      ),
    );

    reservationsEither.fold(
      _mapFailureToMessage,
      (reservations) {
        state = ReservationsFoundState(reservations);
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
