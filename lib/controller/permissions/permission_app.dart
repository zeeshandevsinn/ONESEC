// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PermissionService {
//   // Request all necessary permissions, including storage
//   Future<bool> requestAllPermissions(BuildContext context) async {
//     bool allPermissionsGranted = await _checkPermissions();

//     if (!allPermissionsGranted) {
//       _showPermissionRationale(context);
//     }

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('allPermissionsGranted', allPermissionsGranted);

//     return allPermissionsGranted;
//   }

//   // Check and request permissions
//   Future<bool> _checkPermissions() async {
//     Map<Permission, PermissionStatus> statuses;

//     // Request appropriate storage permissions based on Android version
// if (Platform.isAndroid) {
//   statuses = await [Permission.manageExternalStorage].request();
// } else {
//   statuses = await [Permission.storage].request();
// }

//     // Check if all permissions are granted
//     bool allPermissionsGranted =
//         statuses.values.every((status) => status.isGranted);

//     // Handle denied permissions
//     if (!allPermissionsGranted) {
//       await _handleDeniedPermissions(statuses);
//     }

//     return allPermissionsGranted;
//   }

//   // Show rationale for requesting permissions again
//   void _showPermissionRationale(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Permission Required'),
//         content: Text(
//             'This app requires storage permission to access files. Please enable it in the settings.'),
//         actions: [
//           TextButton(
//             child: Text('Open Settings'),
//             onPressed: () async {
//               Navigator.pop(context);
//               await openAppSettings();
//             },
//           ),
//           TextButton(
//             child: Text('Cancel'),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // Handle denied permissions
//   Future<void> _handleDeniedPermissions(
//       Map<Permission, PermissionStatus> statuses) async {
//     statuses.forEach((permission, status) async {
//       if (status.isPermanentlyDenied) {
//         // Open app settings if permanently denied
//         await openAppSettings();
//       }
//     });
//   }

//   // Retrieve Android version
//   Future<int> _androidVersion() async {
//     if (Platform.isAndroid) {
//       final versionParts = Platform.operatingSystemVersion.split(' ');
//       if (versionParts.length >= 2) {
//         return int.tryParse(versionParts[1].split('.')[0]) ?? 0;
//       }
//     }
//     return 0;
//   }
// }

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionService {
  // Request all necessary permissions, including storage, location, and camera
  Future<bool> requestAllPermissions(BuildContext context) async {
    // Check all permissions
    bool allPermissionsGranted = await _checkPermissions();

    // If not all permissions are granted, show the rationale
    if (!allPermissionsGranted) {
      _showPermissionRationale(context);
    }

    // Store permission status in shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('allPermissionsGranted', allPermissionsGranted);

    return allPermissionsGranted;
  }

  // Check and request permissions
  Future<bool> _checkPermissions() async {
    Map<Permission, PermissionStatus> statuses;
    final value = await getAndroidVersion();
    int number = int.parse(value);

    print('Version: $number');
    // debugger();
    // For Android 11 and above, request manageExternalStorage
    if (Platform.isAndroid && number >= 11) {
      statuses = await [
        // Permission.storage,
        Permission.camera,
        Permission.location,
        Permission.manageExternalStorage, // Android 11+
        Permission.notification // Android 13+
      ].request();
    }

    // For Android 10 and below, request regular storage permission
    else if (Platform.isAndroid && number < 11) {
      // debugger();
      statuses = await [
        Permission.storage,
        Permission.camera,
        Permission.location,
        Permission.notification,
        // Permission.gallery
        // No need to request manageExternalStorage for Android <11
      ].request();
    }
    // For non-Android platforms (iOS or others)
    else {
      // debugger();
      statuses = await [
        Permission.storage,
        Permission.camera,
        Permission.location,
        Permission.notification
      ].request();
    }

    // Check if all permissions are granted
    bool allPermissionsGranted =
        statuses.values.every((status) => status.isGranted);

    // If any permission is denied, handle it
    if (!allPermissionsGranted) {
      await _handleDeniedPermissions(statuses);
    }

    return allPermissionsGranted;
  }

  // Show rationale for requesting permissions again
  void _showPermissionRationale(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permission Required'),
        content: Text(
            'This app requires certain permissions (storage, camera, location) to work properly. Please enable them in the settings.'),
        actions: [
          TextButton(
            child: Text('Open Settings'),
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // Handle denied permissions (either temporarily or permanently)
  Future<void> _handleDeniedPermissions(
      Map<Permission, PermissionStatus> statuses) async {
    statuses.forEach((permission, status) async {
      if (status.isPermanentlyDenied) {
        // If permission is permanently denied, guide user to app settings
        await openAppSettings();
      } else if (status.isDenied) {
        // Optionally, log denied permissions or handle them as needed
        print('$permission was denied.');
      }
    });
  }

  // Retrieve Android version
  getAndroidVersion() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo
          .version.release; // This gets the Android version (e.g., "11", "12")
    }
    return null;
  }
}
