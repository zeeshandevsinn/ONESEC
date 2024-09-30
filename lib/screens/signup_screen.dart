import 'dart:developer';

import 'package:client_nfc_mobile_app/controller/services/google_provider.dart';
import 'package:client_nfc_mobile_app/screens/activation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/controller/services/register_api.dart';
import 'package:client_nfc_mobile_app/screens/company_admin.dart';
import 'package:client_nfc_mobile_app/screens/login_screen.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../components/custom_text_field.dart';
import '../components/social_media_buttons.dart';
import '../utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  final firstNamController = TextEditingController();
  final lastNamController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var form_key = GlobalKey<FormState>();

  bool _isLoading = false;

  _startLoading() async {
    setState(() {
      _isLoading = true;
    });

    // Show the loader dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Loading..."),
              ],
            ),
          ),
        );
      },
    );

    // Simulate a network request or any async operation
    // await Future.delayed(Duration(seconds: 3));

    // // Close the loader dialog and update the state
  }

  void _stopLoading() {
    Navigator.of(context).pop();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RegistProvider>();
    context.read<GoogleProvider>();
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Loading..."),
              ],
            ),
          ),
        );
      },
    );
  }

  void _dismissLoadingDialog(BuildContext context) {}

  bool tab = true;
  final companyController = TextEditingController();

  final adminController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        var pro = context.watch<RegistProvider>();
        var gro = context.watch<GoogleProvider>();
        if (pro.isLoading || gro.isLoading) {
          Future.microtask(() => _showLoadingDialog(context));
        }
        return SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                              // Spacer(),
                              // Row(
                              //   children: [
                              //     Text(
                              //       "English (United States)",
                              //       style: TextStyle(
                              //         fontFamily: "GothamRegular",
                              //         fontSize: 14.0,
                              //         fontWeight: FontWeight.w400,
                              //         color: AppColors.textColor7,
                              //       ),
                              //     ),
                              //     Icon(
                              //       Icons.arrow_drop_down,
                              //       color: Colors.black,
                              //       size: 30,
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: GradientText(
                            "Welcome",
                            style: TextStyle(
                              fontFamily: "GothamBold",
                              fontSize: 32.0,
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
                            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                            style: TextStyle(
                              fontFamily: "GothamRegular",
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor8,
                            ),
                          ),
                        ),
                        SizedBox(height: 27),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.containerColor2,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                tab
                                    ? GestureDetector(
                                        onTap: () {
                                          // setState(() {
                                          //   tab = true;
                                          // });
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 130,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                AppColors.primaryColor,
                                                AppColors.secondaryColor,
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Individual",
                                              style: TextStyle(
                                                fontFamily: "GothamRegular",
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.textColor24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            tab = true;
                                          });
                                        },
                                        child: Text(
                                          "Individual",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor27,
                                          ),
                                        ),
                                      ),
                                !tab
                                    ? Container(
                                        height: 40,
                                        width: 175,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.primaryColor,
                                              AppColors.secondaryColor,
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Company Admin",
                                            style: TextStyle(
                                              fontFamily: "GothamRegular",
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.textColor24,
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            tab = false;
                                          });
                                        },
                                        child: Text(
                                          "Company Admin",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor27,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await gro.SignInGoogle(
                                      context, tab ? "individual" : "company");
                                },
                                child: SocialMediaButtons(
                                  image: "assets/images/googleicon.png",
                                  text: tab
                                      ? "Register with Individual"
                                      : "Register with Company",
                                ),
                              ),
                              SizedBox(height: 16),
                              // GestureDetector(
                              //   onTap: () {
                              //     print("login with facebook");
                              //   },
                              //   child: SocialMediaButtons(
                              //     image: "assets/images/facebookicon.png",
                              //     text: "Login with Facebook",
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: 22),
                        Row(
                          children: [
                            Expanded(
                              child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 24.0, right: 12.0),
                                child: Divider(
                                  thickness: 1,
                                  color: AppColors.containerColor9,
                                ),
                              ),
                            ),
                            Text(
                              "or",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor10,
                              ),
                            ),
                            Expanded(
                              child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 12.0, right: 24.0),
                                child: Divider(
                                  thickness: 1,
                                  color: AppColors.containerColor9,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24.0),
                          child: Form(
                            key: form_key,
                            child: Column(
                              children: [
                                if (tab) ...[
                                  CustomTextField(
                                    keyboardType: TextInputType.name,
                                    controller: firstNamController,
                                    hintText: "First Name",
                                    prefixIcon: Icon(
                                      Icons.person_outlined,
                                      size: 24,
                                      color: AppColors.textColor10,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  CustomTextField(
                                    keyboardType: TextInputType.name,
                                    controller: lastNamController,
                                    hintText: "Last Name",
                                    prefixIcon: Icon(
                                      Icons.person_outlined,
                                      size: 24,
                                      color: AppColors.textColor10,
                                    ),
                                  ),
                                ] else ...[
                                  CustomTextField(
                                    keyboardType: TextInputType.name,
                                    controller: companyController,
                                    hintText: "Company Name",
                                    prefixIcon: Icon(
                                      Icons.groups,
                                      size: 24,
                                      color: AppColors.textColor10,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  CustomTextField(
                                    keyboardType: TextInputType.name,
                                    controller: adminController,
                                    hintText: "Admin Name",
                                    prefixIcon: Icon(
                                      Icons.supervisor_account,
                                      size: 24,
                                      color: AppColors.textColor10,
                                    ),
                                  ),
                                ],
                                SizedBox(height: 16),
                                CustomTextField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  hintText: "ex.email@domain.com",
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    size: 24,
                                    color: AppColors.textColor10,
                                  ),
                                ),
                                SizedBox(height: 16),
                                CustomTextField(
                                  keyboardType: TextInputType.text,
                                  controller: userNameController,
                                  hintText: "UserName",
                                  prefixIcon: Icon(
                                    Icons.account_circle_outlined,
                                    size: 24,
                                    color: AppColors.textColor10,
                                  ),
                                ),
                                SizedBox(height: 16),
                                CustomTextField(
                                  validator: (val) {
                                    // if (val!.isEmpty) {
                                    //   return "Field is Empty";
                                    // } else if (passwordController.text.length <
                                    //     8) {
                                    //   return 'Password Character length at least 8';
                                    // } else if (!passwordController.text
                                    //         .contains('!') &&
                                    //     !passwordController.text
                                    //         .contains('@') &&
                                    //     !passwordController.text
                                    //         .contains('#') &&
                                    //     !passwordController.text
                                    //         .contains('\$') &&
                                    //     !passwordController.text
                                    //         .contains('%') &&
                                    //     !passwordController.text
                                    //         .contains('^') &&
                                    //     !passwordController.text
                                    //         .contains('&') &&
                                    //     !passwordController.text
                                    //         .contains('*') &&
                                    //     !passwordController.text
                                    //         .contains(')') &&
                                    //     !passwordController.text
                                    //         .contains('(')) {
                                    //   return 'Passwrod contains must {!@#\$%^&*()}';
                                    // }
                                    return null;
                                  },
                                  obscureCharacter: "*",
                                  isObscureText: true,
                                  keyboardType: TextInputType.text,
                                  controller: passwordController,
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.lock_outlined,
                                      size: 24, color: AppColors.textColor10),
                                ),
                                SizedBox(height: 16),
                                CustomTextField(
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Field is Empty";
                                    } else if (passwordController.text !=
                                        confirmPasswordController.text) {
                                      return 'Password did not match';
                                    }
                                    return null;
                                  },
                                  obscureCharacter: "*",
                                  isObscureText: true,
                                  keyboardType: TextInputType.text,
                                  controller: confirmPasswordController,
                                  hintText: "Confirm Password",
                                  prefixIcon: Icon(
                                    Icons.lock_outlined,
                                    size: 24,
                                    color: AppColors.textColor10,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: AppColors.textColor10,
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        print("Checkbox value changed: $value");
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "I agree with ",
                                        style: TextStyle(
                                          fontFamily: "GothamRegular",
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textColor16,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                "Terms of \nService, Privacy Policy,",
                                            style: TextStyle(
                                              fontFamily: "GothamRegular",
                                              fontSize: 14.0,
                                              height: 1.5,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.textColor10,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " and \ndefault",
                                            style: TextStyle(
                                              fontFamily: "GothamRegular",
                                              fontSize: 14.0,
                                              height: 1.5,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.textColor16,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " Notification Settings",
                                            style: TextStyle(
                                              fontFamily: "GothamRegular",
                                              fontSize: 14.0,
                                              height: 1.5,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.textColor10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 50),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: tab
                                      ? GestureDetector(
                                          onTap: () async {
                                            print("signup to employee screen");
                                            if (form_key.currentState!
                                                .validate()) {
                                              if (!emailController.text
                                                      .contains('@') &&
                                                  !emailController.text
                                                      .contains('.com')) {
                                                MyToast("Email is not Correct",
                                                    Type: false);
                                              } else if (!isChecked) {
                                                print(
                                                    "Checkbox is not checked");
                                                MyToast(
                                                    "Please check the Privacy and Terms",
                                                    Type: false);
                                              } else {
                                                print(
                                                    "Checkbox is checked: $isChecked");

                                                print("Doing Process");
                                                // _startLoading();

                                                // Uncomment and modify this section as needed
                                                await pro.registerUsers(
                                                    context,
                                                    firstNamController.text
                                                        .trim(),
                                                    lastNamController.text
                                                        .trim(),
                                                    emailController.text.trim(),
                                                    userNameController.text
                                                        .trim(),
                                                    passwordController.text
                                                        .trim(),
                                                    ".",
                                                    ".",
                                                    "individual",
                                                    "manual");

                                                // Uncomment and modify this section as needed
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 42,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  AppColors.primaryColor,
                                                  AppColors.secondaryColor,
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Sign up",
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
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            // print("signup to employee screen");
                                            if (form_key.currentState!
                                                .validate()) {
                                              if (!emailController.text
                                                      .contains('@') &&
                                                  !emailController.text
                                                      .contains('.com')) {
                                                MyToast("Email is not Correct",
                                                    Type: false);
                                              } else if (!isChecked) {
                                                print(
                                                    "Checkbox is not checked");
                                                MyToast(
                                                    "Please check the Privacy and Terms",
                                                    Type: false);
                                              } else {
                                                print(
                                                    "Checkbox is checked: $isChecked");

                                                print("Doing Process");
                                                // _startLoading();

                                                // Uncomment and modify this section as needed
                                                await pro.registerUsers(
                                                    context,
                                                    "",
                                                    "",
                                                    emailController.text.trim(),
                                                    userNameController.text
                                                        .trim(),
                                                    passwordController.text
                                                        .trim(),
                                                    companyController.text
                                                        .trim(),
                                                    adminController.text.trim(),
                                                    "company",
                                                    "manual");
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 42,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  AppColors.primaryColor,
                                                  AppColors.secondaryColor,
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Sign up",
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
                          ),
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontFamily: "GothamRegular",
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor5,
                                ),
                              ),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  " Sign In",
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textColor6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Center(
                            child: Text(
                              "Data & Privacy Policy",
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor10,
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
          ),
        );
      }),
    );
  }
}
