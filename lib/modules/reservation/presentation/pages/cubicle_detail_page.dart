import 'package:cubipool2/modules/reservation/domain/entities/reservation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CubicleDetailpage extends StatefulWidget {
  const CubicleDetailpage({Key? key}) : super(key: key);

  @override
  _CubicleDetailpageState createState() => _CubicleDetailpageState();
}

class _CubicleDetailpageState extends State<CubicleDetailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle de cubículo'),
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
                      Icon(Icons.ac_unit),
                      const SizedBox(width: 8.0),
                      Text('Cubiculo 103'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.ac_unit),
                      const SizedBox(width: 8.0),
                      Text('10:00 - 12:00'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.ac_unit),
                      const SizedBox(width: 8.0),
                      Text('Campus Villa'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.ac_unit),
                      const SizedBox(width: 8.0),
                      Text('4 Asientos'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.ac_unit),
                      const SizedBox(width: 8.0),
                      Text('24/05/2021'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Spacer(),
              _buildActivationButton(context),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivationButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _isButtonActivated() ? _activateCubicle : null,
      style: _isButtonActivated()
          ? ElevatedButton.styleFrom(primary: Colors.green)
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer),
          const SizedBox(width: 8.0),
          Text('Activar - 00:55:00'),
        ],
      ),
    );
  }

  bool _isButtonActivated() {
    return false;
  }

  void _activateCubicle() {}
}
