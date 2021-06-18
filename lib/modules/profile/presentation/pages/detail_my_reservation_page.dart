import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cubipool2/core/constants/reservation_status.dart';
import 'package:cubipool2/core/utils/reservation_status_translate.dart';
import 'package:cubipool2/shared/widgets/async_confirmation_dialog.dart';
import 'package:cubipool2/shared/widgets/notification_dialog.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/shared/models/response_error.dart';
import 'package:cubipool2/shared/pages/qr_code_scanner_page.dart';
import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';
import 'package:cubipool2/modules/profile/presentation/pages/share_cubicle_page.dart';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';

const Duration ACTIVATION_PERIOD = Duration(minutes: 10);

class DetailMyReservationPage extends StatefulWidget {
  final Reservation reservation;

  const DetailMyReservationPage({
    Key? key,
    required this.reservation,
  }) : super(key: key);

  @override
  _DetailMyReservationPaage createState() => _DetailMyReservationPaage();
}

class _DetailMyReservationPaage extends State<DetailMyReservationPage> {
  late Timer _timer;
  late DateTime startDate;
  late bool isReservationNotActive;

  @override
  void initState() {
    super.initState();
    final reservation = widget.reservation;
    isReservationNotActive = reservation.isNotActive();
    startDate = reservation.startDateTime;

    if (isReservationNotActive) {
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        final isActivationPeriodFinished =
            startDate.add(ACTIVATION_PERIOD).isBefore(DateTime.now());

        if (isActivationPeriodFinished) {
          _timer.cancel();
        }
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final reservation = widget.reservation;
    final formatter = DateFormat.Hm();
    final formattedStartHour =
        formatter.format(reservation.startDateTime.toLocal());
    final formattedEndHour =
        formatter.format(reservation.endDateTime.toLocal());

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de cubiculo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.biotech),
                        const SizedBox(width: 8.0),
                        Text(
                          'Cubiculo ${widget.reservation.cubicleCode}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time),
                        const SizedBox(width: 8.0),
                        Text('$formattedStartHour - $formattedEndHour'),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.business),
                        const SizedBox(width: 8.0),
                        Text(widget.reservation.campusName),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person),
                        const SizedBox(width: 8.0),
                        Text('${widget.reservation.seats} Asientos'),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.sticky_note_2_outlined),
                        const SizedBox(width: 8.0),
                        Text(ReservationStatusTranslate.getTranslation(
                            reservation.type)),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today),
                        const SizedBox(width: 8.0),
                        Text(widget.reservation.getDDMMYYYYStartDate()),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                _buildActivationButton(context, reservation),
                SizedBox(height: 10.0),
                _buildCancelReservationButton(context, reservation),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelReservationButton(
      BuildContext context, Reservation reservation) {
    if (reservation.type == ReservationStatus.NOT_ACTIVE) {
      return ElevatedButton(
        onPressed: _cancelReservation,
        style: ElevatedButton.styleFrom(primary: Colors.red),
        child: Text('Cancelar reserva'),
      );
    }
    return SizedBox();
  }

  Widget _buildActivationButton(BuildContext context, Reservation reservation) {
    if (reservation.isShared()) {
      // TODO: Show cancel button if shared
    }
    if (reservation.isActive()) {
      return ElevatedButton(
        onPressed: () => goToShareCubiclePage(context, reservation),
        child: Text('Compartir cubículo'),
      );
    }

    if (reservation.isNotActive()) {
      final isInActivationPeriod =
          isInsideActivationPeriod(reservation.startDateTime);

      return ElevatedButton(
        onPressed: isInActivationPeriod
            ? () => _activateCubicle(context, reservation)
            : null,
        style: ElevatedButton.styleFrom(primary: Colors.green),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.timer),
            const SizedBox(width: 8.0),
            Text('Activar ' + remainingTime),
          ],
        ),
      );
    }

    return SizedBox();
  }

  bool isInsideActivationPeriod(DateTime startDate) {
    final now = DateTime.now();
    final activationPeriodEnd = startDate.add(ACTIVATION_PERIOD);
    return (startDate.isBefore(now) && now.isBefore(activationPeriodEnd));
  }

  get remainingTime {
    final reservation = widget.reservation;
    late var endActive;
    late var activationPeriodEnd;
    if (DateTime.now().isBefore(reservation.startDateTime)) {
      endActive = reservation.startDateTime;
    } else {
      endActive = reservation.startDateTime.add(ACTIVATION_PERIOD);
    }
    activationPeriodEnd = endActive.difference(DateTime.now());

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(activationPeriodEnd.inHours);
    String twoDigitMinutes =
        twoDigits(activationPeriodEnd.inMinutes.remainder(60));
    String twoDigitSeconds =
        twoDigits(activationPeriodEnd.inSeconds.remainder(60));
    return '$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds';
  }

  void _cancelReservation() async {
    bool isCancelSuccessful = false;
    bool hasCancelled = false;
    final dialog = AsyncConfirmationDialog(
      title: 'Cancelación de Reserva',
      content: '¿Estás seguro que quieres cancelar esta reserva?',
      onOk: () async {
        final url =
            Uri.https(BASE_HOST, '/reservations/${widget.reservation.id}');
        final token = await JwtService.getToken();
        final response = await http.delete(
          url,
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == HttpStatus.ok) {
          isCancelSuccessful = true;
        }
      },
      onCancel: () async => hasCancelled = true,
    );
    await showDialog(
      context: context,
      builder: (context) => dialog,
      barrierDismissible: false,
    );
    if (hasCancelled) {
      return;
    }

    final notificationMessage =
        isCancelSuccessful ? 'Cancelación de Reserva ' : 'Algo salío mal... :c';

    final reserveNotification = NotificationDialog(
      title: notificationMessage,
      onOk: () async {
        if (isCancelSuccessful) {
          Navigator.of(context).pop();
        }
      },
    );
    await showDialog(
      context: context,
      builder: (context) => reserveNotification,
      barrierDismissible: false,
    );
  }

  void _activateCubicle(
    BuildContext context,
    Reservation reservation,
  ) async {
    try {
      late var errors;

      var activatorUsername = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (_) => QRCodeScannerPage(),
        ),
      );
      if (activatorUsername != null) {
        final url = Uri.https(
            BASE_HOST, '/reservations/${widget.reservation.id}/activate');
        final token = await JwtService.getToken();
        final response = await http.post(
          url,
          headers: {'Authorization': 'Bearer $token'},
          body: {
            "activatorUsername": activatorUsername,
          },
        );

        if (response.statusCode != HttpStatus.created) {
          errors = jsonDecode(response.body);
          var message = '';
          if (response.statusCode == 500) {
            message = errors['message'];
          } else {
            message = errors['errors'][0];
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Se activó su reserva correctamente'),
              backgroundColor: Colors.green,
            ),
          );
          setState(() => reservation.type = ReservationStatus.ACTIVE);
        }

        setState(() {
          isReservationNotActive = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se seleccionó un código QR')),
        );
      }
    } on ResponseError catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.firstError)),
      );
    }
  }

  void goToShareCubiclePage(BuildContext context, Reservation reservation) {
    Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => ShareCubiclePage(
          onSuccess: () {
            setState(() => reservation.type = ReservationStatus.SHARED);
          },
          reservation: reservation,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
