import 'package:client_nfc_mobile_app/company_admin_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/components/custom_text_field.dart';
import 'package:client_nfc_mobile_app/controller/services/company_provider.dart';
import 'package:client_nfc_mobile_app/models/company/get_company_profile.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:client_nfc_mobile_app/utils/loading_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEmployeeScreen extends StatefulWidget {
  bool create;
  final authToken;
  final CompanyProfile? companyDetails;
  final User? userDetails;
  final employeeDetail;
  AddEmployeeScreen(
      {super.key,
      required this.create,
      required this.authToken,
      required this.userDetails,
      required this.companyDetails,
      this.employeeDetail});
  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _postionController = TextEditingController();
  final TextEditingController displayEmailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CompanyProvider>().isLoading = false;
    updateEmployee(widget.employeeDetail);
  }

  var previousEmail;
  updateEmployee(employees) {
    if (employees != null) {
      setState(() {
        _firstNameController.text = employees['first_name'];
        _lastNameController.text = employees['last_name'];
        _emailController.text = employees['email'];
        previousEmail = employees['email'];
        _phoneController.text = employees['phone'];
        _postionController.text = employees['position'];
        displayEmailController.text = employees['display_email'];
        usernameController.text = employees['username'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        var pro = context.watch<CompanyProvider>();
        return
            // pro.isLoading
            //     ? Center(
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             LoadingCircle(),
            //             SizedBox(height: 20),
            //             // Add space between the spinner and text
            //             Text(
            //               widget.create
            //                   ? 'Waiting Create Employee Profile...'
            //                   : 'Waiting Update Employee Profile...',
            //               style: TextStyle(
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.w500,
            //                 color: Colors.black, // Set text color
            //               ),
            //             ),
            //           ],
            //         ),
            //       )
            //     :
            SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.create ? "Add Employee" : "Update Employee",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "GothamBold",
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor14,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the first name';
                              }
                              return null;
                            },
                            controller: _firstNameController,
                            hintText: 'First Name',
                          ),
                          SizedBox(height: 16.0),
                          CustomTextField(
                            controller: _lastNameController,
                            hintText: 'Last Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the last name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          CustomTextField(
                            controller: _postionController,
                            hintText: 'Position',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the position';
                              }
                              return null;
                            },
                          ),
                          // SizedBox(height: 16.0),
                          // CustomTextField(
                          //     controller: displayEmailController,
                          //     hintText: 'Display Email',
                          //     validator: (val) {
                          //       if (val!.isEmpty) {
                          //         return 'The email you want to show in your digital profile';
                          //       } else if (!displayEmailController.text
                          //               .contains('@') &&
                          //           !displayEmailController.text
                          //               .contains('.com')) {
                          //         return "Email is not Correct";
                          //       }
                          //       return null;
                          //     },
                          //     keyboardType: TextInputType.emailAddress),
                          // SizedBox(height: 16.0),
                          // CustomTextField(
                          //     controller: usernameController,
                          //     hintText: 'Employee Username (Optional)',
                          //     validator: (val) {
                          //       if (val!.isEmpty) {
                          //         return null;
                          //       }
                          //       return null;
                          //     },
                          //     keyboardType: TextInputType.text),

                          SizedBox(height: 16.0),
                          CustomTextField(
                            controller: _phoneController,
                            hintText: 'Phone',
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 32.0),
                          SizedBox(height: 20),
                          pro.isLoading
                              ? Center(
                                  child: LoadingCircle(),
                                )
                              : GestureDetector(
                                  onTap: widget.create
                                      ? () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final response = await pro.addEmployee(
                                                widget.authToken,
                                                display_email:
                                                    displayEmailController.text
                                                        .trim(),
                                                username: usernameController
                                                    .text
                                                    .trim(),
                                                companyID:
                                                    widget.companyDetails?.id,
                                                firstName: _firstNameController
                                                    .text
                                                    .trim(),
                                                lastName: _lastNameController
                                                    .text
                                                    .trim(),
                                                email: _emailController.text
                                                    .trim(),
                                                position: _postionController
                                                    .text
                                                    .trim(),
                                                phone: _phoneController.text
                                                    .trim());

                                            if (response != null) {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  CupertinoDialogRoute(
                                                      builder: (_) =>
                                                          CompanyAdminBottomNavigationBar(
                                                              profileData: widget
                                                                  .companyDetails,
                                                              authToken: widget
                                                                  .authToken,
                                                              userDetails: widget
                                                                  .userDetails),
                                                      context: context),
                                                  (route) => false);
                                            }
                                          }
                                        }
                                      : () async {
                                          //Update Profile
                                          if (_formKey.currentState!
                                              .validate()) {
                                            print(widget.companyDetails?.id);
                                            final response =
                                                await pro.UpdateEmployee(
                                                    token: widget.authToken,
                                                    email: previousEmail,
                                                    company: widget
                                                        .companyDetails?.id,
                                                    firstName:
                                                        _firstNameController
                                                            .text
                                                            .trim(),
                                                    lastName:
                                                        _lastNameController.text
                                                            .trim(),
                                                    newEmail: _emailController
                                                        .text
                                                        .trim(),
                                                    position: _postionController
                                                        .text
                                                        .trim(),
                                                    phone: _phoneController.text
                                                        .trim());

                                            if (response != null) {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  CupertinoDialogRoute(
                                                      builder: (_) =>
                                                          CompanyAdminBottomNavigationBar(
                                                              profileData: widget
                                                                  .companyDetails,
                                                              authToken: widget
                                                                  .authToken,
                                                              userDetails: widget
                                                                  .userDetails),
                                                      context: context),
                                                  (route) => false);
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
                                    child: Center(
                                      child: Text(
                                        widget.create
                                            ? "Add Employee"
                                            : "Update Employee",
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
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
