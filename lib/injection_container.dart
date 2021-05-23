import 'package:cubipool2/modules/profile/domain/repositories/assistance_repository.dart';
import 'package:cubipool2/modules/profile/domain/usecases/get_my_assistance.dart';
import 'package:cubipool2/modules/profile/infrastructure/repositories/assistance_repository_impl.dart';
import 'package:cubipool2/modules/reservation/domain/usecases/reserve_cubicle.dart';
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
  injector.registerLazySingleton(() => ReserveCubicle(injector()));
  injector.registerLazySingleton(() => GetMyAssistance(injector()));

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
  injector.registerLazySingleton<AssistanceRepository>(
        () => AssistanceRepositoryImpl(),
  );
}
