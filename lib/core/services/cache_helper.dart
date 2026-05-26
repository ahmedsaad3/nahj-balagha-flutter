import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static Future<void> clear() async {
    await sharedPreferences?.clear();
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences!.remove(key);
  }

  static Future<bool> setString({
    required String key,
    required String? value,
  }) async {
    return await sharedPreferences!.setString(key, value!);
  }

  static Future<bool> setStringList({
    required String key,
    required List<String> value,
  }) async {
    return await sharedPreferences!.setStringList(key, value);
  }

  static Future<bool> setInt({required String key, required int value}) async {
    return await sharedPreferences!.setInt(key, value);
  }

  static bool? getBoolean({required String key}) {
    return sharedPreferences!.getBool(key);
  }

  static List<String>? getStringList({required String key}) {
    return sharedPreferences!.getStringList(key);
  }

  static int? getInt({required String key}) {
    return sharedPreferences!.getInt(key);
  }

  static String? getString({required String key}) {
    return sharedPreferences?.getString(key);
  }
}
