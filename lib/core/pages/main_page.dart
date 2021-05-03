import 'package:flutter/material.dart';

// Services
import 'package:cubipool2/modules/auth/services/jwt_service.dart';

// Pages
import 'package:cubipool2/modules/auth/pages/login_page.dart';
import 'package:cubipool2/modules/auth/pages/register_page.dart';
import 'package:cubipool2/modules/home/pages/home_page.dart';
import 'package:cubipool2/shared/pages/not_found_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'CUBIPOOL';
    final primaryColor = Colors.red;
    final accentColor = primaryColor[700];
    final themeData = ThemeData(
      primaryColor: primaryColor,
      accentColor: accentColor,
      appBarTheme: AppBarTheme(
        centerTitle: true,
      ),
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
            fontSize: 18.0,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: primaryColor),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(primary: primaryColor),
      ),
    );

    return FutureBuilder(
      future: checkIfUserIsLoggedIn(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        final materialApp = _buildMaterialApp(appTitle, themeData);

        if (snapshot.connectionState == ConnectionState.waiting) {
          return materialApp('loading');
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!) {
            return materialApp(HomePage.PAGE_ROUTE);
          } else {
            return materialApp(LoginPage.PAGE_ROUTE);
          }
        } else {
          return NotFoundPage(message: 'Página no encontrada');
        }
      },
    );
  }

  MaterialApp Function(String initialPage) _buildMaterialApp(
    String appTitle,
    ThemeData themeData,
  ) =>
      (String initialPage) {
        return MaterialApp(
          key: UniqueKey(),
          title: appTitle,
          debugShowCheckedModeBanner: false,
          theme: themeData,
          initialRoute: initialPage,
          routes: {
            LoginPage.PAGE_ROUTE: (context) => LoginPage(),
            RegisterPage.PAGE_ROUTE: (context) => RegisterPage(),
            HomePage.PAGE_ROUTE: (context) => HomePage(),
            'loading': (context) => Scaffold(
                  body: SafeArea(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
          },
        );
      };

  Future<bool> checkIfUserIsLoggedIn() async {
    final jwtService = JwtService();
    final token = await jwtService.getToken();
    return token != null;
  }
}
