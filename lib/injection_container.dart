import 'package:get_it/get_it.dart';

import 'package:cubipool2/modules/reservation/domain/repositories/campus_repository.dart';
import 'package:cubipool2/modules/reservation/domain/usecases/get_all_campus.dart';
import 'package:cubipool2/modules/reservation/infrastructure/repositories/campus_repository_impl.dart';

final injector = GetIt.instance;

Future<void> init() async {
  // Use cases
  injector.registerLazySingleton(() => GetAllCampus(injector()));

  // Repositories
  injector.registerLazySingleton<CampusRepository>(
    () => CampusRepositoryImpl(),
  );
}
