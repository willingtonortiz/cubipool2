import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerPage extends StatefulWidget {
  QRCodeScannerPage({Key? key}) : super(key: key);

  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();
    // if(Platform.isAncro){}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escanear Código QR'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Flexible(flex: 2, child: _buildQrView(context)),
              const SizedBox(height: 16.0),
              Text(
                'Apunta el código con la cámara',
                style: TextStyle(fontSize: 20.0),
              ),
              Flexible(child: Container()),
              ElevatedButton(
                onPressed: popPage,
                child: Text('Volver'),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Theme.of(context).primaryColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((barCode) async {
      await controller.pauseCamera();
      popPage(barCode.code);
    });
  }

  void popPage([String? data]) {
    Navigator.of(context).pop(data);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
