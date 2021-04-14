import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static const PAGE_ROUTE = '/auth/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/auth/login');
              },
              child: Text('Iniciar sesión'),
            )
          ],
        ),
      ),
    );
  }
}
