import 'package:client_nfc_mobile_app/controller/NFC/nfc_manager.dart';
import 'package:flutter/material.dart';

class NFcProvider extends ChangeNotifier {
  bool isLoading = false;

  NFCWriteMethod(authToken, Map<String, dynamic> profileData) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await NfcService(authToken: authToken).nfcWrite(profileData);
      if (data != null) {
        isLoading = false;
        notifyListeners();
        return data;
      } else {
        isLoading = false;
        notifyListeners();
        return data;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return null;
    }
  }
}
