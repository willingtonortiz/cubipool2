import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeViewerPage extends StatelessWidget {
  final String data;
  const QRCodeViewerPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Código QR'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 32.0),
              QrImage(
                data: data,
                size: 300.0,
                version: QrVersions.auto,
              ),
              Flexible(child: Container()),
              ElevatedButton(
                onPressed: () => popPage(context),
                child: Text('Volver'),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }

  void popPage(BuildContext context) {
    Navigator.of(context).pop();
  }
}
