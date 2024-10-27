import 'dart:developer';

import 'package:client_nfc_mobile_app/company_admin_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/controller/services/google_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/login_api.dart';
import 'package:client_nfc_mobile_app/controller/services/register_api.dart';
import 'package:client_nfc_mobile_app/individual_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/screens/forgot_password_screen.dart';
import 'package:client_nfc_mobile_app/utils/loading_circle.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/components/custom_text_field.dart';
import 'package:client_nfc_mobile_app/components/social_media_buttons.dart';
import 'package:client_nfc_mobile_app/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var newKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var log = context.read<LoginUserProvider>();
    context.read<GoogleProvider>();
    log.isLoading = false;
  }

  // void _showLoadingDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               CircularProgressIndicator(),
  //               SizedBox(width: 20),
  //               Text("Loading..."),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  bool tab = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(builder: (context) {
          var pro = context.watch<LoginUserProvider>();
          var gro = context.watch<GoogleProvider>();
          // if (pro.isLoading || gro.isLoading) {
          //   Future.microtask(() => _showLoadingDialog(context));
          // }

          return Stack(children: [
            SingleChildScrollView(
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
                            padding:
                                const EdgeInsets.only(left: 24, right: 13.0),
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
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: GradientText(
                              "Hi, Welcome Back!",
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
                              "Please enter your credentials to log in and access your account.",
                              style: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor8,
                              ),
                            ),
                          ),
                          SizedBox(height: 22),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await gro.SignInGoogle(context,
                                        tab ? "individual" : "company");
                                    print(
                                        'gro.isGoogleLogin:${gro.isGoogleLogin}');
                                    //  gro.isGoogleLogin=true;
                                  },
                                  child: SocialMediaButtons(
                                    image: "assets/images/googleicon.png",
                                    text: tab
                                        ? "Login with Individual"
                                        : "Login with Company",
                                  ),
                                ),
                                SizedBox(height: 16),
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
                            padding:
                                const EdgeInsets.only(left: 24, right: 24.0),
                            child: Form(
                              key: newKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    validator: (val) {
                                      if (!emailController.text.contains('@') &&
                                          !emailController.text
                                              .contains('.com')) {
                                        return "Email is not Correct";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    hintText: "ex.email@domain.com",
                                    prefixIcon: const Icon(
                                      Icons.email_outlined,
                                      size: 24,
                                      color: AppColors.textColor29,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  CustomTextField(
                                    validator: (val) {
                                      return null;
                                    },
                                    obscureCharacter: "*",
                                    isObscureText: true,
                                    keyboardType: TextInputType.text,
                                    controller: passwordController,
                                    hintText: "*********",
                                    prefixIcon: const Icon(
                                      Icons.lock_outlined,
                                      size: 24,
                                      color: AppColors.textColor29,
                                    ),
                                  ),
                                  const SizedBox(height: 08),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 24),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                CupertinoDialogRoute(
                                                    builder: (_) =>
                                                        ForgotPasswordScreen(),
                                                    context: context));
                                          },
                                          child: const Text(
                                            "Forgot password?",
                                            style: TextStyle(
                                              fontFamily: "GothamRegular",
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.textColor6,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (newKey.currentState!.validate()) {
                                          // debugger();
                                          print("login to employee screen");

                                          print("Doing Login Process");
                                          // debugger();
                                          await pro.LoginUsers(
                                              context,
                                              emailController.text.trim(),
                                              passwordController.text.trim(),
                                              tab ? 'individual' : 'company');
                                        }
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 42,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              AppColors.primaryColor,
                                              AppColors.secondaryColor,
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don’t have an account?",
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
                                        builder: (context) => SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Register here",
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
                          const SizedBox(height: 50),
                          const Padding(
                            padding: EdgeInsets.only(left: 24, right: 24),
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
            if (pro.isLoading || gro.isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: LoadingCircle(), // Your custom loader
                ),
              ),
          ]);
        }),
      ),
    );
  }
}
