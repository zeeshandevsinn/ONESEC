import 'package:client_nfc_mobile_app/company_admin_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/controller/services/account%20update/account_update_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/appointment/appoinment_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/company_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/google_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/login_api.dart';
import 'package:client_nfc_mobile_app/controller/services/register_api.dart';
import 'package:client_nfc_mobile_app/controller/services/share_profile_provider/share_profile_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/user_profile_provider.dart';
import 'package:client_nfc_mobile_app/individual_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/screens/welcome_screen.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controller/prefrences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegistProvider()),
        ChangeNotifierProvider(create: (_) => LoginUserProvider()),
        ChangeNotifierProvider(create: (_) => GoogleProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => AccountUpdateProvider()),
        ChangeNotifierProvider(create: (_) => ShareProfileProvider()),
        ChangeNotifierProvider(create: (_) => CompanyProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor1,
          fontFamily: "Gotham",
        ),
        home: FutureBuilder<User?>(
          future: _fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Image.asset('assets/images/logo.png'),
              ); // Show a loading spinner
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null) {
              return WelcomeScreen(); // User not logged in
            } else {
              final User user = snapshot.data!;
              final String authToken = authTokenUser!;
              if (user.profileType == "company") {
                return CompanyAdminBottomNavigationBar(
                  profileData: null,
                  authToken: authToken,
                  userDetails: user,
                );
              } else {
                return IndividualBottomNavigationBar(
                  user_auth_token: authToken,
                  futureUser: user,
                );
              }
            }
          },
        ),
      ),
    );
  }

  String? authTokenUser;
  Future<User?> _fetchUserData() async {
    authTokenUser = await AuthTokenStorage.getAuthToken();
    if (authTokenUser != null && authTokenUser!.isNotEmpty) {
      try {
        return await UserService().fetchUser(authTokenUser);
      } catch (e) {
        print("Error fetching user data: $e");
        return null;
      }
    }
    return null;
  }
}
