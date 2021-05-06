import 'package:hive/hive.dart';

class UserInformationService {
  static const _USER_BOX = "USER_BOX";
  static const _USERNAME_KEY = "USERNAME_KEY";

  static Future<String?> getUsername() async {
    final box = await Hive.openBox<String>(_USER_BOX);
    return box.get(_USERNAME_KEY);
  }

  static Future<void> saveUsername(String username) async {
    final box = await Hive.openBox<String>(_USER_BOX);
    return box.put(_USERNAME_KEY, username);
  }
}
