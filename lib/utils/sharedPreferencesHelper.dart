import 'package:shared_preferences/shared_preferences.dart';

const String KEY_USER = 'userId';
const String KEY_FCM_TOKEN = 'fcm_token';
const String KEY_JWT_TOKEN = 'jwt_token';

class SharedPreferencesHelper {
  static Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_USER);
  }

  static Future<bool> setUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KEY_USER, value);
  }

  static Future<bool> removeUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(KEY_USER);
  }

  static Future<String> getFCMToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_FCM_TOKEN);
  }

  static Future<bool> setFCMToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KEY_FCM_TOKEN, value);
  }

  static Future<bool> removeFCMToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(KEY_FCM_TOKEN);
  }

  static Future<String> getJWTToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_JWT_TOKEN);
  }

  static Future<bool> setJWTToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KEY_JWT_TOKEN, value);
  }

  static Future<bool> removeJWTToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(KEY_JWT_TOKEN);
  }
}
