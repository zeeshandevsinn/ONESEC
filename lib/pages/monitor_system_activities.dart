import 'package:flutter/material.dart';

import '../utils/colors.dart';

class MonitorSystemActivities extends StatefulWidget {
  const MonitorSystemActivities({super.key});

  @override
  State<MonitorSystemActivities> createState() =>
      _MonitorSystemActivitiesState();
}

class _MonitorSystemActivitiesState extends State<MonitorSystemActivities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor1,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  "Monitor System Activities",
                  style: TextStyle(
                    fontFamily: "GothamBold",
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor14,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  height: 345,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recent Activities",
                              style: TextStyle(
                                fontFamily: "GothamBold",
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor14,
                              ),
                            ),
                            Text(
                              "View All",
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor6,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.containerColor3,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.containerColor8,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: Image.asset(
                                    "assets/images/shoppingbag.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Shopping",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0XFF202020),
                                          ),
                                        ),
                                        Text(
                                          "06/20/2024 | 4:00 PM",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF707070),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  "\$50.0",
                                  style: TextStyle(
                                    fontFamily: "GothamBold",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.containerColor3,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.containerColor8,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: Image.asset(
                                    "assets/images/microscope.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Medication",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor14,
                                          ),
                                        ),
                                        Text(
                                          "06/24/2024 | 11:00 AM",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  "\$100.0",
                                  style: TextStyle(
                                    fontFamily: "GothamBold",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.containerColor3,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.containerColor8,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: Image.asset(
                                    "assets/images/house.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Property Tax",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor14,
                                          ),
                                        ),
                                        Text(
                                          "06/24/2024 | 2:00 PM",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  "\$300.0",
                                  style: TextStyle(
                                    fontFamily: "GothamBold",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
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
                SizedBox(height: 24),
                Container(
                  height: 345,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Alerts & Notifications",
                              style: TextStyle(
                                fontFamily: "GothamBold",
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor14,
                              ),
                            ),
                            Text(
                              "View All",
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor6,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.containerColor3,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.containerColor8,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: Image.asset(
                                    "assets/images/icon4.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Shopping",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0XFF202020),
                                          ),
                                        ),
                                        Text(
                                          "06/20/2024 | 4:00 PM",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF707070),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  "\$50.0",
                                  style: TextStyle(
                                    fontFamily: "GothamBold",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.containerColor3,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.containerColor8,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: Image.asset(
                                    "assets/images/icon4.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Medication",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor14,
                                          ),
                                        ),
                                        Text(
                                          "06/24/2024 | 11:00 AM",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  "\$100.0",
                                  style: TextStyle(
                                    fontFamily: "GothamBold",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.containerColor3,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.containerColor8,
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: Image.asset(
                                    "assets/images/icon4.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Property Tax",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor14,
                                          ),
                                        ),
                                        Text(
                                          "06/24/2024 | 2:00 PM",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Text(
                                  "\$300.0",
                                  style: TextStyle(
                                    fontFamily: "GothamBold",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
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
                SizedBox(height: 24),
                Container(
                  width: 398,
                  height: 220,
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 13, top: 23.0),
                        child: Text(
                          "System Status Summary",
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
                                        SizedBox(width: 4),
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
                                        SizedBox(width: 4),
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
                                        SizedBox(width: 4),
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
                                        SizedBox(width: 4),
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
                                        SizedBox(width: 4),
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
                          Image.asset(
                            "assets/images/icon3.png",
                            width: 94,
                            height: 94,
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
      ),
    );
  }
}
