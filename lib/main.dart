import 'package:cubipool2/modules/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:cubipool2/modules/auth/pages/login_page.dart';
import 'package:cubipool2/modules/auth/pages/register_page.dart';
import 'package:cubipool2/modules/examples/pages/dio_example_page.dart';
import 'package:cubipool2/modules/examples/pages/qr_example_page.dart';
import 'package:cubipool2/modules/examples/pages/riverpod_example_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.red;
    final accentColor = primaryColor[700];

    return MaterialApp(
      title: 'CUBIPOOL',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 14.0),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: primaryColor,
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
      initialRoute: LoginPage.PAGE_ROUTE,
      routes: {
        LoginPage.PAGE_ROUTE: (context) => LoginPage(),
        RegisterPage.PAGE_ROUTE: (context) => RegisterPage(),
        HomePage.PAGE_ROUTE: (context) => HomePage(),

        // Examples
        QrExamplePage.PAGE_ROUTE: (context) => QrExamplePage(),
        RiverpodExampleAPage.PAGE_ROUTE: (context) => RiverpodExampleAPage(),
        DioExamplePage.PAGE_ROUTE: (context) => DioExamplePage(),
      },
    );
  }
}
