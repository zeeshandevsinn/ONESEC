import 'dart:convert';
import 'dart:developer';
import 'package:client_nfc_mobile_app/controller/endpoints.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:http/http.dart' as http;

class ShareProfileManager {
  static shareProfileUrl(String token) async {
    final completeUrl = EndPointsURLs.BASE_URL + "api/share-profile-url/";
    final url = Uri.parse(completeUrl);
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['profile_url'];
    } else if (response.statusCode == 404) {
      final responseData = jsonDecode(response.body);
      MyToast(responseData['detail'].join(', '), Type: false);
      return null;
    } else {
      MyToast('Failed to share profile', Type: false);
      return null;
    }
  }

  static shareProfile(String token, String email) async {
    final completeUrl = EndPointsURLs.BASE_URL + "api/share-profile-url/";
    final url = Uri.parse(completeUrl);
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'shared_to': email,
      }),
    );
    // debugger();
    if (response.statusCode == 200) {
      MyToast("Successfully Share Profile");
      return true;
    } else if (response.statusCode == 400) {
      final responseData = jsonDecode(response.body);
      MyToast(responseData['error'], Type: false);
      return null;
    } else {
      MyToast('Failed to share profile', Type: false);
      return null;
    }
  }

  static getSharedProfiles(token) async {
    final response = await http.get(
      Uri.parse('${EndPointsURLs.BASE_URL}api/share-profile/'),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      MyToast('Error fetching received profiles.');
      return null;
    }
  }
}
