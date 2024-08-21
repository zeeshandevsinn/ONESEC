import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/colors.dart';

class IndividualDigitalCard extends StatefulWidget {
  const IndividualDigitalCard({super.key});

  @override
  State<IndividualDigitalCard> createState() => _IndividualDigitalCardState();
}

class _IndividualDigitalCardState extends State<IndividualDigitalCard> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();

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
                  "My Profile",
                  style: TextStyle(
                    fontFamily: "GothamBold",
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor14,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      CircleAvatar(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            backgroundColor: AppColors.textColor14,
                            radius: 20,
                            child: Icon(
                              Icons.edit_outlined,
                              color: AppColors.containerColor8,
                            ),
                          ),
                        ),
                        radius: 62,
                        backgroundImage:
                            AssetImage("assets/images/profile4.png"),
                      ),
                      SizedBox(height: 14),
                      Text(
                        "Peter Parker",
                        style: TextStyle(
                          fontFamily: "GothamBold",
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor14,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Senior Flutter Developer",
                        style: TextStyle(
                          fontFamily: "GothamRegular",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor14,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
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
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 40,
                              height: 40,
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
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 40,
                              height: 40,
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
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 40,
                              height: 40,
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
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 40,
                              height: 40,
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
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                          children: [
                            TextField(
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor18,
                              ),
                              keyboardType: TextInputType.name,
                              controller: nameController,
                              cursorColor: AppColors.textColor18,
                              decoration: InputDecoration(
                                hintText: "User Name",
                                hintStyle: TextStyle(
                                  fontFamily: "GothamRegular",
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor17,
                                ),
                                suffix: Text(
                                  "John Doe",
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor18,
                                  ),
                                ),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: AppColors.containerColor4,
                                filled: true,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor18,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              cursorColor: AppColors.textColor18,
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  fontFamily: "GothamRegular",
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor17,
                                ),
                                suffix: Text(
                                  "john@email.com",
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor18,
                                  ),
                                ),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: AppColors.containerColor4,
                                filled: true,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor18,
                              ),
                              keyboardType: TextInputType.number,
                              controller: numberController,
                              cursorColor: AppColors.textColor18,
                              decoration: InputDecoration(
                                hintText: "Number",
                                hintStyle: TextStyle(
                                  fontFamily: "GothamRegular",
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor17,
                                ),
                                suffix: Text(
                                  "+1 84900 94046",
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor18,
                                  ),
                                ),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: AppColors.containerColor4,
                                filled: true,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor18,
                              ),
                              keyboardType: TextInputType.name,
                              controller: numberController,
                              cursorColor: AppColors.textColor18,
                              decoration: InputDecoration(
                                hintText: "Company",
                                hintStyle: TextStyle(
                                  fontFamily: "GothamRegular",
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor17,
                                ),
                                suffix: Text(
                                  "Company Name",
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor18,
                                  ),
                                ),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: AppColors.containerColor4,
                                filled: true,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              maxLines: 4,
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor18,
                              ),
                              keyboardType: TextInputType.name,
                              controller: numberController,
                              cursorColor: AppColors.textColor18,
                              decoration: InputDecoration(
                                hintText: "Bio/Description",
                                hintStyle: TextStyle(
                                  fontFamily: "GothamRegular",
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor17,
                                ),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: AppColors.containerColor4,
                                filled: true,
                              ),
                            ),
                            SizedBox(height: 32),
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
                                  "Save",
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
