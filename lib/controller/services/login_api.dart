import 'dart:developer';

import 'package:client_nfc_mobile_app/company_admin_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/controller/google_signIn.dart';
import 'package:client_nfc_mobile_app/controller/prefrences.dart';
import 'package:client_nfc_mobile_app/individual_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/screens/login_screen.dart';
import 'package:client_nfc_mobile_app/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/controller/api_manager.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';

class LoginUserProvider extends ChangeNotifier {
  bool isLoading = false;
  String Auth_Token = "";
  User? futureUser;
  bool logoutLoading = false;
  LoginUsers(context, String email, String password, String type) async {
    try {
      isLoading = true;
      notifyListeners();
      final data = await APIsManager.LoginUsers(email, password);
      if (data != null) {
        // debugger();
        notifyListeners();
        isLoading = false;
        print(data['auth_token']);
        notifyListeners();
        Auth_Token = data['auth_token'] ?? "";

        await AuthTokenStorage.saveAuthToken(Auth_Token);

        notifyListeners();
        futureUser = await UserService().fetchUser(Auth_Token);
        notifyListeners();
        Navigator.pop(context);
        if (futureUser!.profileType == 'individual' ||
            futureUser!.profileType == 'employee') {
          if (futureUser!.profileType == type) {
            notifyListeners();
            MyToast("Login Successfully");
            Navigator.push(
                context,
                CupertinoDialogRoute(
                    builder: (_) => IndividualBottomNavigationBar(
                          user_auth_token: Auth_Token,
                          futureUser: futureUser!,
                        ),
                    context: context));
          } else {
            notifyListeners();
            MyToast("Your Account did not found in $type");
          }
        } else if (futureUser!.profileType == 'company') {
          if (futureUser!.profileType == type) {
            notifyListeners();
            MyToast("Login Successfully");
            Navigator.push(
                context,
                CupertinoDialogRoute(
                    builder: (_) => CompanyAdminBottomNavigationBar(
                          profileData: null, authToken: Auth_Token,
                          userDetails: futureUser,

                          // user_auth_token: Auth_Token,
                        ),
                    context: context));
          } else {
            notifyListeners();
            MyToast("Your Account did not found in $type");
          }
        }
      } else {
        // debugger();
        print(data.toString());
        // MyToast("Error 400 Credentials not found", Type: false);
        isLoading = false;
        notifyListeners();
        Navigator.pop(context);
        // Navigator.pop(context);
      }
    } catch (e) {
      // debugger();
      MyToast("Error! $e", Type: false);
      isLoading = false;
      notifyListeners();
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  ResetPassword(context, email) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await APIsManager.resetPassword(email);
      // debugger();
      if (data != null) {
        isLoading = false;
        notifyListeners();
        Navigator.pop(context);
        return true;
      } else {
        isLoading = false;
        notifyListeners();

        Navigator.pop(context);
        return null;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      Navigator.pop(context);
      MyToast("Error $e");
      return null;
    }
  }

  DeleteAccount(context, token, password) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await APIsManager.deleteAccount(token, password);
      // debugger();
      if (data) {
        isLoading = false;
        notifyListeners();
        MyToast("Successfully Delete your Account");

        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoDialogRoute(
                builder: (_) => LoginScreen(), context: context),
            (route) => false);
      } else {
        isLoading = false;
        notifyListeners();

        MyToast("Password did not Match Please forget your Password",
            Type: false);
        Navigator.pop(context);
        Navigator.pop(context);
        return null;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      Navigator.pop(context);
      MyToast("Error $e");
      return null;
    }
  }

  logoutAccount(context, auth_token, authtype) async {
    logoutLoading = true;
    notifyListeners();
    try {
      if (authtype == "google") {
        await GoogleSignInHelper.signOut();
      }
      final data = await APIsManager.LogoutUser(auth_token);
      if (data != null) {
        // await AuthTokenStorage.removeAuthToken();
        isLoading = false;
        notifyListeners();
        // MyToast("Logout Successfully");
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoDialogRoute(
                builder: (_) => WelcomeScreen(), context: context),
            (route) => false);
      }
    } catch (e) {}
  }
}
