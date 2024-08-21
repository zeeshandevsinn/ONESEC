import 'dart:developer';

import 'package:client_nfc_mobile_app/controller/api_manager.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  bool isLoading = false;

  GetUserProfile(userID, authToken) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await APIsManager.GetUserProfileData(userID, authToken);
      isLoading = false;
      notifyListeners();
      return data;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      MyToast("Internet Issue 404 error");
      return null;
    }
  }

  CreateProfileData(
      {required final authToken,
      required String firstName,
      required String lastName,
      required String email,
      required String position,
      required String phone,
      required String address,
      required String bio,
      String? facebook,
      String? instagram,
      String? website,
      String? linkedin,
      String? github,
      required int whatsapp,
      String? profilePic,
      required int user}) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await APIsManager.CreateUserProfile(
          authToken: authToken,
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          address: address,
          bio: bio,
          whatsapp: whatsapp,
          user: user,
          facebook: facebook,
          instagram: instagram,
          website: website,
          linkedin: linkedin,
          github: github,
          profilePic: profilePic,
          position: position);
      isLoading = false;
      notifyListeners();
      return data;
    } catch (e) {
      // debugger();
      isLoading = false;
      notifyListeners();
      MyToast("Server Issue 404 error", Type: false);
      return null;
    }
  }

  UpdateUserProfile(
      {required final authToken,
      required int id,
      required String firstName,
      required String lastName,
      required String email,
      required String position,
      required String phone,
      required String address,
      required String bio,
      String? facebook,
      String? instagram,
      String? website,
      String? linkedin,
      String? github,
      required int whatsapp,
      String? profilePic,
      required int user}) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await APIsManager.UpdateUserProfileDetails(
          authToken: authToken,
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          address: address,
          bio: bio,
          whatsapp: whatsapp,
          user: user,
          facebook: facebook,
          instagram: instagram,
          website: website,
          linkedin: linkedin,
          github: github,
          profilePic: profilePic,
          position: position);
      if (data != null) {
        isLoading = false;
        notifyListeners();
        MyToast("Profile Update Successfully");
        return data;
      } else {
        isLoading = false;
        notifyListeners();
        MyToast("Here Some thing issue through Server", Type: false);
        return null;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      MyToast("Internet Issue 404 error", Type: false);
      // debugger();
      return null;
    }
  }
}
