import 'package:cubipool2/modules/profile/domain/usecases/get_all_reservations.dart';
import 'package:cubipool2/modules/profile/presentation/provider/profile_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cubipool2/injection_container.dart';

final getAllReservations = injector.get<GetAllReservations>();

final getAllReservationsProvider = Provider<GetAllReservations>((ref) => getAllReservations);

final profileNotifierProvider = StateNotifierProvider(
  (ref) => ProfileNotifier(ref.watch(getAllReservationsProvider)),
);
