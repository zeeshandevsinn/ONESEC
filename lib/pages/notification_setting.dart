import 'package:flutter/material.dart';

import '../utils/colors.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool value = false;
  onChangeFunction(bool newValue) {
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.backgroundColor1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Setting",
                  style: TextStyle(
                    fontFamily: "GothamBold",
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor14,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: 398,
                  height: 205,
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 13, top: 23.0, right: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Notification Settings",
                              style: TextStyle(
                                fontFamily: "GothamBold",
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor14,
                              ),
                            ),
                            SizedBox(height: 18),
                            Text(
                              "Manage how you are notified when you receive new notification. Please turn on the toggle to receive all notifications.",
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 12.0,
                                height: 1.5,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor18,
                              ),
                            ),
                            SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Push Notifications",
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor23,
                                  ),
                                ),
                                Switch(
                                  activeColor: AppColors.containerColor8,
                                  activeTrackColor: AppColors.switchColor,
                                  inactiveThumbColor: Colors.grey,
                                  inactiveTrackColor:
                                      Colors.grey.withOpacity(.2),
                                  value: value,
                                  onChanged: (newValue) {
                                    onChangeFunction(newValue);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
