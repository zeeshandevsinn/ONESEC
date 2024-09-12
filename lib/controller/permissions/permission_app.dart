import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class PermissionService {
  requestAllPermissions(BuildContext context) async {
    bool allPermissionsGranted = true;

    // Request location permission
    if (!(await _requestLocationPermission())) {
      allPermissionsGranted = false;
    }

    // Request background location permission for Android 10+
    if (Platform.isAndroid && (await _androidVersion()) >= 10) {
      if (!(await Permission.locationAlways.request().isGranted)) {
        allPermissionsGranted = false;
        _showPermissionDialog(context, 'Background Location');
      }
    }

    // Request storage permission
    // if (Platform.isAndroid && (await _androidVersion()) >= 11) {
    //   if (!(await Permission.manageExternalStorage.request().isGranted)) {
    //     allPermissionsGranted = false;
    //     _showPermissionDialog(context, 'Manage External Storage');
    //   }
    // } else {
    //   if (!(await Permission.storage.request().isGranted)) {
    //     allPermissionsGranted = false;
    //     _showPermissionDialog(context, 'Storage');
    //   }
    // }

    // Request camera permission
    if (!(await Permission.camera.request().isGranted)) {
      allPermissionsGranted = false;
      _showPermissionDialog(context, 'Camera');
    }

    // Request notification permission
    if (!(await Permission.notification.request().isGranted)) {
      allPermissionsGranted = false;
      _showPermissionDialog(context, 'Notification');
    }
    // debugger();
    // Navigate to the welcome screen if all permissions are granted
    if (allPermissionsGranted) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setBool('allPermissions', true);
      return true;
    }
  }

  Future<bool> _requestLocationPermission() async {
    final status = await Permission.location.request();
    return status == PermissionStatus.granted;
  }

  Future<int> _androidVersion() async {
    if (Platform.isAndroid) {
      // Split by spaces to get different parts of the version string
      final parts = Platform.operatingSystemVersion.split(' ');

      // Ensure we have enough parts to safely access the expected part of the string
      if (parts.length >= 2) {
        final versionParts = parts[1].split('.');

        // Safely check if we have a valid version number before trying to parse it
        if (versionParts.isNotEmpty) {
          return int.tryParse(versionParts[0]) ?? 0;
        }
      }
    }
    return 0; // Return 0 for non-Android platforms or if parsing fails
  }

  void _showPermissionDialog(BuildContext context, String permissionName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$permissionName Permission Required'),
          content: Text(
              'This app requires $permissionName permission to function properly. Please grant the permission in the settings.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
              child: Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }
}
