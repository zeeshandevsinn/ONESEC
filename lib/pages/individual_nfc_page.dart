import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:client_nfc_mobile_app/components/custom_dialog_box.dart';
import '../utils/colors.dart';

class IndividualNFCPage extends StatefulWidget {
  const IndividualNFCPage({super.key});

  @override
  State<IndividualNFCPage> createState() => _IndividualNFCPageState();
}

class _IndividualNFCPageState extends State<IndividualNFCPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "NFC Card Management",
                  style: TextStyle(
                    fontFamily: "GothamBold",
                    fontSize: 26.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor14,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  width: 398,
                  height: 240,
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 23, top: 23.0),
                        child: Text(
                          "Instructions",
                          style: TextStyle(
                            fontFamily: "GothamBold",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor14,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: AppColors.containerColor13,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Contrary to popular belief.",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: AppColors.containerColor13,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Lorem Contrary to popular belief.",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Color(0xffD9D9D9),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Popular contrary to popular.",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Color(0xffD9D9D9),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Lorem Contrary to popular belief.",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Color(0xffD9D9D9),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "Contrary to popular belief.",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Image.asset(
                            "assets/images/couple.png",
                            width: 80,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showAlertDialog(context);
                      },
                      child: Container(
                        width: 160,
                        height: 40,
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
                            "Read Card",
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
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomDialogBox(),
                        );
                      },
                      child: Container(
                        width: 150,
                        height: 40,
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
                            "Write Profile",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/images/background.png",
                    height: height / 3,
                  ),
                  Positioned(
                    bottom: -50,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: AppColors.backgroundColor1,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            AssetImage("assets/images/profile2.png"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Center(
                child: Column(
                  children: [
                    Text(
                      "John Doe",
                      style: TextStyle(
                        fontFamily: "GothamBold",
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textColor14,
                      ),
                    ),
                    Text(
                      "Senior Flutter Developer",
                      style: TextStyle(
                        fontFamily: "GothamRegular",
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor15,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.facebookF,
                          color: AppColors.containerColor8,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.google,
                          color: AppColors.containerColor8,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.github,
                          color: AppColors.containerColor8,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.slack,
                          color: AppColors.containerColor8,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.linkedin,
                          color: AppColors.containerColor8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "About",
                  style: TextStyle(
                    fontFamily: "GothamBold",
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor14,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "A Flutter Developer is a software engineer who specializes in building cross-platform mobile, web, and desktop applications using the Flutter framework and Dart programming language for seamless, high-performance user experiences.",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
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
                        "Read",
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
              ),
            ],
          ),
        );
      });
}
