import 'package:get_it/get_it.dart';

// Repositories
import 'modules/profile/domain/repositories/rewards_repository.dart';
import 'modules/profile/infrastructure/repositories/rewards_repository_impl.dart';
import 'modules/profile/domain/repositories/assistance_repository.dart';
import 'modules/profile/infrastructure/repositories/assistance_repository_impl.dart';
import 'modules/profile/domain/repositories/cubicles_repository.dart';
import 'modules/profile/infrastructure/repositories/cubicles_repository_impl.dart';
import 'modules/profile/domain/repositories/reservations_repository.dart';
import 'modules/profile/infrastructure/repositories/reservation_repository_impl.dart';

import 'modules/search/domain/repositories/campus_repository.dart';
import 'modules/search/infrastructure/repositories/campus_repository_impl.dart';
import 'modules/search/domain/repositories/publications_repository.dart';
import 'modules/search/infrastructure/repositories/publications_repository_impl.dart';

import 'modules/reservation/domain/repositories/campus_repository.dart';
import 'modules/reservation/infrastructure/repositories/campus_repository_impl.dart';
import 'modules/reservation/domain/repositories/reservations_repository.dart';
import 'modules/reservation/infrastructure/repositories/reservations_repository_impl.dart';

// UseCases
import 'modules/profile/domain/usecases/get_all_reservations.dart';
import 'modules/profile/domain/usecases/get_my_assistance.dart';
import 'modules/search/domain/usecases/get_all_campus.dart';
import 'modules/search/domain/usecases/search_all_publications.dart';
import 'modules/reservation/domain/usecases/get_all_campus.dart';
import 'modules/reservation/domain/usecases/search_all_reservations.dart';
import 'modules/reservation/domain/usecases/reserve_cubicle.dart';
import 'package:cubipool2/modules/profile/domain/usecases/share_cubicle.dart';
import 'package:cubipool2/modules/profile/domain/usecases/get_available_rewards.dart';

final injector = GetIt.instance;

Future<void> init() async {
  /* ===== RESERVATIONS ===== */

  // Repositories
  injector.registerLazySingleton<CampusRepository>(
    () => CampusRepositoryImpl(),
  );
  injector.registerLazySingleton<CampusRepositoryPublication>(
    () => CampusRepositoryPublicationImpl(),
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
  injector.registerLazySingleton<PublicationsRepository>(
    () => PublicationsRepositoryImpl(),
  );
  injector.registerLazySingleton<CubiclesRepository>(
    () => CubiclesRepositoryImpl(),
  );
  injector.registerLazySingleton<RewardsRepository>(
    () => RewardsRepositoryImpl(),
  );

  // Use cases
  injector.registerLazySingleton(() => GetAllCampus(injector()));
  injector.registerLazySingleton(() => GetAllReservations(injector()));
  injector.registerLazySingleton(() => SearchAllReservations(injector()));
  injector.registerLazySingleton(() => ReserveCubicle(injector()));
  injector.registerLazySingleton(() => GetMyAssistance(injector()));
  injector.registerLazySingleton(() => GetAllCampusPublications(injector()));
  injector.registerLazySingleton(() => SearchAllPublications(injector()));
  injector.registerLazySingleton(() => ShareCubicle(injector()));
  injector.registerLazySingleton(() => GetAvailableRewards(injector()));
}
