import 'package:client_nfc_mobile_app/models/company/get_company_profile.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/screens/employee/add_employee_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/data/employees_items.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
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
                  height: 1150,
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14.0, right: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Our Employees",
                              style: TextStyle(
                                fontFamily: "GothamBold",
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor14,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    CupertinoDialogRoute(
                                        builder: (_) => AddEmployeeScreen(
                                            companyDetails:
                                                widget.companyDetails,
                                            create: true,
                                            authToken: widget.authToken,
                                            userDetails: widget.userDetails),
                                        context: context));
                              },
                              icon: Icon(
                                Icons.add_circle_outline_outlined,
                                size: 30,
                                color: Color(0xFF3C4B4B),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
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
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Container(
                                          height: 80,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: AppColors.containerColor3,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 12.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  child: profilePic != null
                                                      ? FadeInImage
                                                          .assetNetwork(
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
                                              ),
                                              SizedBox(width: 12),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      fullName,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "GothamBold",
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .textColor14,
                                                      ),
                                                    ),
                                                    Text(
                                                      position,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "GothamRegular",
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color(0xFF111111)
                                                            .withOpacity(.6),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
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

                        // Expanded(
                        //     child: ListView.builder(
                        //       itemCount: 12,
                        //       scrollDirection: Axis.vertical,
                        //       physics: NeverScrollableScrollPhysics(),
                        //       shrinkWrap: true,
                        //       itemBuilder:
                        //           (BuildContext context, int index) {
                        //         return Padding(
                        //           padding:
                        //               const EdgeInsets.only(bottom: 8.0),
                        //           child: Container(
                        //             height: 80,
                        //             padding: EdgeInsets.symmetric(
                        //               vertical: 10,
                        //             ),
                        //             width:
                        //                 MediaQuery.of(context).size.width,
                        //             decoration: BoxDecoration(
                        //               color: AppColors.containerColor3,
                        //               borderRadius:
                        //                   BorderRadius.circular(16),
                        //             ),
                        //             child: Row(
                        //               children: [
                        //                 Padding(
                        //                   padding:
                        //                       EdgeInsets.only(left: 12.0),
                        //                   child: ClipRRect(
                        //                     borderRadius:
                        //                         BorderRadius.circular(60),
                        //                     child: Image.asset(
                        //                       employees
                        //                           .myEmployees[index].image,
                        //                       width: 60,
                        //                       height: 60,
                        //                       fit: BoxFit.cover,
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 SizedBox(width: 12),
                        //                 Padding(
                        //                   padding: const EdgeInsets.only(
                        //                       top: 10),
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: [
                        //                       Text(
                        //                         employees.myEmployees[index]
                        //                             .title,
                        //                         style: TextStyle(
                        //                           fontFamily: "GothamBold",
                        //                           fontSize: 18.0,
                        //                           fontWeight:
                        //                               FontWeight.w700,
                        //                           color:
                        //                               AppColors.textColor14,
                        //                         ),
                        //                       ),
                        //                       Text(
                        //                         employees.myEmployees[index]
                        //                             .subtitle,
                        //                         style: TextStyle(
                        //                           fontFamily:
                        //                               "GothamRegular",
                        //                           fontSize: 13.0,
                        //                           fontWeight:
                        //                               FontWeight.w400,
                        //                           color: Color(0xFF111111)
                        //                               .withOpacity(.6),
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
