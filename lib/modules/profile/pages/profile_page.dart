import 'package:flutter/material.dart';

import 'package:cubipool2/shared/pages/qr_code_scanner_page.dart';
import 'package:cubipool2/shared/pages/qr_code_viewer_page.dart';
import 'package:cubipool2/modules/auth/pages/login_page.dart';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';

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
              ElevatedButton(
                onPressed: logout,
                child: Text('Cerrar sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logout() {
    final jwtService = JwtService();
    jwtService.removeToken();
    Navigator.pushReplacementNamed(context, LoginPage.PAGE_ROUTE);
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
