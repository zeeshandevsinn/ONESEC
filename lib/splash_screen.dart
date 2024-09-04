import 'dart:async';
import 'dart:developer';
import 'package:client_nfc_mobile_app/company_admin_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/controller/prefrences.dart';
import 'package:client_nfc_mobile_app/individual_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/permissions/allow_permission.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/screens/welcome_screen.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    // Navigate to the next screen after animation and permission check
    Future.delayed(const Duration(seconds: 3), () {
      _checkPermissionsAndNavigate();
    });
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

  Future<void> _checkPermissionsAndNavigate() async {
    // Check if permissions are already granted
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool AllPermissions = prefs.getBool('allPermissions') ?? false;
    // bool storagePermissionGranted = prefs.getBool('storagePermission') ?? false;
    // bool notificationPermissionGranted =
    //     prefs.getBool('notificationPermission') ?? false;
    // bool locationPermissionGranted =
    //     prefs.getBool('locationPermission') ?? false;

    // debugger();
    if (AllPermissions) {
      log("Permission Successfully");
      // All permissions are granted, proceed with user authentication
      User? user = await _fetchUserData();
      if (user != null && authTokenUser != null) {
        _navigateToHome(user);
      } else {
        _navigateToWelcomeScreen();
      }
    } else {
      // Permissions are not granted, navigate to AllowPermissionScreen
      _navigateToPermissionScreen();
    }
  }

  void _navigateToHome(User user) {
    if (user.profileType == "company") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CompanyAdminBottomNavigationBar(
            profileData: null,
            authToken: authTokenUser!,
            userDetails: user,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => IndividualBottomNavigationBar(
            user_auth_token: authTokenUser!,
            futureUser: user,
          ),
        ),
      );
    }
  }

  void _navigateToWelcomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
  }

  void _navigateToPermissionScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AllowPermissionScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      body: Stack(
        children: [
          // Background Animation (Optional)
          Positioned.fill(
            child: Container(
              color: Colors.black,
            ),
          ),
          // Fade in Logo
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                'assets/images/logo.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
