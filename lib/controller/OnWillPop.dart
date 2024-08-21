import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

Future<bool> onWillPop(context) async {
  // Show a confirmation dialog when the user tries to exit
  final shouldExit = await
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: Text('Exit'),
      //     content: Text('Are you sure you want to exit the app?'),
      //     actions: [
      //       TextButton(
      //         onPressed: () => Navigator.of(context).pop(false),
      //         child: Text('No'),
      //       ),
      //       TextButton(
      //         onPressed: () {
      //           Navigator.of(context).pop(true);
      //           // Exit the app programmatically
      //           SystemNavigator.pop(); // For Android
      //           // For iOS, you may need to use a different approach
      //         },
      //         child: Text('Yes'),
      //       ),
      //     ],
      //   ),
      // );
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.containerColor8,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 30,
                            color: AppColors.textColor15,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.containerColor5,
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/images/icon1.png",
                          width: 47,
                          height: 63,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    Text(
                      "Are You Sure?",
                      style: TextStyle(
                        fontFamily: "GothamBold",
                        fontSize: 28.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textColor14,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You want to exit the app.",
                          style: TextStyle(
                            fontFamily: "GothamRegular",
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(true);
                              // Exit the app programmatically
                              SystemNavigator.pop(); // For Android
                              // For iOS, you may need to use a different approach
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 42,
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
                                  "Yes, Sure",
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
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: AppColors.containerColor8,
                                  border: const GradientBoxBorder(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor,
                                        AppColors.secondaryColor,
                                      ],
                                    ),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: GradientText(
                                    "No",
                                    style: TextStyle(
                                      fontFamily: "GothamRegular",
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    colors: [
                                      AppColors.textColor9,
                                      AppColors.textColor28,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });

  return shouldExit ?? false;
}
