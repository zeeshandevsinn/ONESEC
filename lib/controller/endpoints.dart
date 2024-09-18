class EndPointsURLs {
  static const String BASE_URL = "https://api.onesec.shop/";
  static const String register_Endpoint = "auth/users/";
  static const String login_Endpoint = "auth/custom/token/login/";
  static const String activation_Endpoint = "auth/users/activation/";
  static const String user_profile_Endpoint = "auth/users/me/";
  static const String user_reset_password = "auth/users/reset_password/";
  static const String googleSignInURl = "auth/custom-google-login/";
  static const String delete_account = "auth/users/me/";
  static const String profile_account = "api/profiles/";
  static const String get_appointments = "api/get-meetings/";
  static const String change_password =
      'https://api.onesec.shop/auth/users/set_password/';
//https://waqar123.pythonanywhere.com/
//   Reset Password/ Forget Password:
// POST:|
// /auth/users/reset_password/
// Body: email
// Response: Reset Password link sent to email. (user will reset password on browser)

// Delete Account
// /auth/users/me/
// DELETE
// Body: {
//                 headers: {
//                     Authorization: Token ${authToken},
//                 },
//                 data: { current_password: password }
//             }
}
