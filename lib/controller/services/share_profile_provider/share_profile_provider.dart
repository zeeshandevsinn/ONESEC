import 'package:client_nfc_mobile_app/controller/services/share_profile_provider/share_profile_manager.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';

class ShareProfileProvider extends ChangeNotifier {
  bool isLoading = false;

  ShareProfileURL(authTOken) {
    isLoading = true;
    notifyListeners();
    try {
      final data = ShareProfileManager.shareProfileUrl(authTOken);
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
      MyToast(e.toString(), Type: false);
    }
  }

  ShareProfileThroughEmail(auth_token, email) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await ShareProfileManager.shareProfile(auth_token, email);
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
      MyToast(e.toString(), Type: false);
      return null;
    }
  }

  ReceivedProfiles(token) {
    isLoading = true;
    notifyListeners();
    try {
      final data = ShareProfileManager.getSharedProfiles(token);
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
      MyToast(e.toString(), Type: false);
      return null;
    }
  }
}
