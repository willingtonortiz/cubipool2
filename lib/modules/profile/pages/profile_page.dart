import 'package:flutter/material.dart';

import 'package:cubipool2/modules/shared/pages/qr_code_viewer_page.dart';
import 'package:cubipool2/modules/shared/pages/qr_code_scanner_page.dart';

class ProfilePage extends StatefulWidget {
  static const PAGE_ROUTE = '/profile/qr';
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: showQRCode,
                child: Text('Código QR'),
              ),
              ElevatedButton(
                onPressed: scanQRCode,
                child: Text('Escanear Código QR'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showQRCode() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodeViewerPage(data: 'HOLA MUNDO'),
      ),
    );
  }

  void scanQRCode() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodeScannerPage(),
      ),
    );

    print(result);
  }
}
