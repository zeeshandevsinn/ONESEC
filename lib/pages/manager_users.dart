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

class ManageUsers extends StatefulWidget {
  final List<dynamic> employees;
  final User? userDetails;
  final CompanyProfile? companyDetails;
  final token;
  const ManageUsers(
      {super.key,
      required this.employees,
      this.userDetails,
      this.companyDetails,
      this.token});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
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
                                    widget.employees.removeWhere((employee) =>
                                        employee['email'] == email);
                                    setState(() {
                                      widget.employees;
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
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CompanyProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        var pro = context.watch<CompanyProvider>();
        return pro.isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(),
                    SizedBox(height: 20),
                    // Add space between the spinner and text
                    Text(
                      'Waiting for Delete Employee...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black, // Set text color
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Manage Employees",
                              style: TextStyle(
                                fontFamily: "GothamBold",
                                fontSize: 28.0,
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
                                            create: true,
                                            authToken: widget.token,
                                            userDetails: widget.userDetails,
                                            companyDetails:
                                                widget.companyDetails),
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
                        // SizedBox(height: 24),
                        // TextField(
                        //   style: TextStyle(
                        //     fontFamily: "GothamRegular",
                        //     fontSize: 15.0,
                        //     fontWeight: FontWeight.w400,
                        //     color: AppColors.textColor18,
                        //   ),
                        //   keyboardType: TextInputType.name,
                        //   cursorColor: AppColors.textColor18,
                        //   decoration: InputDecoration(
                        //     hintText: "Search User",
                        //     hintStyle: TextStyle(
                        //       fontFamily: "GothamRegular",
                        //       fontSize: 14.0,
                        //       fontWeight: FontWeight.w400,
                        //       color: AppColors.textColor12,
                        //     ),
                        //     suffixIcon: Icon(
                        //       Icons.search,
                        //       size: 24,
                        //       color: Color(0XFF667085),
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(9),
                        //       borderSide: BorderSide(
                        //           width: 1, color: AppColors.textColor16),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(9),
                        //       borderSide: BorderSide(
                        //           width: 1, color: AppColors.textColor16),
                        //     ),
                        //     fillColor: AppColors.containerColor8,
                        //     filled: true,
                        //   ),
                        // ),

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
                                widget.employees.isNotEmpty
                                    ? Expanded(
                                        child: ListView.builder(
                                            itemCount: widget.employees.length,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              final employee =
                                                  widget.employees[index];
                                              final fullName =
                                                  '${employee['first_name']} ${employee['last_name']}';
                                              final position =
                                                  employee['position'];
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
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.containerColor3,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60),
                                                      child: profilePic != null
                                                          ? FadeInImage
                                                              .assetNetwork(
                                                              placeholder:
                                                                  'assets/images/logo.png',
                                                              image: profilePic,
                                                              imageErrorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Icon(
                                                                  Icons
                                                                      .error, // Show an error icon if the image fails to load
                                                                  color: Colors
                                                                      .red,
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "GothamRegular",
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                                        create:
                                                                            false,
                                                                        authToken:
                                                                            widget
                                                                                .token,
                                                                        userDetails:
                                                                            widget
                                                                                .userDetails,
                                                                        companyDetails:
                                                                            widget
                                                                                .companyDetails),
                                                                    context:
                                                                        context));
                                                          },
                                                          child: Container(
                                                            height: 34,
                                                            width: 34,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    6),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .containerColor6,
                                                              shape: BoxShape
                                                                  .circle,
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
                                                                widget.token,
                                                                email);
                                                          },
                                                          child: Container(
                                                            height: 34,
                                                            width: 34,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    6),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .containerColor7,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons
                                                                    .delete_outline,
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
              );
      }),
    );
  }
}
