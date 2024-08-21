import 'dart:convert';
import 'dart:developer';

import 'package:client_nfc_mobile_app/controller/api_manager.dart';
import 'package:client_nfc_mobile_app/controller/endpoints.dart';
import 'package:client_nfc_mobile_app/screens/welcome_screen.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInHelper {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    clientId:
        '1036461909018-v32f9s35hefkbeq70gterh12sioug5a5.apps.googleusercontent.com',
  );

  static Future<String?> signInWithGoogle() async {
    try {
      // Check if the user is already signed in
      if (_googleSignIn.currentUser != null) {
        // User is already signed in
        final GoogleSignInAccount? googleUser = _googleSignIn.currentUser;

        if (googleUser == null) {
          // User is signed in but googleUser is null
          MyToast('Error: Google user is null', Type: false);
          return null;
        }

        // Retrieve the authentication object
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Get the ID token
        final String? idToken = googleAuth.idToken;

        print("ID Token: $idToken");
        return idToken;
      } else {
        // User is not signed in, prompt sign-in
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        if (googleUser == null) {
          // The user canceled the sign-in
          MyToast('Sign-in canceled', Type: false);
          return null;
        }

        // Retrieve the authentication object
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Get the ID token
        final String? idToken = googleAuth.idToken;

        print("ID Token: $idToken");
        return idToken;
      }
    } catch (error) {
      MyToast('Sign-in failed: $error', Type: false);
      return null;
    }
  }

  static deleteAccount(context, token, userID) async {
    try {
      await _googleSignIn.signIn();

      GoogleSignInAccount? user = _googleSignIn.currentUser;
      if (user != null) {
        await _googleSignIn.disconnect();
        final data = await APIsManager.DeleteUserProfile(token, userID);
        if (data != null) {
          MyToast('Account has been deleted');
          return user;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (error) {
      print(error);
      MyToast('Failed to delete account');

      return null;
    }
  }
}
