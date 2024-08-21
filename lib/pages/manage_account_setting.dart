import 'package:client_nfc_mobile_app/controller/services/account%20update/account_update_provider.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/components/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';

class ManageAccountSetting extends StatefulWidget {
  final auth_token;
  const ManageAccountSetting({super.key, required this.auth_token});

  @override
  State<ManageAccountSetting> createState() => _ManageAccountSettingState();
}

class _ManageAccountSettingState extends State<ManageAccountSetting> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final updateConfirmPasswordCOntroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AccountUpdateProvider>();
  }

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
                  "Account Setting",
                  style: TextStyle(
                    fontFamily: "GothamBold",
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor14,
                  ),
                ),
                SizedBox(height: 24),
                Builder(builder: (context) {
                  var pro = context.watch<AccountUpdateProvider>();
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.containerColor8,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Change Password",
                              style: TextStyle(
                                fontFamily: "GothamBold",
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor14,
                              ),
                            ),
                            SizedBox(height: 24),
                            CustomTextField(
                              obscureCharacter: "*",
                              isObscureText: true,
                              keyboardType: TextInputType.text,
                              controller: confirmPasswordController,
                              hintText: "Current Password",
                              prefixIcon: Icon(
                                Icons.lock_outlined,
                                size: 24,
                                color: AppColors.textColor29,
                              ),
                            ),
                            SizedBox(height: 16),
                            CustomTextField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Field is Empty";
                                } else if (newPasswordController.text.length <
                                    8) {
                                  return 'Password Character length at least 8';
                                } else if (!newPasswordController.text
                                        .contains('!') &&
                                    !newPasswordController.text.contains('@') &&
                                    !newPasswordController.text.contains('#') &&
                                    !newPasswordController.text
                                        .contains('\$') &&
                                    !newPasswordController.text.contains('%') &&
                                    !newPasswordController.text.contains('^') &&
                                    !newPasswordController.text.contains('&') &&
                                    !newPasswordController.text.contains('*') &&
                                    !newPasswordController.text.contains(')') &&
                                    !newPasswordController.text.contains('(')) {
                                  return 'Passwrod contains must {!@#\$%^&*()}';
                                }
                                return null;
                              },
                              obscureCharacter: "*",
                              isObscureText: true,
                              keyboardType: TextInputType.text,
                              controller: newPasswordController,
                              hintText: "New Password",
                              prefixIcon: Icon(
                                Icons.lock_outlined,
                                size: 24,
                                color: AppColors.textColor29,
                              ),
                            ),
                            SizedBox(height: 16),
                            CustomTextField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Field is Empty";
                                } else if (newPasswordController.text.trim() !=
                                    updateConfirmPasswordCOntroller.text
                                        .trim()) {
                                  return 'Password did not match';
                                }
                                return null;
                              },
                              obscureCharacter: "*",
                              isObscureText: true,
                              keyboardType: TextInputType.text,
                              controller: updateConfirmPasswordCOntroller,
                              hintText: "Confirm new Password",
                              prefixIcon: Icon(
                                Icons.lock_outlined,
                                size: 24,
                                color: AppColors.textColor29,
                              ),
                            ),
                            SizedBox(height: 40),
                            pro.isLoading
                                ? Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      if (formkey.currentState!.validate()) {
                                        await pro.SetPassword(
                                            widget.auth_token,
                                            confirmPasswordController.text
                                                .trim(),
                                            newPasswordController.text.trim());
                                      }
                                    },
                                    child: Container(
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
                                          "Change Password",
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
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 24),
                // Container(
                //   height: 140,
                //   width: MediaQuery.of(context).size.width,
                //   decoration: BoxDecoration(
                //     color: AppColors.containerColor8,
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: Padding(
                //     padding: EdgeInsets.all(12.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           "Update Username",
                //           style: TextStyle(
                //             fontFamily: "GothamBold",
                //             fontSize: 18.0,
                //             fontWeight: FontWeight.w700,
                //             color: AppColors.textColor14,
                //           ),
                //         ),
                //         SizedBox(height: 24),
                //         CustomTextField(
                //           keyboardType: TextInputType.text,
                //           controller: updateUserNameController,
                //           hintText: "jdoe@official",
                //           prefixIcon: Icon(
                //             Icons.email_outlined,
                //             size: 24,
                //             color: AppColors.textColor29,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(height: 40),
                // GestureDetector(
                //   onTap: () {
                //     print("save password and update email");
                //   },
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: 42,
                //     decoration: BoxDecoration(
                //       gradient: LinearGradient(
                //         colors: [
                //           AppColors.primaryColor,
                //           AppColors.secondaryColor,
                //         ],
                //       ),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: Center(
                //       child: Text(
                //         "Update Username",
                //         textAlign: TextAlign.center,
                //         style: TextStyle(
                //           fontFamily: "GothamRegular",
                //           fontSize: 16.0,
                //           fontWeight: FontWeight.w400,
                //           color: AppColors.textColor24,
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
