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
}
