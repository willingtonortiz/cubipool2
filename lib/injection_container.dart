import 'package:get_it/get_it.dart';

import 'package:cubipool2/modules/reservation/domain/repositories/reservations_repository.dart';
import 'package:cubipool2/modules/reservation/domain/usecases/search_all_reservations.dart';
import 'package:cubipool2/modules/reservation/infrastructure/repositories/reservations_repository_impl.dart';
import 'package:cubipool2/modules/reservation/domain/repositories/campus_repository.dart';
import 'package:cubipool2/modules/reservation/domain/usecases/get_all_campus.dart';
import 'package:cubipool2/modules/reservation/infrastructure/repositories/campus_repository_impl.dart';

import 'modules/profile/domain/repositories/reservations_repository.dart';
import 'modules/profile/domain/usecases/get_all_reservations.dart';
import 'modules/profile/infrastructure/repositories/reservation_repository_impl.dart';

final injector = GetIt.instance;

Future<void> init() async {
  /* ===== RESERVATIONS ===== */
  // Use cases
  injector.registerLazySingleton(() => GetAllCampus(injector()));
  injector.registerLazySingleton(() => GetAllReservations(injector()));
  injector.registerLazySingleton(() => SearchAllReservations(injector()));

  // Repositories
  injector.registerLazySingleton<CampusRepository>(
    () => CampusRepositoryImpl(),
  );
  injector.registerLazySingleton<MyReservationRepository>(
    () => ReservationRepositoryImpl(),
  );
  injector.registerLazySingleton<ReservationsRepository>(
    () => ReservationsRepositoryImpl(),
  );
}
