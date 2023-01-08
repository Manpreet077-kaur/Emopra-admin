import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static SharedPreferences? _prefsInstance;
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  static Future<bool> setBoolean(String key, bool value) async {
    return await _prefsInstance?.setBool(key, value) ?? false;
  }

  static Future<bool> setLocationAccess(String key, bool value) async {
    return await _prefsInstance?.setBool(key, value) ?? false;
  }

  static bool isLocationSuccess(String key, [bool? defValue]) {
    return _prefsInstance!.getBool(key) ?? defValue ?? false;
  }

  static bool isSuccess(String key, [bool? defValue]) {
    return _prefsInstance!.getBool(key) ?? defValue ?? false;
  }

  static  Future<Object> setString(String key,String value) async {
    return await _prefsInstance?.setString(key, value) ?? "";

  }static  Future<Object> setStringList(String key,List<String> value) async {
    return await _prefsInstance?.setStringList(key, value) ?? "";

  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance?.getString(key) ?? defValue ?? "";
  }
  static  getStringList(String key, [List<String>? defValue]) {
    return _prefsInstance?.getStringList(key) ?? defValue ?? "";
  }
  static Future? clear() {
    _prefsInstance!.clear();
  }
}
