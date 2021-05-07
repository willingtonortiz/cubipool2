import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';
import 'package:cubipool2/shared/models/response_error.dart';
import 'package:cubipool2/shared/pages/qr_code_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailMyReservationPaage extends StatefulWidget {
  final Reservation reservation;
  const DetailMyReservationPaage({
    Key? key,
    required this.reservation,
  }) : super(key: key);

  @override
  _DetailMyReservationPaage createState() => _DetailMyReservationPaage();
}

class _DetailMyReservationPaage extends State<DetailMyReservationPaage> {
  late Timer _timer;
  late DateTime startDateTime;
  late bool visibleButton;
  @override
  void initState() {
    super.initState();
    visibleButton = widget.reservation.type == 'NOT_ACTIVE';
    startDateTime = widget.reservation.startDateTime;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!startDateTime.add(Duration(minutes: 10)).isBefore(DateTime.now())) {
        setState(() {});
      } else {
        _timer.cancel();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de cubiculo'),
      ),
      body: SafeArea(
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
                      Icon(Icons.weekend),
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
                      Icon(Icons.timer),
                      const SizedBox(width: 8.0),
                      Text(widget.reservation.getHourInterval()),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.ac_unit),
                      const SizedBox(width: 8.0),
                      Text(widget.reservation.campusName),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.wheelchair_pickup_sharp),
                      const SizedBox(width: 8.0),
                      Text('${widget.reservation.seats} Asientos'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.dock_sharp),
                      const SizedBox(width: 8.0),
                      Text(widget.reservation.type),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_today),
                      const SizedBox(width: 8.0),
                      Text(widget.reservation.getDate()),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              visibleButton ? _buildActivationButton(context) : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivationButton(BuildContext context) {
    return ElevatedButton(
      onPressed: !_isButtonActivated() ? _activateCubicle : null,
      style: ElevatedButton.styleFrom(primary: Colors.green),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer),
          const SizedBox(width: 8.0),
          Text('Activar ' + timeRemaining),
        ],
      ),
    );
  }

  bool _isButtonActivated() {
    DateTime now = DateTime.now();
    DateTime endActive = startDateTime.add(Duration(minutes: 10));
    return (now.isAfter(startDateTime) && now.isBefore(endActive));
  }

  get timeRemaining {
    DateTime endActive =
        widget.reservation.startDateTime.add(Duration(minutes: 10));
    Duration difference = endActive.difference(DateTime.now());
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(difference.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(difference.inSeconds.remainder(60));
    return '${twoDigits(difference.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }

  void _activateCubicle() async {
    try {
      late var errors;
      var activatorUsername = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => QRCodeScannerPage(),
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
        if (response.statusCode != HttpStatus.ok) {
          errors = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errors['errors'][0])),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Se activó el su reserva correctamente'),
              backgroundColor: Colors.green,
            ),
          );
        }

        setState(() {
          visibleButton = false;
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
}
