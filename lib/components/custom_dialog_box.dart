import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CustomDialogBox extends StatelessWidget {
  const CustomDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
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
                  "You want to write your profile",
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
                  Container(
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
  }
}
