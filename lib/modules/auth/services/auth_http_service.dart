import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cubipool2/core/configuration/constants.dart';
import 'package:cubipool2/shared/models/response_error.dart';

class LoginResponseBody {
  final String jwt;

  LoginResponseBody({required this.jwt});

  @override
  String toString() => 'LoginResponseBody(jwt: $jwt)';

  Map<String, dynamic> toMap() {
    return {
      'jwt': jwt,
    };
  }

  factory LoginResponseBody.fromMap(Map<String, dynamic> map) {
    return LoginResponseBody(
      jwt: map['jwt'],
    );
  }
}

class AuthHttpService {
  static Future<LoginResponseBody> login(
    String username,
    String password,
  ) async {
    final loginUrl = Uri.parse('$BASE_URL/auth/login');
    final response = await http.post(
      loginUrl,
      body: {
        "username": username,
        "password": password,
      },
    );

    if (response.statusCode != HttpStatus.created) {
      final responseError = ResponseError.fromMap(jsonDecode(response.body));
      throw responseError;
    }

    return LoginResponseBody.fromMap(jsonDecode(response.body));
  }

  static Future<void> register(
    String username,
    String password,
  ) async {
    final registerUrl = Uri.parse('$BASE_URL/auth/register');
    final response = await http.post(
      registerUrl,
      body: {
        "username": username,
        "password": password,
      },
    );

    if (response.statusCode != HttpStatus.created) {
      final responseError = ResponseError.fromMap(jsonDecode(response.body));
      throw responseError;
    }
  }
}
