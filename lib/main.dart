import 'package:cubipool2/modules/auth/pages/register_page.dart';
import 'package:cubipool2/modules/examples/pages/dio_example_page.dart';
import 'package:cubipool2/modules/examples/pages/qr_example_page.dart';
import 'package:cubipool2/modules/examples/pages/riverpod_example_page.dart';
import 'package:flutter/material.dart';

import 'package:cubipool2/modules/auth/pages/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CUBIPOOL',
      theme: ThemeData(
        primaryColor: Color(0xff323232),
        accentColor: Color(0xff323232),
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 14.0),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 12.0,
            ),
            textStyle: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      // initialRoute: '/examples/qr',
      initialRoute: LoginPage.PAGE_ROUTE,
      // initialRoute: '/auth/login',
      routes: {
        LoginPage.PAGE_ROUTE: (context) => LoginPage(),
        RegisterPage.PAGE_ROUTE: (context) => RegisterPage(),
        QrExamplePage.PAGE_ROUTE: (context) => QrExamplePage(),
        RiverpodExampleAPage.PAGE_ROUTE: (context) => RiverpodExampleAPage(),
        DioExamplePage.PAGE_ROUTE: (context) => DioExamplePage(),
      },
    );
  }
}
