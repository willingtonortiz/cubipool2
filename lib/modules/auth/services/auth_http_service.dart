import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:cubipool2/modules/configuration/constants.dart';

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
    try {
      final loginUrl = '$BASE_URL/auth/login';

      Response response = await Dio().post(
        loginUrl,
        data: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      return LoginResponseBody.fromMap(response.data);
    } catch (e) {
      throw e;
    }
  }

  static Future<void> register(
    String username,
    String password,
  ) async {
    try {
      final registerUrl = '$BASE_URL/auth/register';

      await Dio().post(
        registerUrl,
        data: jsonEncode({
          "username": username,
          "password": password,
        }),
      );
    } catch (e) {
      throw e;
    }
  }
}
