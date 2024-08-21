import 'package:client_nfc_mobile_app/components/custom_text_field.dart';
import 'package:client_nfc_mobile_app/components/social_media_buttons.dart';
import 'package:client_nfc_mobile_app/controller/services/login_api.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  Future<void> _openGmail() async {
    const gmailUrl = 'mailto:';
    if (await canLaunch(gmailUrl)) {
      await launch(gmailUrl);
    } else {
      throw 'Could not launch $gmailUrl';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LoginUserProvider>();
  }

  void showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text(
            'Forgot Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Please check your email for password reset instructions.'),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () async {
                  await _openGmail();
                },
                child: SocialMediaButtons(
                  image: "assets/images/googleicon.png",
                  text: "Go to Gmail",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(
                'Close',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final emailController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        var pro = context.watch<LoginUserProvider>();
        if (pro.isLoading) {
          Future.microtask(() => _showLoadingDialog(context));
        }
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
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
                            "Forgot Password",
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
                            "Please Forgot Your Password through Gmail where OneSec sent you a mail for Forgot your Password",
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
                              SizedBox(height: 16),
                              CustomTextField(
                                validator: (val) {
                                  if (!emailController.text.contains('@') ||
                                      !emailController.text.contains('.com')) {
                                    return "Email is not Correct";
                                  }
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
                              GestureDetector(
                                onTap: () async {
                                  if (emailController.text.isEmpty) {
                                    MyToast("Please Enter the Email",
                                        Type: false);
                                  } else {
                                    final response = await pro.ResetPassword(
                                        context, emailController.text.trim());
                                    if (response != null) {
                                      showForgotPasswordDialog(context);
                                    } else {
                                      Navigator.pop(context);
                                      MyToast("Something Went Wrong",
                                          Type: false);
                                    }
                                  }
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
                                      "Forgot Password",
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
        );
      }),
    );
    ;
  }
}
