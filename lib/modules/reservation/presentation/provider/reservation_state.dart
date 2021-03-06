import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/reservation/presentation/pages/reservation_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cubipool2/modules/reservation/domain/entities/campus.dart';
import 'package:cubipool2/modules/reservation/domain/usecases/get_all_campus.dart';

// States

abstract class ReservationState {
  const ReservationState();
}

class InitialState extends ReservationState {
  final List<Campus> campus;
  final List<DateTime> startHours;

  const InitialState(this.campus, this.startHours);
}

class CubiclesFoundState extends ReservationState {}

class LoadingState extends ReservationState {}

class ErrorState extends ReservationState {
  final String message;
  const ErrorState(this.message);
}

class ReservationNotifier extends StateNotifier<ReservationState> {
  final GetAllCampus _getAllCampus;

  ReservationNotifier(this._getAllCampus) : super(LoadingState()) {
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
    DateTime dateTime,
    int hoursCount,
  ) async {
    if (state is InitialState) {
      state = LoadingState();

      await Future.delayed(Duration(seconds: 2));

      state = CubiclesFoundState();

      // state = InitialState(
      //   [],
      //   [],
      // );
    }
  }

  ErrorState _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return ErrorState(failure.firstError);
    }

    return ErrorState('Error inesperado');
  }
}
