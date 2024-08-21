import 'package:client_nfc_mobile_app/components/custom_text_field.dart';
import 'package:client_nfc_mobile_app/controller/services/google_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/login_api.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DeleteAccountScreen extends StatefulWidget {
  final String? auth_token;
  final authType;
  final userID;
  const DeleteAccountScreen(
      {super.key,
      required this.auth_token,
      required this.authType,
      required this.userID});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final passwordController = TextEditingController();
  var newKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<LoginUserProvider>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        var pro = context.watch<LoginUserProvider>();
        var gro = context.watch<GoogleProvider>();
        if (pro.isLoading || gro.isLoading) {
          Future.microtask(() => _showLoadingDialog(context));
        }
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: newKey,
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
                              "DELETE ACCOUNT!",
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
                              "ARE YOU SURE YOU WANT TO DELETE YOUR ACCOUNT!",
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: widget.authType == 'google'
                                ? Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 24.0),
                                        child: GradientText(
                                          "Type DELETE",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: "GothamBold",
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          colors: [
                                            AppColors.textColor1,
                                            AppColors.textColor2,
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 22),
                                      CustomTextField(
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Field is Empty";
                                          } else if (passwordController.text ==
                                              'DELETE') {
                                            return null;
                                          }

                                          return 'Did not match DELETE';
                                        },
                                        obscureCharacter: "*",
                                        isObscureText: true,
                                        keyboardType: TextInputType.text,
                                        controller: passwordController,
                                        hintText: "Please Confirm",
                                        prefixIcon: Icon(Icons.delete,
                                            size: 24,
                                            color: AppColors.textColor10),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (newKey.currentState!.validate()) {
                                            await gro.DeleteGoogleAccount(
                                                context,
                                                widget.auth_token,
                                                widget.userID);
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
                                              "Delete Account",
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
                                  )
                                : Column(
                                    children: [
                                      CustomTextField(
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Field is Empty";
                                          } else if (passwordController
                                                  .text.length <
                                              8) {
                                            return 'Password Character length at least 8';
                                          } else if (!passwordController.text
                                                  .contains('!') &&
                                              !passwordController.text
                                                  .contains(';') &&
                                              !passwordController.text
                                                  .contains('.') &&
                                              !passwordController.text
                                                  .contains(',') &&
                                              !passwordController.text
                                                  .contains('@') &&
                                              !passwordController.text
                                                  .contains('#') &&
                                              !passwordController.text
                                                  .contains('\$') &&
                                              !passwordController.text
                                                  .contains('%') &&
                                              !passwordController.text
                                                  .contains('^') &&
                                              !passwordController.text
                                                  .contains('&') &&
                                              !passwordController.text
                                                  .contains('*') &&
                                              !passwordController.text
                                                  .contains(')') &&
                                              !passwordController.text
                                                  .contains('(')) {
                                            return 'Password must contain {!@#\$%^&*()}';
                                          }
                                          return null;
                                        },
                                        obscureCharacter: "*",
                                        isObscureText: true,
                                        keyboardType: TextInputType.text,
                                        controller: passwordController,
                                        hintText: "Current Password",
                                        prefixIcon: Icon(Icons.lock_outlined,
                                            size: 24,
                                            color: AppColors.textColor10),
                                      ),
                                      SizedBox(height: 16),
                                      GestureDetector(
                                        onTap: () async {
                                          if (newKey.currentState!.validate()) {
                                            if (widget.auth_token != null) {
                                              print(
                                                  "Auth Token: ${widget.auth_token}");
                                              await pro.DeleteAccount(
                                                  context,
                                                  widget.auth_token,
                                                  passwordController.text
                                                      .trim());
                                            } else {
                                              print("Auth token is null");
                                            }
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
                                              "Delete Account",
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
      }),
    );
  }
}
