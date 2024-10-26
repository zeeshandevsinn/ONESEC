import 'package:client_nfc_mobile_app/controller/services/company_provider.dart';
import 'package:client_nfc_mobile_app/models/company/get_company_profile.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/screens/employee/add_employee_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/data/employees_items.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CompanyEmployeesPage extends StatefulWidget {
  final authToken;
  final CompanyProfile? companyDetails;
  final User? userDetails;
  const CompanyEmployeesPage(
      {super.key, this.authToken, this.userDetails, this.companyDetails});

  @override
  State<CompanyEmployeesPage> createState() => _CompanyEmployeesPageState();
}

class _CompanyEmployeesPageState extends State<CompanyEmployeesPage> {
  var employees = EmployeesItems();

  _showDeleteEmployee(BuildContext context, tokenId, email) {
    showDialog(
        context: context,
        builder: (context) {
          var pro = context.watch<CompanyProvider>();
          return Dialog(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.containerColor8,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: AppColors.textColor15,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.containerColor5,
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/images/icon1.png",
                        width: 47,
                        height: 63,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Text(
                    "Are You Sure?",
                    style: TextStyle(
                      fontFamily: "GothamBold",
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor14,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * .70,
                    child: Text(
                      'Are you sure you want to delete your Employee $email?',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "GothamRegular",
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor18,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  pro.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  print(tokenId);

                                  final response = await pro.DeleteEmployee(
                                    tokenId,
                                    email,
                                  );
                                  if (response != null) {
                                    widget.companyDetails!.employees
                                        .removeWhere((employee) =>
                                            employee['email'] == email);
                                    setState(() {
                                      widget.companyDetails!.employees;
                                    });
                                  }
                                  Navigator.of(context)
                                      .pop(); // Navigate to delete screen
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
                                      "Yes, Sure",
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
                              SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
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
                                        "No",
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
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          );
        });
  }

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
                  "Company Employees",
                  style: TextStyle(
                    fontFamily: "GothamBold",
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor14,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  height: MediaQuery.of(context).size.height * .85,
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.companyDetails!.employees.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                    itemCount:
                                        widget.companyDetails!.employees.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      final employee = widget
                                          .companyDetails!.employees[index];
                                      final fullName =
                                          '${employee['first_name']} ${employee['last_name']}';
                                      final position = employee['position'];
                                      final profilePic =
                                          employee['profile_pic'];
                                      final email = employee['email'];

                                      return Container(
                                        height: 80,
                                        padding: EdgeInsets.only(
                                            left: 16, right: 10),
                                        margin: EdgeInsets.only(
                                          bottom: 20,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: AppColors.containerColor3,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              child: profilePic != null
                                                  ? FadeInImage.assetNetwork(
                                                      placeholder:
                                                          'assets/images/logo.png',
                                                      image: profilePic,
                                                      imageErrorBuilder:
                                                          (context, error,
                                                              stackTrace) {
                                                        return Icon(
                                                          Icons
                                                              .error, // Show an error icon if the image fails to load
                                                          color: Colors.red,
                                                        );
                                                      },
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : CircleAvatar(
                                                      child: Icon(Icons
                                                          .person), // Default icon when profile_pic is null
                                                    ),
                                            ),
                                            SizedBox(width: 6),
                                            Flexible(
                                              child: Container(
                                                child: Text(
                                                  fullName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily: "GothamRegular",
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        CupertinoDialogRoute(
                                                            builder: (_) => AddEmployeeScreen(
                                                                employeeDetail:
                                                                    employee,
                                                                create: false,
                                                                authToken: widget
                                                                    .authToken,
                                                                userDetails: widget
                                                                    .userDetails,
                                                                companyDetails:
                                                                    widget
                                                                        .companyDetails),
                                                            context: context));
                                                  },
                                                  child: Container(
                                                    height: 34,
                                                    width: 34,
                                                    padding: EdgeInsets.all(6),
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .containerColor6,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.edit,
                                                        color: AppColors
                                                            .containerColor8,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: () {
                                                    _showDeleteEmployee(
                                                        context,
                                                        widget.authToken,
                                                        email);
                                                  },
                                                  child: Container(
                                                    height: 34,
                                                    width: 34,
                                                    padding: EdgeInsets.all(6),
                                                    decoration: BoxDecoration(
                                                      color: AppColors
                                                          .containerColor7,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.delete_outline,
                                                        color: AppColors
                                                            .containerColor8,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }))
                            : Expanded(
                                child: Column(
                                children: [
                                  GradientText(
                                    "ADD EMPLOYEES",
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
                                  SizedBox(height: 17),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 24, right: 24),
                                    child: Text(
                                      "Please Add Employees in your Company Tab on the Add  Button",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "GothamRegular",
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor8,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
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
