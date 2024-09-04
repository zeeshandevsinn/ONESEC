import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/components/custom_buttons.dart';
import 'package:client_nfc_mobile_app/screens/signup_screen.dart';
import '../utils/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:gradient_borders/gradient_borders.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(34),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          width: 113,
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          "assets/images/welcomescreen.png",
                          width: 313,
                          fit: BoxFit.cover,
                        ),
                        GradientText(
                          'Welcome! to NFC',
                          style: TextStyle(
                            fontFamily: "GothamBold",
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                          ),
                          colors: [
                            AppColors.textColor1,
                            AppColors.textColor2,
                          ],
                        ),
                        SizedBox(height: 29),
                        Text(
                          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "GothamRegular",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor3,
                          ),
                        ),
                        SizedBox(height: 30),
                        CustomButton(text: "Sign In"),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
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
                                'Sign Up',
                                style: TextStyle(
                                  fontFamily: "GothamRegular",
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                                colors: [
                                  AppColors.textColor25,
                                  AppColors.textColor26,
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Text(
                        //   "I’ll do this later",
                        //   style: TextStyle(
                        //     fontFamily: "GothamRegular",
                        //     fontSize: 16.0,
                        //     fontWeight: FontWeight.w400,
                        //     color: AppColors.textColor4,
                        //   ),
                        // ),

                        SizedBox(height: 40),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "By proceedings, you agree to our",
                            style: TextStyle(
                              fontFamily: "GothamRegular",
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor5,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: " Terms & Conditions",
                                style: TextStyle(
                                  fontFamily: "GothamRegular",
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor6,
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: " and",
                                style: TextStyle(
                                  fontFamily: "GothamRegular",
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor5,
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: " Privacy Policy.",
                                style: TextStyle(
                                  fontFamily: "GothamRegular",
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor6,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
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
