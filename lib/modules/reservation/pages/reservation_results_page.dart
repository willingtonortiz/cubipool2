import 'package:flutter/material.dart';

class ReservationResultsPage extends StatefulWidget {
  ReservationResultsPage({Key? key}) : super(key: key);

  @override
  _ReservationResultsPageState createState() => _ReservationResultsPageState();
}

class _ReservationResultsPageState extends State<ReservationResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado de búsqueda'),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
