import 'dart:convert';
import 'dart:io';

import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/core/constants/user_reservation_role.dart';
import 'package:cubipool2/modules/auth/services/auth_http_service.dart';
import 'package:cubipool2/modules/profile/domain/entities/user.dart';
import 'package:cubipool2/modules/profile/presentation/pages/my_assistance_page.dart';
import 'package:cubipool2/modules/profile/presentation/widgets/profile_option.dart';
import 'package:flutter/material.dart';

import 'package:cubipool2/shared/pages/qr_code_scanner_page.dart';
import 'package:cubipool2/shared/pages/qr_code_viewer_page.dart';
import 'package:cubipool2/modules/auth/pages/login_page.dart';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:http/http.dart' as http;
import 'my_reservations_page.dart';

class ProfilePage extends StatefulWidget {
  static const PAGE_ROUTE = '/profile/qr';
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
      ),
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(height: 10.0),
                Text(user.studentCode),
                Text(user.points.toString()),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                ProfileOption(onTap: showMyReservations, title: 'Mis reservas'),
                ProfileOption(
                    onTap: goToMyAssistancePage,
                    title: 'Cucículos a los que asistiré'),
                ProfileOption(onTap: () => {}, title: 'Recompensas'),
                ProfileOption(onTap: () => {}, title: 'Historial de Puntos'),
                ProfileOption(onTap: showQRCode, title: 'Mostrar código QR'),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: logout,
            child: Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }

  void logout() async {
    await JwtService.removeToken();
    await AuthHttpService.removeUserName();
    Navigator.pushReplacementNamed(context, LoginPage.PAGE_ROUTE);
  }

  void showMyReservations() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MyReservationsPage()),
    );
  }

  Future<void> showQRCode() async {
    String userName = (await AuthHttpService.getUserName())!;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodeViewerPage(data: userName),
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
  }

  void goToMyAssistancePage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MyAssistancePage()),
    );
  }

  @override
  void initState() {
    super.initState();
    user = new User(studentCode: '-', points: 0);
    setUser();
  }

  Future<void> setUser() async {
    final url = Uri.https(BASE_HOST, '/users');
    final token = await JwtService.getToken();
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode != HttpStatus.ok) {
      var errors = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errors['errors'][0])),
      );
    } else {
      user = User.fromMap(jsonDecode(response.body));
      print(user);
      setState(() {});
    }
  }
}
