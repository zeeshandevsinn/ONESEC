import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpMenuItems {
  static const String accountSetting = "Account Setting";
  // static const String monitorSetting = "Monitor Setting";
  static const String notification = "Notifications";
  static const String deleteAccount = "Account Delete";
  static const String shareprofile = "Share Profile";
  static const String receivedProfiles = "Received Profile";
  static const String logout = "Logout";

  static const List<String> choices = <String>[
    accountSetting,
    // monitorSetting,
    notification,
    deleteAccount,
    shareprofile,
    receivedProfiles,
    logout
  ];

  // for Icons
  static const Map<String, IconData> choiceIcons = <String, IconData>{
    accountSetting: Icons.settings_rounded,
    // monitorSetting: Icons.monitor_rounded,
    notification: Icons.notifications_on_rounded,
    deleteAccount: Icons.person_remove_alt_1_rounded,
    shareprofile: Icons.share,
    receivedProfiles: Icons.recent_actors,
    logout: Icons.logout
  };
}

class CompanyPopUpMenuItems {
  static const String accountSetting = "Account Setting";
  static const String updateProfile = "Update Profile";
  static const String notification = "Notifications";
  static const String deleteAccount = "Account Delete";
  static const String manageUser = "Manage Users";
  static const String shareprofile = "Share Profile";
  static const String receivedProfiles = "Received Profile";
  static const String logout = "Logout";

  static const List<String> choices = <String>[
    accountSetting,
    updateProfile,
    notification,
    deleteAccount,
    manageUser,
    shareprofile,
    receivedProfiles,
    logout
  ];

  // for Icons
  static const Map<String, IconData> choiceIcons = <String, IconData>{
    accountSetting: Icons.settings_rounded,
    updateProfile: Icons.edit_note_sharp,
    notification: Icons.notifications_on_rounded,
    deleteAccount: Icons.person_remove_alt_1_rounded,
    manageUser: Icons.manage_accounts,
    shareprofile: Icons.share,
    receivedProfiles: Icons.recent_actors,
    logout: Icons.logout
  };
}
