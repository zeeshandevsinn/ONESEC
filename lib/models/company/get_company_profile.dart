import 'dart:convert';
import 'package:client_nfc_mobile_app/controller/endpoints.dart';
import 'package:http/http.dart' as http;

class CompanyProfile {
  final int id;
  final List<dynamic> employees;
  final String companyName;
  final String adminName;
  final String? companyLogo;
  final String email;
  final String phone;
  final String address;
  final String? companyDescription;
  final String? website;
  final String? linkedin;
  final String? displayEmail; // Optional field
  final String? username; // Optional field
  final int user;

  CompanyProfile({
    required this.id,
    required this.employees,
    required this.companyName,
    required this.adminName,
    this.companyLogo,
    required this.email,
    required this.phone,
    required this.address,
    this.companyDescription,
    this.website,
    this.linkedin,
    this.displayEmail, // Optional field
    this.username, // Optional field
    required this.user,
  });

  factory CompanyProfile.fromJson(Map<String, dynamic> json) {
    return CompanyProfile(
      id: json['id'] ?? 0, // Default to 0 if id is null
      employees:
          json['employees'] ?? [], // Default to empty list if employees is null
      companyName: json['company_name'] ?? '', // Default to empty string
      adminName: json['admin_name'] ?? '', // Default to empty string
      companyLogo: json['company_logo'] ?? '', // Default to empty string
      email: json['email'] ?? '', // Default to empty string
      phone: json['phone'] ?? '', // Default to empty string
      address: json['address'] ?? '', // Default to empty string
      companyDescription:
          json['company_description'] ?? '', // Default to empty string
      website: json['website'] ?? '', // Default to empty string
      linkedin: json['linkedin'] ?? '', // Default to empty string
      displayEmail: json['display_email'] ??
          '', // Default to empty string for optional field
      username:
          json['username'] ?? '', // Default to empty string for optional field
      user: json['user'] ?? 0, // Default to 0 if user is null
    );
  }
}

Future<CompanyProfile> getCompanyProfile(companyID, authToken) async {
  final response = await http.get(
      Uri.parse('${EndPointsURLs.BASE_URL}api/companies/${companyID}/'),
      headers: {'Authorization': 'Token $authToken'});

  if (response.statusCode == 200) {
    return CompanyProfile.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load company profile');
  }
}
