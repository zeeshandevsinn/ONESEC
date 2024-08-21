import 'dart:developer';

import 'package:client_nfc_mobile_app/company_admin_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/controller/api_manager.dart';
import 'package:client_nfc_mobile_app/controller/google_signIn.dart';
import 'package:client_nfc_mobile_app/controller/prefrences.dart';
import 'package:client_nfc_mobile_app/controller/services/login_api.dart';
import 'package:client_nfc_mobile_app/individual_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/screens/welcome_screen.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class GoogleProvider extends ChangeNotifier {
  bool isLoading = false;
  SignInGoogle(context, profileType) async {
    isLoading = true;
    notifyListeners();
    try {
      // debugger();
      final accessToken = await GoogleSignInHelper.signInWithGoogle();

      if (accessToken != null) {
        // debugger();
        final result =
            await APIsManager.sendAccessToken(accessToken, profileType);
        // debugger();
        if (result != null) {
          MyToast("Successfully Sign In");
          print(result['auth_token']);

          await AuthTokenStorage.saveAuthToken(result['auth_token']);
          notifyListeners();
          if (profileType == 'individual') {
            isLoading = false;
            notifyListeners();
            Navigator.pop(context);
            // await AuthTokenStorage.saveAuthToken(result['auth_token']);
            Navigator.push(
                context,
                CupertinoDialogRoute(
                    builder: (_) => IndividualBottomNavigationBar(
                        user_auth_token: result['auth_token'],
                        futureUser: User(
                            id: result['user_id'],
                            email: result['email'],
                            username: result['username'],
                            firstName: result['first_name'],
                            lastName: result['last_name'],
                            companyName: result['profile_pic'],
                            adminName: '',
                            profileType: result['profile_type'],
                            auth_type: "google")),
                    context: context));
          } else if (profileType == 'company') {
            isLoading = false;
            notifyListeners();
            Navigator.pop(context);
            Navigator.pop(context);
            print(result);
            // debugger();

            // await AuthTokenStorage.saveAuthToken(result['auth_token']);
            notifyListeners();
            Navigator.push(
                context,
                CupertinoDialogRoute(
                    builder: (_) => CompanyAdminBottomNavigationBar(
                          profileData: null,
                          authToken: result['auth_token'],
                          userDetails: User(
                              id: result['user_id'],
                              email: result['email'],
                              username: result['username'] ?? '',
                              firstName: result['profile_pic'] ?? '',
                              lastName: result['last_name'] ?? '',
                              companyName: result['company'] ?? '',
                              adminName: result['first_name'] ?? '',
                              profileType: result['profile_type'],
                              auth_type: "google"),
                        ),
                    context: context));
          }
        } else {
          isLoading = false;
          notifyListeners();

          Navigator.pop(context);
          // Navigator.pop(context);
          MyToast("Sign-in failed or was canceled.", Type: false);
        }
      } else {
        isLoading = false;
        notifyListeners();

        Navigator.pop(context);
        Navigator.pop(context);
        MyToast("Sign-in failed or was canceled.", Type: false);
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();

      Navigator.pop(context);
      MyToast("Error $e ", Type: false);
    }
    isLoading = false;
    notifyListeners();
  }

  DeleteGoogleAccount(context, auth_token, userID) async {
    isLoading = true;
    notifyListeners();
    try {
      final data =
          await GoogleSignInHelper.deleteAccount(context, auth_token, userID);
      if (data != null) {
        isLoading = false;
        notifyListeners();
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoDialogRoute(
                builder: (_) => WelcomeScreen(), context: context),
            (route) => false);
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      MyToast("Internet Problem Try Again!");
    }
  }
}
