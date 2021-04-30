import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cubipool2/injection_container.dart';
import 'package:cubipool2/modules/reservation/domain/usecases/get_all_reservations.dart';
import 'package:cubipool2/modules/reservation/domain/usecases/get_all_campus.dart';
import 'package:cubipool2/modules/reservation/presentation/provider/search_reservation_state.dart';

final getAllCampus = injector.get<GetAllCampus>();
final getAllReservations = injector.get<GetAllReservations>();

final getAllCampusProvider = Provider<GetAllCampus>((ref) => getAllCampus);
final getAllReservationsProvider =
    Provider<GetAllReservations>((ref) => getAllReservations);

final reservationNotifierProvider = StateNotifierProvider(
  (ref) => ReservationNotifier(
    ref.watch(getAllCampusProvider),
    ref.watch(getAllReservationsProvider),
  ),
);
