import 'dart:developer';
import 'package:client_nfc_mobile_app/controller/NFC/nfc_provider/nfc_provider.dart';
import 'package:client_nfc_mobile_app/controller/prefrences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:client_nfc_mobile_app/controller/geo_view_data/geo_provider.dart';
import 'package:client_nfc_mobile_app/controller/interaction/services/interaction_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/account%20update/account_update_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/appointment/appoinment_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/company_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/google_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/login_api.dart';
import 'package:client_nfc_mobile_app/controller/services/register_api.dart';
import 'package:client_nfc_mobile_app/controller/services/share_profile_provider/share_profile_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/user_profile_provider.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:client_nfc_mobile_app/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  // clearStoredPermissions();

  runApp(MyApp());
}

void clearStoredPermissions() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('allPermissionsGranted');
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
        ChangeNotifierProvider(create: (_) => GeoProvider()),
        ChangeNotifierProvider(create: (_) => InteractionProvider()),
        ChangeNotifierProvider(create: (_) => NFCNotifier()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.backgroundColor1,
          fontFamily: "Gotham",
        ),
        home: ConnectivityCheck(
          child: SplashScreen(), // Use the animated splash screen here
        ),
      ),
    );
  }
}

class ConnectivityCheck extends StatefulWidget {
  final Widget child;

  ConnectivityCheck({required this.child});

  @override
  _ConnectivityCheckState createState() => _ConnectivityCheckState();
}

class _ConnectivityCheckState extends State<ConnectivityCheck> {
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = result != ConnectivityResult.none;
    });

    // Listen to connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        isConnected = result != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isConnected
        ? widget.child
        : const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wifi_off, size: 100, color: Colors.red),
                  SizedBox(height: 20),
                  Text(
                    'No internet connection',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    'Waiting for connection...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
  }
}

String? authTokenUser;

Future<User?> _fetchUserData() async {
  authTokenUser = await AuthTokenStorage.getAuthToken();

  if (authTokenUser == null) {
    log("Auth token is null");
    return null;
  }

  try {
    final User userDetails = await UserService().fetchUser(authTokenUser!);
    return userDetails;
  } catch (e) {
    log("Error fetching user data: $e");
    return null;
  }
}
