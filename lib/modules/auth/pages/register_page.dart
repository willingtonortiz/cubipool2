import 'package:flutter/material.dart';

import 'package:cubipool2/modules/auth/services/auth_http_service.dart';
import 'package:cubipool2/modules/common/validators/widgets/username_validator.dart';

class RegisterPage extends StatefulWidget {
  static const PAGE_ROUTE = '/auth/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _username;
  String? _password;
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32.0),
              Image.asset(
                'assets/logos/pencils.png',
              ),
              const SizedBox(height: 32.0),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      _buildUsername(),
                      const SizedBox(height: 16.0),
                      _buildPassword(),
                      const SizedBox(height: 16.0),
                      _buildConfirmPassword(),
                      const SizedBox(height: 64.0),
                      _buildRegisterButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Contraseña',
        prefixIcon: Icon(Icons.lock),
      ),
      obscureText: true,
      validator: (String? value) {
        value = value ?? '';

        if (value.isEmpty) {
          return 'La contraseña es requerida';
        }
        return null;
      },
      onSaved: (String? value) {
        _password = value;
      },
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Confirmar contraseña',
        prefixIcon: Icon(Icons.lock),
      ),
      obscureText: true,
      validator: (String? value) {
        value = value ?? '';

        if (value.isEmpty) {
          return 'La confirmación de contraseña es requerida';
        }

        if (_passwordController.text != value) {
          return 'Las contraseñas no coinciden';
        }

        return null;
      },
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () async {
        final isValid = _formKey.currentState!.validate();
        if (!isValid) {
          return;
        }

        _formKey.currentState!.save();
        registerUser(_username!, _password!);
      },
      child: Text('Registrarse'),
    );
  }

  Future<void> registerUser(String username, String password) async {
    try {
      await AuthHttpService.register(username, password);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Se ha registrado correctamente'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrió un error'),
        ),
      );
    }
  }
}
