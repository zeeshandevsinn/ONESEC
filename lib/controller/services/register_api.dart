import 'dart:developer';

import 'package:client_nfc_mobile_app/screens/activation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/controller/api_manager.dart';
import 'package:client_nfc_mobile_app/screens/login_screen.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';

class RegistProvider extends ChangeNotifier {
  bool isLoading = false;

  registerUsers(
      context,
      String first_name,
      String last_name,
      String email,
      String username,
      String password,
      String company,
      String admin,
      profile_type,
      String auth_type) async {
    try {
      isLoading = true;
      notifyListeners();
      final data = await APIsManager.RegisterUsers(first_name, last_name, email,
          username, password, company, admin, profile_type, auth_type);
      if (data != null) {
        isLoading = false;
        notifyListeners();
        Navigator.pop(context);
        MyToast("Register Success");
        Navigator.push(
            context,
            CupertinoDialogRoute(
                builder: (_) => ActivationScreen(), context: context));
      } else {
        // debugger();

        MyToast("Internet Network Issue 404 error", Type: false);
        notifyListeners();
        isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } catch (e) {
      // debugger();
      MyToast("Error! $e", Type: false);
      isLoading = false;
      notifyListeners();
    }
  }

  startLoading(context) async {
    // Show the loader dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Loading..."),
              ],
            ),
          ),
        );
      },
    );

    // Simulate a network request or any async operation
    // await Future.delayed(Duration(seconds: 3));

    // // Close the loader dialog and update the state
  }
}
