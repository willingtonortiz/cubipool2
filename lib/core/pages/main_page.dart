import 'package:flutter/material.dart';

// Services
import 'package:cubipool2/modules/auth/services/jwt_service.dart';

// Pages
import 'package:cubipool2/modules/auth/pages/login_page.dart';
import 'package:cubipool2/modules/auth/pages/register_page.dart';
import 'package:cubipool2/modules/home/pages/home_page.dart';
import 'package:cubipool2/shared/pages/not_found_page.dart';

const APP_TITLE = 'CUBIPOOL';
const PRIMARY_COLOR = Colors.red;
final acceptColor = PRIMARY_COLOR[700];
final themeData = ThemeData(
  primaryColor: PRIMARY_COLOR,
  accentColor: acceptColor,
  appBarTheme: AppBarTheme(
    centerTitle: true,
  ),
  textTheme: TextTheme(
    bodyText2: TextStyle(fontSize: 14.0),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: PRIMARY_COLOR,
    behavior: SnackBarBehavior.floating,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: PRIMARY_COLOR,
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
    style: TextButton.styleFrom(primary: PRIMARY_COLOR),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(primary: PRIMARY_COLOR),
  ),
);

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<bool> _userFuture;

  Future<bool> checkIfUserIsLoggedIn() async {
    final token = await JwtService.getToken();
    return token != null;
  }

  @override
  void initState() {
    _userFuture = checkIfUserIsLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userFuture,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        final materialApp = _buildMaterialApp(themeData);

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
    ThemeData themeData,
  ) =>
      (String initialPage) {
        return MaterialApp(
          key: Key(initialPage),
          title: APP_TITLE,
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
}
