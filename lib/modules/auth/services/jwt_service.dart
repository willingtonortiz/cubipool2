import 'package:hive/hive.dart';

class JwtService {
  static const _JWT_BOX = "JWT_BOX";
  static const _JWT_KEY = "JWT_KEY";

  Future<void> saveToken(String token) async {
    final box = await Hive.openBox<String>(_JWT_BOX);
    await box.put(_JWT_KEY, token);
  }

  Future<String?> getToken() async {
    final box = await Hive.openBox<String>(_JWT_BOX);
    return box.get(_JWT_KEY);
  }

  Future<void> removeToken() async {
    final box = await Hive.openBox<String>(_JWT_BOX);
    await box.delete(_JWT_KEY);
  }
}
