import 'package:client_nfc_mobile_app/company_admin_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/controller/api_manager.dart';
import 'package:client_nfc_mobile_app/controller/google_signIn.dart';
import 'package:client_nfc_mobile_app/individual_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/screens/welcome_screen.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';

class GoogleProvider extends ChangeNotifier {
  bool isLoading = false;
  SignInGoogle(context, profileType) async {
    isLoading = true;
    notifyListeners();
    try {
      final accessToken = await GoogleSignInHelper.signInWithGoogle();

      if (accessToken != null) {
        final result =
            await APIsManager.sendAccessToken(accessToken, profileType);

        if (result != null) {
          final token = result['auth_token'];
          if (token != null) {
            // Save the token in local storage
            // notifyListeners();
            // final check = await AuthTokenStorage.saveAuthToken(token);

            isLoading = false;
            notifyListeners();
            // debugger();
            if (result['profile_type'] == 'individual' ||
                result['profile_type'] == 'employee') {
              if (result['profile_type'] == profileType) {
                MyToast("Successfully Sign In");
                notifyListeners();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  CupertinoDialogRoute(
                    builder: (_) => IndividualBottomNavigationBar(
                      user_auth_token: token,
                      futureUser: User(
                        id: result['user_id'],
                        email: result['email'],
                        username: result['username'],
                        firstName: result['first_name'],
                        lastName: result['last_name'],
                        companyName: result['profile_pic'],
                        adminName: '',
                        profileType: result['profile_type'],
                        auth_type: "google",
                      ),
                    ),
                    context: context,
                  ),
                );
              } else {
                notifyListeners();
                MyToast("Your Account did not found in $profileType");
                Navigator.pop(context);
              }
            } else if (result['profile_type'] == 'company') {
              if (result['profile_type'] == profileType) {
                MyToast("Successfully Sign In");
                notifyListeners();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  CupertinoDialogRoute(
                    builder: (_) => CompanyAdminBottomNavigationBar(
                      profileData: null,
                      authToken: token,
                      userDetails: User(
                        id: result['user_id'],
                        email: result['email'],
                        username: result['username'] ?? '',
                        firstName: result['profile_pic'] ?? '',
                        lastName: result['last_name'] ?? '',
                        companyName: result['company'] ?? '',
                        adminName: result['first_name'] ?? '',
                        profileType: result['profile_type'],
                        auth_type: "google",
                      ),
                    ),
                    context: context,
                  ),
                );
              } else {
                notifyListeners();

                MyToast("Your Account did not found in $profileType");
                Navigator.pop(context);
              }
            }
          }
        }
      } else {
        Navigator.pop(context);
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      MyToast("Error $e", Type: false);
    }
    isLoading = false;
    notifyListeners();
  }

  RegisterGoogle(context, profileType) async {
    isLoading = true;
    notifyListeners();
    try {
      final accessToken = await GoogleSignInHelper.registerWithGoogle();

      if (accessToken != null) {
        final result =
            await APIsManager.sendAccessToken(accessToken, profileType);

        if (result != null) {
          MyToast("Successfully Register");

          final token = result['auth_token'];
          if (token != null) {
            // Save the token in local storage
            // notifyListeners();
            // final check = await AuthTokenStorage.saveAuthToken(token);

            isLoading = false;
            notifyListeners();
            // debugger();
            if (result['profile_type'] == 'individual' ||
                result['profile_type'] == 'employee') {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoDialogRoute(
                  builder: (_) => IndividualBottomNavigationBar(
                    user_auth_token: token,
                    futureUser: User(
                      id: result['user_id'],
                      email: result['email'],
                      username: result['username'],
                      firstName: result['first_name'],
                      lastName: result['last_name'],
                      companyName: result['profile_pic'],
                      adminName: '',
                      profileType: result['profile_type'],
                      auth_type: "google",
                    ),
                  ),
                  context: context,
                ),
              );
            } else if (result['profile_type'] == 'company') {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoDialogRoute(
                  builder: (_) => CompanyAdminBottomNavigationBar(
                    profileData: null,
                    authToken: token,
                    userDetails: User(
                      id: result['user_id'],
                      email: result['email'],
                      username: result['username'] ?? '',
                      firstName: result['profile_pic'] ?? '',
                      lastName: result['last_name'] ?? '',
                      companyName: result['company'] ?? '',
                      adminName: result['first_name'] ?? '',
                      profileType: result['profile_type'],
                      auth_type: "google",
                    ),
                  ),
                  context: context,
                ),
              );
            }
          } else {
            isLoading = false;
            notifyListeners();
            MyToast("Sign-in failed or was canceled.", Type: false);
          }
        }
      } else {
        if (profileType == 'company') {
          Navigator.pop(context);
          Navigator.pop(context);
          isLoading = false;
          notifyListeners();
        } else {
          Navigator.pop(context);
          isLoading = false;
          notifyListeners();
        }
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      MyToast("Error $e", Type: false);
    }
    isLoading = false;
    notifyListeners();
  }

  DeleteGoogleAccount(context, auth_token, userID) async {
    isLoading = true;
    notifyListeners();
    try {
      await GoogleSignInHelper.deleteAccount(context, auth_token, userID);

      isLoading = false;
      notifyListeners();
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoDialogRoute(
              builder: (_) => WelcomeScreen(), context: context),
          (route) => false);
    } catch (e) {
      isLoading = false;
      notifyListeners();
      MyToast("Internet Problem Try Again!");
    }
  }
}
