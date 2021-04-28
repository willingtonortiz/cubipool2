import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cubipool2/injection_container.dart';
import 'package:cubipool2/modules/reservation/domain/usecases/get_all_campus.dart';
import 'package:cubipool2/modules/reservation/presentation/provider/reservation_state.dart';

final getAllCampus = injector.get<GetAllCampus>();

final getAllCampusProvider = Provider<GetAllCampus>((ref) => getAllCampus);

final reservationNotifierProvider = StateNotifierProvider(
  (ref) => ReservationNotifier(ref.watch(getAllCampusProvider)),
);
