import 'package:cubipool2/core/error/failures.dart';
import 'package:cubipool2/core/usecases/usecase.dart';
import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';
import 'package:cubipool2/modules/profile/domain/usecases/get_all_reservations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class ProfileState {
  const ProfileState();
}

class InitialState extends ProfileState {}

class MyReservationsState extends ProfileState {
  final List<Reservation> reservations;

  MyReservationsState(this.reservations);
}

class CodeQRState extends ProfileState {}

class ScanCodeQRState extends ProfileState {}

class LogOutState extends ProfileState {}

class LoadingState extends ProfileState {}

class ErrorState extends ProfileState {
  final String message;
  const ErrorState(this.message);
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  final GetAllReservations _getAllReservations;
  ProfileNotifier(this._getAllReservations) : super(LoadingState()) {
    getInitialData();
  }

  Future<void> getInitialData() async {
    state = LoadingState();

    state = InitialState();
  }

  Future<void> getAllReservations() async {
    if (state is InitialState) {
      state = LoadingState();

      final reservationsEither = await _getAllReservations.execute(NoParams());

      reservationsEither.fold(
        _mapFailureToMessage,
        (reservations) => {state = MyReservationsState(reservations)},
      );
    }
  }

  ErrorState _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return ErrorState(failure.firstError);
    }

    return ErrorState('Error inesperado');
  }
}
