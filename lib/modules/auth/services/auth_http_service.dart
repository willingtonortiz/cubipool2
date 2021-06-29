import 'dart:io';
import 'dart:convert';
import 'package:hive/hive.dart';
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
  static const _USERNAME_BOX = "USERNAME_BOX";
  static const _USERNAME_KEY = "USERNAME_KEY";

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

  static Future<bool> register(
    String username,
    String password,
  ) async {
    try {
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
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> saveUserName(String username) async {
    final box = await Hive.openBox<String>(_USERNAME_BOX);
    await box.put(_USERNAME_KEY, username);
  }

  static Future<String?> getUserName() async {
    final box = await Hive.openBox<String>(_USERNAME_BOX);
    return box.get(_USERNAME_KEY);
  }

  static Future<void> removeUserName() async {
    final box = await Hive.openBox<String>(_USERNAME_BOX);
    await box.delete(_USERNAME_KEY);
  }
}
