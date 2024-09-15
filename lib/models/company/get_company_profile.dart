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
      id: json['id'],
      employees: json['employees'],
      companyName: json['company_name'],
      adminName: json['admin_name'],
      companyLogo: json['company_logo'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      companyDescription: json['company_description'],
      website: json['website'],
      linkedin: json['linkedin'],
      displayEmail: json['display_email'], // Optional field
      username: json['username'], // Optional field
      user: json['user'],
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
