import 'dart:convert';
import 'package:client_nfc_mobile_app/controller/endpoints.dart';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String companyName;
  final String adminName;
  final String profileType;
  final String auth_type;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    required this.adminName,
    required this.profileType,
    required this.auth_type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      companyName: json['company_name'] ?? '',
      adminName: json['admin_name'] ?? '',
      profileType: json['profile_type'] ?? '',
      auth_type: json['authentication_type'] ?? '',
    );
  }
}

class UserService {
  static const String url =
      EndPointsURLs.BASE_URL + EndPointsURLs.user_profile_Endpoint;

  Future<User> fetchUser(String token) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        return User.fromJson(jsonDecode(response.body));
      } catch (e) {
        throw Exception('Failed to parse user data: $e');
      }
    } else {
      throw Exception('Failed to load user: ${response.statusCode}');
    }
  }
}
