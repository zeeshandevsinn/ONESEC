import 'dart:developer';

import 'package:client_nfc_mobile_app/screens/welcome_screen.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:geolocator/geolocator.dart';

import '../controller/permissions/permission_app.dart'; // Import Geolocator package

class AllowPermissionScreen extends StatefulWidget {
  const AllowPermissionScreen({super.key});

  @override
  State<AllowPermissionScreen> createState() => _AllowPermissionScreenState();
}

class _AllowPermissionScreenState extends State<AllowPermissionScreen> {
  bool _isLoading = false; // Loading state

  Future<void> _checkPermissions() async {
    setState(() {
      _isLoading = true; // Show loader when checking permissions
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check stored permission statuses
    // bool storagePermissionGranted = prefs.getBool('storagePermission') ?? false;
    bool notificationPermissionGranted =
        prefs.getBool('notificationPermission') ?? false;
    bool locationPermissionGranted =
        prefs.getBool('locationPermission') ?? false;

    if (
        // storagePermissionGranted &&
        notificationPermissionGranted && locationPermissionGranted) {
      // All permissions are already granted, navigate to the next screen
      _navigateToWelcomeScreen();
    } else {
      // Request missing permissions
      _requestPermissions();
    }
  }

  Future<void> _requestPermissions() async {
    try {
      // Request permissions
      // PermissionStatus storagePermission = await Permission.storage.request();
      PermissionStatus notificationPermission =
          await Permission.notification.request();
      PermissionStatus locationPermission = await Permission.location.request();

      // Save permissions to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setBool('storagePermission', storagePermission.isGranted);
      await prefs.setBool(
          'notificationPermission', notificationPermission.isGranted);
      await prefs.setBool('locationPermission', locationPermission.isGranted);

      // Check if all permissions are granted
      if (
          // storagePermission.isGranted &&
          notificationPermission.isGranted && locationPermission.isGranted) {
        // Handle location permission and fetch location if granted
        if (locationPermission.isGranted) {
          try {
            Position? position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            if (position != null) {
              String locationData =
                  "${position.latitude},${position.longitude}";
              await prefs.setString('userLocation', locationData);
            }
          } catch (e) {
            log('Error fetching location: $e');
          }
        }

        // Navigate to the next screen if all permissions are granted
        _navigateToWelcomeScreen();
      } else {
        // Show an alert if any permission is denied
        _showPermissionAlert();
      }
    } catch (e) {
      // If an error occurs, stop the loading and show the button again
      setState(() {
        _isLoading = false;
      });
      MyToast('Error requesting permissions: $e', Type: false);
      _showPermissionAlert();
    }
  }

  void _navigateToWelcomeScreen() {
    MyToast("All permissions granted. Thank you!");
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoDialogRoute(builder: (_) => WelcomeScreen(), context: context),
      (route) => false,
    );
  }

  void _showPermissionAlert() {
    setState(() {
      _isLoading = false; // Hide loader and show the button
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Permissions Required"),
          content: Text("Please allow all permissions to continue."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _requestPermissions(); // Re-request permissions
              },
              child: Text("Retry"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings(); // Navigate to app settings to allow permissions
              },
              child: Text("Go to Settings"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/permission_icon.png'))),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Allow Permission",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "GothamBold",
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "OneSec requires a few essential permissions to access data from multiple sources and manage notifications.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: "GothamRegular",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        height: 1.7,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Permission ListTiles here...
              ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withOpacity(.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications,
                    color: AppColors.secondaryColor,
                    size: 30,
                  ),
                ),
                title: Text(
                  "Notifications",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "GothamBold",
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Allow OneSec to send you real-time notifications about your OneSec activities.",
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "GothamRegular",
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.photo_camera_back_outlined,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                ),
                title: Text(
                  "Media/Gallery",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "GothamBold",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  "Allow OneSec to access your media in your device's gallery.",
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "GothamRegular",
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: 10),
              ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                ),
                title: Text(
                  "Location",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "GothamBold",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  "Allow OneSec to access your location to provide personalized services.",
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "GothamRegular",
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _isLoading
                  ? CircularProgressIndicator() // Show loader
                  : GestureDetector(
                      // onTap: _checkPermissions,
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        final data = await PermissionService()
                            .requestAllPermissions(context);
                        if (data) {
                          setState(() {
                            _isLoading = false;
                          });

                          _navigateToWelcomeScreen();
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                          MyToast("Please Allow All the Permissions",
                              Type: false);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .8,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.secondaryColor,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "Allow Permissions",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "GothamRegular",
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor24,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoDialogRoute(
                        builder: (_) => WelcomeScreen(), context: context),
                    (route) => false,
                  );
                },
                child: GradientText(
                  "Skip for Now",
                  colors: [AppColors.primaryColor, AppColors.secondaryColor],
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "GothamBold",
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
