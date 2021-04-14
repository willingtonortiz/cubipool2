import 'dart:io';

import 'package:cubipool2/modules/configuration/constants.dart';
import 'package:dio/dio.dart';

class AuthHttpService {
  static Future<String> login(
    String username,
    String password,
  ) async {
    try {
      Response response = await Dio().post(
        '$BASE_URL/auth/login',
        data: {
          username: username,
          password: password,
        },
      );
      print(response.statusCode);

      if (response.statusCode == HttpStatus.ok) {
        return 'token';
      }
      print(response.statusCode);
      return 'NOT OK';
    } catch (e) {
      throw e;
    }
  }
}
