import 'dart:convert';
import 'package:http/http.dart' as http;

class CompanyProfileService {
  static const String baseUrl = 'https://api.onesec.shop/api/companies/';

  // Fetch company profiles (GET)
  static Future<List<dynamic>> getCompanyProfiles(String token) async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw Exception('Authentication credentials were not provided.');
    } else {
      throw Exception('Failed to fetch company profiles');
    }
  }

  // Create a new company profile (POST)
  static Future<Map<String, dynamic>> createCompanyProfile(
      String token, Map<String, dynamic> profileData) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(profileData),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      throw Exception('Validation errors: ${response.body}');
    } else {
      throw Exception('Failed to create company profile');
    }
  }
}
