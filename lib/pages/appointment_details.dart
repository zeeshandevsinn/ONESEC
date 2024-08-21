import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AppointmentsDetails extends StatefulWidget {
  const AppointmentsDetails({super.key});

  @override
  State<AppointmentsDetails> createState() => _AppointmentsDetailsState();
}

class _AppointmentsDetailsState extends State<AppointmentsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.backgroundColor1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Appointment Detail",
                  style: TextStyle(
                    fontFamily: "GothamBold",
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor14,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  height: 780,
                  width: 398,
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.containerColor3,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(16, 16, 0, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 24),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.containerColor8,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Container(
                                              width: 64,
                                              height: 64,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/images/profile12.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    'Rating',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "GothamRegular",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13,
                                                      letterSpacing: 0.2,
                                                      color: Color(0XFF71717A),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      size: 15,
                                                      color: Color(0XFFF38744),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 15,
                                                      color: Color(0XFFF38744),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 15,
                                                      color: Color(0XFFF38744),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      size: 15,
                                                      color: Color(0XFFF38744),
                                                    ),
                                                    Icon(
                                                      Icons.star_half_outlined,
                                                      size: 15,
                                                      color: Color(0XFFF38744),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  '4.5',
                                                  style: TextStyle(
                                                    fontFamily: "GothamRegular",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    letterSpacing: 0.2,
                                                    color: Color(0XFF71717A),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Dr. Stone Gaze',
                                              style: TextStyle(
                                                fontFamily: "GothamBold",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                                height: 1.8,
                                                color: AppColors.textColor12,
                                              ),
                                            ),
                                            Text(
                                              'Ear, Nose & Throat specialist',
                                              style: TextStyle(
                                                fontFamily: "GothamRegular",
                                                fontSize: 14.0,
                                                height: 1.7,
                                                letterSpacing: 0.2,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0XFF71717A),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Summary ',
                                        style: TextStyle(
                                          fontFamily: "GothamBold",
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textColor12,
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Text(
                                        'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                                        style: TextStyle(
                                          fontFamily: "GothamRegular",
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textColor12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: 136,
                            decoration: BoxDecoration(
                              color: AppColors.containerColor3,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, left: 12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Summary ',
                                        style: TextStyle(
                                          fontFamily: "GothamBold",
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textColor12,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Container(
                                            width: 42,
                                            height: 42,
                                            decoration: BoxDecoration(
                                              color: Color(0XFFC6D4F1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                width: 1,
                                                color: Color(0XFFA0B6EA),
                                              ),
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                "assets/images/menuboard.png",
                                                width: 28,
                                                height: 24,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Appointment",
                                                style: TextStyle(
                                                  fontFamily: "GothamRegular",
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0XFF71717A),
                                                ),
                                              ),
                                              Text(
                                                "Wednesday, 10 Jan 2024, 11:00",
                                                style: TextStyle(
                                                  fontFamily: "GothamBold",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0XFF18181B),
                                                ),
                                              ),
                                              Text(
                                                "49th Avenue Broadway, NY",
                                                style: TextStyle(
                                                  fontFamily: "GothamRegular",
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0XFF71717A),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: 106,
                            decoration: BoxDecoration(
                              color: AppColors.containerColor3,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 16, left: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Google Meet Link',
                                        style: TextStyle(
                                          fontFamily: "GothamBold",
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textColor12,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "https//:www.google.meet/It is a long fact that a reader will be distracted",
                                        style: TextStyle(
                                          fontFamily: "GothamRegular",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0XFF71717A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                    "Edit Appointment",
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
                              Container(
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
                                    "Cancel Appointment",
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
                            ],
                          ),
                        ),
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
