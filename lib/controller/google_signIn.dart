import 'package:client_nfc_mobile_app/controller/api_manager.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInHelper {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    clientId:
        '1036461909018-v32f9s35hefkbeq70gterh12sioug5a5.apps.googleusercontent.com',
  );

  // General Sign-In/Registration Function
  static Future<String?> handleGoogleSignIn(
      {bool forceAccountSelection = false}) async {
    try {
      if (forceAccountSelection) {
        // Sign out and disconnect any existing session to force account selection
        await _googleSignIn.signOut();
        await _googleSignIn.disconnect();
      }

      // Prompt the user to sign in or select an account
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
    } catch (error) {
      MyToast('Sign-in failed: $error', Type: false);
      return null;
    }
  }

  // Sign-In Function (Without forcing account selection)
  static Future<String?> signInWithGoogle() async {
    return await handleGoogleSignIn(forceAccountSelection: false);
  }

  // Register Function (Forcing account selection)
  static Future<String?> registerWithGoogle() async {
    return await handleGoogleSignIn(forceAccountSelection: false);
  }

  // Delete Account Function
  static Future<void> deleteAccount(
      context, String token, String userID) async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
      final data = await APIsManager.DeleteUserProfile(token, userID);
      if (data != null) {
        MyToast('Account has been deleted');
      }
    } catch (error) {
      print(error);
      MyToast('Failed to delete account');
    }
  }

  // Sign Out Function
  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
    } catch (e) {
      // MyToast(e.toString());
    }
  }
}
