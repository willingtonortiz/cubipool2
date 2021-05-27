import 'package:cubipool2/core/constants/reservation_status.dart';
import 'package:cubipool2/core/constants/reservation_status_spanish.dart';

class ReservationStatusTranslate {
  static const reserveStatesMap = {
    ReservationStatus.ACTIVE: ReservationStatusSpanish.ACTIVE,
    ReservationStatus.NOT_ACTIVE: ReservationStatusSpanish.NOT_ACTIVE,
    ReservationStatus.CANCELLED: ReservationStatusSpanish.CANCELLED,
    ReservationStatus.SHARED: ReservationStatusSpanish.SHARED,
    ReservationStatus.FINISHED: ReservationStatusSpanish.FINISHED
  };

  static getTranslation(String state) => reserveStatesMap[state];
}
