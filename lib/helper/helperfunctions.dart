import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return preferences.getInt(key) ?? defaultValue;
  }

  static Future<bool> setInt(String key, int value) {
    return preferences.setInt(key, value);
  }

  static String getString(String key, {String defaultValue = ''}) {
    return preferences.getString(key) ?? defaultValue;
  }

  static Future<bool> setString(String key, String value) {
    return preferences.setString(key, value);
  }

  static Future<bool> remove(String key) {
    return preferences.remove(key);
  }

  static Future<bool> clear() {
    return preferences.clear();
  }
}
