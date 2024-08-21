import 'package:client_nfc_mobile_app/controller/interaction/Interaction_manager.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/material.dart';

class InteractionProvider extends ChangeNotifier {
  bool isLoading = false;
  createInteraction(userID) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await InteractionManager.createInteraction(userID);
      if (data != null) {
        isLoading = false;
        notifyListeners();
        return data;
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      MyToast("Check Internet Connection Please!.", Type: false);
      return null;
    }
  }
}
