import 'dart:convert';
import 'dart:developer';

import 'package:client_nfc_mobile_app/controller/endpoints.dart';
import 'package:client_nfc_mobile_app/controller/prefrences.dart';
import 'package:client_nfc_mobile_app/models/user_profile/user_profile_details.dart';
import 'package:client_nfc_mobile_app/models/user_profile/user_profile_errors.dart';
import 'package:http/http.dart' as http;
import 'package:client_nfc_mobile_app/utils/toast.dart';

class APIsManager {
  static Future<dynamic> RegisterUsers(
      String first_name,
      String last_name,
      String email,
      String username,
      String password,
      String company_name,
      String Admin_name,
      String profile_type,
      String auth_type) async {
    try {
      final completeURL =
          EndPointsURLs.BASE_URL + EndPointsURLs.register_Endpoint;
      final url = Uri.parse(completeURL);
      final payLoad = {
        "first_name": first_name,
        "last_name": last_name,
        "email": email,
        "username": username,
        "password": password,
        "company_name": company_name,
        "admin_name": Admin_name,
        "profile_type": profile_type,
        "authentication_type": auth_type
      };

      print("Payload: $payLoad");
      // debugger();
      final response = await http.post(
        url,
        body: payLoad,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        final errorResponse = jsonDecode(response.body);

        if (errorResponse['email'] != null) {
          MyToast("Email: ${errorResponse['email'][0]}", Type: false);
        }

        if (errorResponse['username'] != null) {
          MyToast("Username: ${errorResponse['username'][0]}", Type: false);
        }

        return null;
      } else {
        // debugger();
        MyToast("Error: ${response.statusCode} Unable to Register Credentials",
            Type: false);
        log("Error: ${response.statusCode} ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      MyToast("Error Catch: $e", Type: false);
      return null;
    }
  }

  static Future<dynamic> LoginUsers(
    String email,
    String password,
  ) async {
    try {
      final completeURL = EndPointsURLs.BASE_URL + EndPointsURLs.login_Endpoint;
      final url = Uri.parse(completeURL);
      final payLoad = {
        "email": email,
        "password": password,
      };

      print("Payload: $payLoad");
      // debugger();
      final response = await http.post(
        url,
        body: payLoad,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        // debugger();
        MyToast("Unable to log in with provided credentials.", Type: false);
        // MyToast("Error: ${response.statusCode} ${response.reasonPhrase}",
        //     Type: false);
        return null;
      }
    } catch (e) {
      MyToast("Error Catch: Internet is Not Connected $e", Type: false);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> sendAccessToken(
      String accessToken, String profileType) async {
    final completeURL = EndPointsURLs.BASE_URL + EndPointsURLs.googleSignInURl;
    final url = Uri.parse(completeURL);
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'access_token': accessToken,
      'profile_type': profileType,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      // debugger();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final token = data['auth_token'] ?? "";

        await AuthTokenStorage.saveAuthToken(token);
        return data;
      } else if (response.statusCode == 400) {
        MyToast("Please Try Again Network Issue", Type: false);
        return null;
      } else {
        // debugger();
        print(response.body);
        MyToast("Error: ${response.statusCode} ${response.reasonPhrase}",
            Type: false);
        MyToast("Error: ${response.statusCode} ${response.reasonPhrase}",
            Type: false);
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static SignInProfileGoogle(tokenID, profileType) async {
    try {
      final completeURL =
          EndPointsURLs.BASE_URL + EndPointsURLs.googleSignInURl;
      final url = Uri.parse(completeURL);
      final payload = {"access_token": tokenID, "profile_type": profileType};
      print(payload);
      final result = await http.post(url, body: payload);
      // debugger();
      if (result.statusCode == 200 || result.statusCode == 201) {
        return jsonDecode(result.body);
      } else {
        // debugger();
        MyToast("Error: ${result.statusCode} ${result.reasonPhrase}",
            Type: false);
        MyToast("Error: ${result.statusCode} ${result.reasonPhrase}",
            Type: false);
        return null;
      }
    } catch (e) {
      MyToast("Error: $e", Type: false);
      return null;
    }
  }

  static resetPassword(email) async {
    try {
      final completeURL =
          EndPointsURLs.BASE_URL + EndPointsURLs.user_reset_password;
      final url = Uri.parse(completeURL);
      final payLoad = {
        "email": email,
      };

      print("Payload: $payLoad");
      // debugger();
      final response = await http.post(
        url,
        body: payLoad,
      );
      if (response.statusCode == 204) {
        return true;
      } else {
        // debugger();
        MyToast("Authentication credentials were not provided.", Type: false);
        MyToast("Error: ${response.statusCode} Email is not Corrected.",
            Type: false);
        return null;
      }
    } catch (e) {
      MyToast("Error Catch: $e", Type: false);
      return null;
    }
  }

  static Future<bool> deleteAccount(String authToken, String password) async {
    final url = Uri.parse('https://api.onesec.shop/auth/users/me/');

    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Token $authToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'current_password': password,
      }),
    );

    if (response.statusCode == 204) {
      // Account deleted successfully
      return true;
    } else {
      // Failed to delete account
      return false;
    }
  }

  static ChangePassword(auth_token, current_password, new_password) async {
    try {
      final url = Uri.parse(EndPointsURLs.change_password);
      // debugger();
      final response = await http.post(url, headers: {
        'Authorization': 'Token $auth_token',
      }, body: {
        "current_password": current_password,
        "new_password": new_password
      });

      if (response.statusCode == 204) {
        MyToast("Successfully Change your Password");
        // Account Password Set successfully
        return true;
      } else if (response.statusCode == 400) {
        MyToast("Your Password is Invalid Again Try", Type: false);
        return null;
      }
    } catch (e) {
      // debugger();
      MyToast("Internet Not Connected 404", Type: false);
      print('Error: $e');
      return null;
    }
  }

  static LogoutUser(authToken) async {
    try {
      final completeUrl = EndPointsURLs.BASE_URL + "auth/token/logout/";
      final url = Uri.parse(completeUrl);

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Token $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 204) {
        MyToast("Successfully Logout User");
        await AuthTokenStorage.removeAuthToken();
        // Account deleted successfully
        return true;
      } else {
        MyToast("Authentication Wrong");
        // Failed to delete account
        return false;
      }
    } catch (e) {
      // MyToast(e.toString());
      return null;
    }
  }

//_________________________________________________________
//                       USER PROFILE DETAILS
//_________________________________________________________

  static GetUserProfileData(username, authToken) async {
    try {
      final url =
          Uri.parse('https://api.onesec.shop/api/profiles/${username}/');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $authToken',
          'Content-Type': 'application/json',
        },
      );

      // debugger();
      if (response.statusCode == 200) {
        // Account deleted successfully
        final jsonData = jsonDecode(response.body);
        return UserProfileModel.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        MyToast('Profile does not exist.', Type: false);
        MyToast('Please Create Profile First', Type: false);
        return null;
      } else {
        // Failed to delete account
        return null;
      }
    } catch (e) {
      // debugger();
      MyToast('Error $e');
      print(e);
      return null;
    }
  }

  static DeleteUserProfile(auth_token, userID) async {
    try {
      final url = Uri.parse('https://api.onesec.shop/api/profiles/${userID}/');

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Token $auth_token',
        },
      );

      if (response.statusCode == 204) {
        // debugger();
        // Account deleted successfully
        return true;
      } else {
        // Failed to delete account
        return null;
      }
    } catch (e) {
      MyToast('Error $e');
      print(e);
      return null;
    }
  }

  static CreateUserProfile({
    required final authToken,
    required String firstName,
    required String lastName,
    required String email,
    required String position,
    required String phone,
    required String address,
    required String bio,
    required String display_email,
    String? username,
    String? facebook,
    String? instagram,
    String? website,
    String? linkedin,
    String? github,
    required int whatsapp,
    String? profilePic,
    required int user,
  }) async {
    final String url = 'https://api.onesec.shop/api/profiles/';
    final payload = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'position': position,
      'phone': phone,
      'address': address,
      'bio': bio,
      'facebook': (facebook != null && facebook.isNotEmpty) ? facebook : null,
      'instagram':
          (instagram != null && instagram.isNotEmpty) ? instagram : null,
      'website': (website != null && website.isNotEmpty) ? website : null,
      'linkedin': (linkedin != null && linkedin.isNotEmpty) ? linkedin : null,
      'github': (github != null && github.isNotEmpty) ? github : null,
      'whatsapp': (whatsapp != 0) ? whatsapp : null,
      'profile_pic': profilePic,
      'receive_marketing_emails': false,
      'user': user,
      'display_email': display_email,
      "username": username
    };
    print(payload);
    final request = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $authToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );
    try {
      var jsonResponse = jsonDecode(request.body);

      if (request.statusCode == 200 ||
          request.statusCode == 201 ||
          request.statusCode == 204) {
        // debugger();
        // Profile updated successfully
        return jsonResponse;
      } else if (request.statusCode == 400) {
        // debugger();
        UserProfileErrors errors = UserProfileErrors.fromJson(jsonResponse);

        if (errors.facebook != null && errors.facebook!.isNotEmpty) {
          MyToast('Facebook: ${errors.facebook!.join(', ')}', Type: false);
        }
        if (errors.instagram != null && errors.instagram!.isNotEmpty) {
          MyToast('Instagram: ${errors.instagram!.join(', ')}', Type: false);
        }
        if (errors.website != null && errors.website!.isNotEmpty) {
          MyToast('Website: ${errors.website!.join(', ')}', Type: false);
        }
        if (errors.linkedin != null && errors.linkedin!.isNotEmpty) {
          MyToast('LinkedIn: ${errors.linkedin!.join(', ')}', Type: false);
        }
        if (errors.github != null && errors.github!.isNotEmpty) {
          MyToast('GitHub: ${errors.github!.join(', ')}', Type: false);
        }
        if (errors.whatsapp != null && errors.whatsapp!.isNotEmpty) {
          MyToast('WhatsApp: ${errors.whatsapp!.join(', ')}', Type: false);
        }
        if (errors.user != null && errors.user!.isNotEmpty) {
          MyToast('User: ${errors.user!.join(', ')}', Type: false);
        }
        if (errors.profilePic != null && errors.profilePic!.isNotEmpty) {
          MyToast('Profile Pic: ${errors.profilePic!.join(', ')}', Type: false);
        }

        return null;
      } else {
        MyToast("Internet Issue ${request.statusCode}", Type: false);
        // Failed to update profile
        return null;
      }
    } catch (e) {
      print(e);
      MyToast("Error $e", Type: false);
      return null;
    }
  }

  // static Future UpdateUserProfileDetails(
  //     Map<String, dynamic> userDetails, String authToken) async {
  //   try {
  //     var userId = userDetails['user'];
  //     final url = Uri.parse(
  //         'https://api.onesec.shop/api/profiles/${userId}/');

  //     // Create a multipart request
  //     var request = http.MultipartRequest('PUT', url)
  //       ..headers['Authorization'] = 'Token $authToken'
  //       ..fields['user'] = userDetails['user'].toString()
  //       ..fields['first_name'] = userDetails['first_name']
  //       ..fields['last_name'] = userDetails['last_name']
  //       ..fields['email'] = userDetails['email']
  //       ..fields['phone'] = userDetails['phone']
  //       ..fields['address'] = userDetails['address']
  //       ..fields['bio'] = userDetails['bio']
  //       ..fields['facebook'] = userDetails['facebook'] ?? ''
  //       ..fields['instagram'] = userDetails['instagram'] ?? ''
  //       ..fields['website'] = userDetails['website'] ?? ''
  //       ..fields['linkedin'] = userDetails['linkedin'] ?? ''
  //       ..fields['github'] = userDetails['github'] ?? ''
  //       ..fields['whatsapp'] = userDetails['whatsapp'];

  //     if (userDetails['profile_pic'] != null) {
  //       var profilePicPath = userDetails['profile_pic'];
  //       var profilePicFile =
  //           await http.MultipartFile.fromPath('profile_pic', profilePicPath);
  //       request.files.add(profilePicFile);
  //     }

  //     var response = await request.send();
  //     var responseBody = await response.stream.bytesToString();
  static UpdateUserProfileDetails({
    required final authToken,
    required int id,
    required String firstName,
    required String lastName,
    required String email,
    required String position,
    required String phone,
    required String address,
    required String bio,
    required String display_email,
    String? username,
    String? facebook,
    String? instagram,
    String? website,
    String? linkedin,
    String? github,
    required int whatsapp,
    String? profilePic,
    required int user,
  }) async {
    final String url = 'https://api.onesec.shop/api/profiles/$username/';
    // debugger();
    final payload = {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'position': position,
      'phone': phone,
      'address': address,
      'bio': bio,
      'facebook': (facebook != null && facebook.isNotEmpty) ? facebook : null,
      'instagram':
          (instagram != null && instagram.isNotEmpty) ? instagram : null,
      'website': (website != null && website.isNotEmpty) ? website : null,
      'linkedin': (linkedin != null && linkedin.isNotEmpty) ? linkedin : null,
      'github': (github != null && github.isNotEmpty) ? github : null,
      'whatsapp': (whatsapp != 0) ? whatsapp : null,
      'profile_pic': profilePic,
      'receive_marketing_emails': false,
      'user': user,
      'display_email': display_email,
      'username': username
    };
    final request = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $authToken',
        'Content-Type': 'application/json',
      },
      body: json.encode(payload),
    );
    // debugger();
    try {
      var jsonResponse = jsonDecode(request.body);

      if (request.statusCode == 200) {
        // Profile updated successfully
        return jsonResponse;
      } else if (request.statusCode == 400) {
        UserProfileErrors errors = UserProfileErrors.fromJson(jsonResponse);

        if (errors.facebook != null && errors.facebook!.isNotEmpty) {
          MyToast('Facebook: ${errors.facebook!.join(', ')}', Type: false);
        }
        if (errors.instagram != null && errors.instagram!.isNotEmpty) {
          MyToast('Instagram: ${errors.instagram!.join(', ')}', Type: false);
        }
        if (errors.website != null && errors.website!.isNotEmpty) {
          MyToast('Website: ${errors.website!.join(', ')}', Type: false);
        }
        if (errors.linkedin != null && errors.linkedin!.isNotEmpty) {
          MyToast('LinkedIn: ${errors.linkedin!.join(', ')}', Type: false);
        }
        if (errors.github != null && errors.github!.isNotEmpty) {
          MyToast('GitHub: ${errors.github!.join(', ')}', Type: false);
        }
        if (errors.whatsapp != null && errors.whatsapp!.isNotEmpty) {
          MyToast('WhatsApp: ${errors.whatsapp!.join(', ')}', Type: false);
        }
        if (errors.user != null && errors.user!.isNotEmpty) {
          MyToast('User: ${errors.user!.join(', ')}', Type: false);
        }
        if (errors.profilePic != null && errors.profilePic!.isNotEmpty) {
          MyToast('Profile Pic: ${errors.profilePic!.join(', ')}', Type: false);
        }

        return null;
      } else {
        MyToast("Internet Issue", Type: false);
        // Failed to update profile
        return null;
      }
    } catch (e) {
      // debugger();
      print(e);
      MyToast("Error $e", Type: false);
      return null;
    }
  }
}
