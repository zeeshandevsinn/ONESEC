import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/components/custom_employee_dialog_box.dart';
import 'package:client_nfc_mobile_app/data/employees_items.dart';

import '../utils/colors.dart';

class CompanyEmployees extends StatefulWidget {
  final List<dynamic> employees;
  const CompanyEmployees({super.key, required this.employees});

  @override
  State<CompanyEmployees> createState() => _CompanyEmployeesState();
}

class _CompanyEmployeesState extends State<CompanyEmployees> {
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
                //       borderSide:
                //           BorderSide(width: 1, color: AppColors.textColor16),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(9),
                //       borderSide:
                //           BorderSide(width: 1, color: AppColors.textColor16),
                //     ),
                //     fillColor: AppColors.containerColor8,
                //     filled: true,
                //   ),
                // ),

                SizedBox(height: 24),
                Container(
                  height: MediaQuery.of(context).size.height,
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
                        Text(
                          "Our Employees",
                          style: TextStyle(
                            fontFamily: "GothamBold",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor14,
                          ),
                        ),
                        SizedBox(height: 24),
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.employees.length,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              final employee = widget.employees[index];
                              final fullName =
                                  '${employee['first_name']} ${employee['last_name']}';
                              final position = employee['position'];
                              final profilePic = employee['profile_pic'];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  height: 80,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: AppColors.containerColor3,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 12.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child: profilePic != null
                                              ? FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'assets/images/logo.png',
                                                  image: profilePic,
                                                  imageErrorBuilder: (context,
                                                      error, stackTrace) {
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
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              fullName,
                                              style: TextStyle(
                                                fontFamily: "GothamBold",
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textColor14,
                                              ),
                                            ),
                                            Text(
                                              position,
                                              style: TextStyle(
                                                fontFamily: "GothamRegular",
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF111111)
                                                    .withOpacity(.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                EmployeeDialogBox(
                                              employee: employee,
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.more_horiz,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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
