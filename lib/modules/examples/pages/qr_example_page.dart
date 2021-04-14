import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrExamplePage extends StatefulWidget {
  static const PAGE_ROUTE = '/examples/qr';

  @override
  _QrExamplePageState createState() => _QrExamplePageState();
}

class _QrExamplePageState extends State<QrExamplePage> {
  String qrData = "example";
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            QrImage(
              data: qrData,
              size: 200.0,
              version: QrVersions.auto,
              foregroundColor: Colors.red,
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text',
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final text = _controller.text;
                setState(() {
                  qrData = text;
                });
              },
              child: Text('Generate QR code'),
            )
          ],
        ),
      ),
    );
  }
}
