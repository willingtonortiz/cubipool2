import 'package:cubipool2/modules/auth/services/auth_http_service.dart';
import 'package:cubipool2/modules/profile/presentation/pages/my_reservations_page.dart';
import 'package:cubipool2/modules/profile/presentation/provider/profile_state.dart';
import 'package:cubipool2/modules/profile/presentation/provider/providers.dart';
import 'package:flutter/material.dart';

import 'package:cubipool2/shared/pages/qr_code_scanner_page.dart';
import 'package:cubipool2/shared/pages/qr_code_viewer_page.dart';
import 'package:cubipool2/modules/auth/pages/login_page.dart';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
        child: _buildApp(),
      ),
    );
  }

  Widget _buildApp() {
    return ProviderListener<ProfileState>(
      provider: profileNotifierProvider.state,
      onChange: (context, state) async {
        if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is MyReservationsState) {

          await Navigator.push<String>(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MyReservationsPage(reservations: state.reservations),
            ),
          );

          context.read(profileNotifierProvider).getInitialData();
        }
      },
      child: Consumer(
        builder: (context, watch, child) {
          final state = watch(profileNotifierProvider.state);

          if (state is InitialState) {
            return _buildBody(context, state);
          } else if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    InitialState state,
  ) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: showMyReservations,
            child: Text('Mis reservas'),
          ),
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
    );
  }

  void logout() async {
    await JwtService.removeToken();
    await AuthHttpService.removeUserName();
    Navigator.pushReplacementNamed(context, LoginPage.PAGE_ROUTE);
  }

  void showMyReservations() {
    context.read(profileNotifierProvider).getAllReservations();
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

    print(result);
  }
}
