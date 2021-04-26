import 'package:flutter/material.dart';

class ReservationDetailPage extends StatefulWidget {
  ReservationDetailPage({Key? key}) : super(key: key);

  @override
  _ReservationDetailPageState createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado de búsqueda'),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 2 / 3,
            child: Column(
              children: [
                const SizedBox(height: 32.0),
                Image.asset('assets/logos/books.png'),
                const SizedBox(height: 32.0),
                Row(
                  children: [
                    Icon(Icons.ac_unit),
                    const SizedBox(width: 8.0),
                    Text('Campus Villa'),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.ac_unit),
                    const SizedBox(width: 8.0),
                    Text('Cubículo 103'),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.ac_unit),
                    const SizedBox(width: 8.0),
                    Text('10:15 - 11:00'),
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Estaremos estudiando para la 3ra PC de cálculo 5, te esperamos con ganas de sacar 20!',
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Asistir'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
