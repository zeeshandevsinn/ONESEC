import 'dart:convert';
import 'dart:developer';
import 'package:client_nfc_mobile_app/controller/services/company%20profile/company_profile_list.dart';
import 'package:client_nfc_mobile_app/models/company/company_user.dart';
import 'package:client_nfc_mobile_app/models/company/get_company_profile.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:http/http.dart' as http;

class CompanyProfileDetailService {
  // Fetch a company profile (GET)
  static getCompanyProfileDetail(String token, username) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.onesec.shop/api/companies/$username/'),
        headers: {
          'Authorization': 'Token $token',
        },
      );
      // debugger();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        // debugger();
        final request = CompanyProfile.fromJson(data);

        return request;
      } else if (response.statusCode == 404) {
        // MyToast('Company does not exist.', Type: false);
        // MyToast('Please Create Company Profile First', Type: false);
        return null;
      } else {
        // MyToast('Failed to fetch company profile detail', Type: false);
        return null;
      }
    } catch (e) {
      // MyToast('Internet Issue', Type: false);
      return null;
    }
  }

  // Update a company profile (PUT)
  static updateCompanyProfile(
      String token, username, Map<String, dynamic> profileData) async {
    final response = await http.put(
      Uri.parse('${CompanyProfileService.baseUrl}$username/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(profileData),
    );

    if (response.statusCode == 200) {
      MyToast("Update Profile Successfully");
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      MyToast('Validation errors: ${response.body}', Type: false);
      return null;
    } else {
      MyToast('Failed to update company profile', Type: false);
      return null;
    }
  }

  // Delete a company profile (DELETE)
  static Future<void> deleteCompanyProfile(String token, int pk) async {
    final response = await http.delete(
      Uri.parse('${CompanyProfileService.baseUrl}$pk/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 204) {
      return;
    } else if (response.statusCode == 403) {
      throw Exception('You do not have permission to perform this action.');
    } else {
      throw Exception('Failed to delete company profile');
    }
  }
}
