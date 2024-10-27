import 'dart:developer';

import 'package:client_nfc_mobile_app/controller/api_manager.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/material.dart';

class AccountUpdateProvider extends ChangeNotifier {
  bool isLoading = false;

  SetPassword(auth_token, current_password, new_password) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await APIsManager.ChangePassword(
          auth_token, current_password, new_password);

      if (data != null) {
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        MyToast("Try Again", Type: false);
      }
    } catch (e) {
      // debugger();
      isLoading = false;
      notifyListeners();
      // MyToast("Internet Issue Try Again", Type: false);
    }
  }
}
