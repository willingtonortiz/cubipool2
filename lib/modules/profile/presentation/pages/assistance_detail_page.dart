import 'package:cubipool2/modules/profile/domain/entities/reservation.dart';
import 'package:flutter/material.dart';

class AssistanceDetailPage extends StatefulWidget {
  final Reservation assistance;

  AssistanceDetailPage({
    Key? key,
    required this.assistance,
  }) : super(key: key);

  @override
  _AssistanceDetailPageState createState() => _AssistanceDetailPageState();
}

class _AssistanceDetailPageState extends State<AssistanceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle de la asistancia')),
      body: SafeArea(
        child: Text('TEMP'),
      ),
    );
  }
}
