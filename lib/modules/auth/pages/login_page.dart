import 'package:cubipool2/modules/auth/services/auth_http_service.dart';
import 'package:cubipool2/modules/auth/services/jwt_service.dart';
import 'package:cubipool2/modules/common/validators/widgets/username_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const PAGE_ROUTE = '/auth/login';

  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _username;
  String? _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      _buildUsername(),
                      const SizedBox(height: 16.0),
                      _buildPassword(),
                      const SizedBox(height: 60.0),
                      _buildLoginButton(),
                      const SizedBox(height: 16.0),
                      _buildRegisterButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/items/login_background.png',
              fit: BoxFit.fill,
            ),
          ),
          Image.asset(
            'assets/logos/upc_logo.png',
          ),
        ],
      ),
    );
  }

  Widget _buildUsername() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Código de alumno',
        prefixIcon: Icon(Icons.person),
      ),
      validator: (String? value) {
        value = value ?? '';

        if (value.isEmpty) {
          return 'El código de alumno es requerido';
        }
        if (!isUsernameValid(value)) {
          return 'El código de alumno es invalido';
        }
        return null;
      },
      onSaved: (String? value) {
        _username = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Contraseña',
        prefixIcon: Icon(Icons.lock),
      ),
      obscureText: true,
      validator: (String? value) {
        value = value ?? '';

        if (value.isEmpty) {
          return 'El código de alumno es requerido';
        }
        return null;
      },
      onSaved: (String? value) {
        _password = value;
      },
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () async {
        final isValid = _formKey.currentState!.validate();
        if (!isValid) {
          return;
        }

        _formKey.currentState!.save();
        loginUser(_username!, _password!);
      },
      child: Text('Iniciar sesión'),
    );
  }

  Widget _buildRegisterButton() {
    return GestureDetector(
      child: Text('¿No tienes cuenta?, Regístrate'),
      onTap: () {
        Navigator.pushReplacementNamed(context, '/auth/register');
      },
    );
  }

  void loginUser(String username, String password) async {
    try {
      final response = await AuthHttpService.login(username, password);
      final jwtService = JwtService();
      await jwtService.saveToken(response.jwt);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrió un error'),
        ),
      );
    }
  }
}
