import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:client_nfc_mobile_app/screens/login_screen.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:client_nfc_mobile_app/components/social_media_buttons.dart';

class ActivationScreen extends StatefulWidget {
  const ActivationScreen({super.key});

  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  Future<void> _openGmail() async {
    const gmailUrl = 'mailto:';
    if (await canLaunch(gmailUrl)) {
      await launch(gmailUrl);
    } else {
      throw 'Could not launch $gmailUrl';
    }
  }

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
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(34),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 113,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 13.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.containerColor1,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(
                                  "English (United States)",
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor7,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: GradientText(
                          "VERIFY ACCOUNT!",
                          style: TextStyle(
                            fontFamily: "GothamBold",
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700,
                          ),
                          colors: [
                            AppColors.textColor1,
                            AppColors.textColor2,
                          ],
                        ),
                      ),
                      SizedBox(height: 17),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Text(
                          "Please Verify Your Account through Gmail where OneSec sent you a mail for activation your account",
                          style: TextStyle(
                            fontFamily: "GothamRegular",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor8,
                          ),
                        ),
                      ),
                      SizedBox(height: 22),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await _openGmail();
                              },
                              child: SocialMediaButtons(
                                image: "assets/images/googleicon.png",
                                text: "Go to Gmail",
                              ),
                            ),
                            SizedBox(height: 16),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) => LoginScreen()),
                                    (route) => false);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 42,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.primaryColor,
                                      AppColors.secondaryColor,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Login",
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
                          ],
                        ),
                      ),
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
