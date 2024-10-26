import 'package:shared_preferences/shared_preferences.dart';

class AuthTokenStorage {
  static const String _authTokenKey = 'auth_token';

  // Save the auth token
  static Future<bool> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_authTokenKey, token);
  }

  // Retrieve the auth token
  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  // Remove the auth token
  static Future<bool> removeAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_authTokenKey);
  }

  static Future<void> saveGoogleLoginState(bool isGoogleLogin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isGoogleLogin', isGoogleLogin);
  }

    static Future<bool> getGoogleLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isGoogleLogin') ?? false;
  }

}
