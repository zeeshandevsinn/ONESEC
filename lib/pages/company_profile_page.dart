import 'dart:developer';

import 'package:client_nfc_mobile_app/controller/services/google_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/login_api.dart';
import 'package:client_nfc_mobile_app/data/popup_menu_items.dart';
import 'package:client_nfc_mobile_app/models/company/get_company_profile.dart';
import 'package:client_nfc_mobile_app/models/employees_info.dart';
import 'package:client_nfc_mobile_app/pages/manage_account_setting.dart';
import 'package:client_nfc_mobile_app/pages/notification_setting.dart';
import 'package:client_nfc_mobile_app/screens/charts/bar_chart.dart';
import 'package:client_nfc_mobile_app/screens/company/company_user_create_profile.dart';
import 'package:client_nfc_mobile_app/screens/delete_account_screen.dart';
import 'package:client_nfc_mobile_app/screens/employee/add_employee_screen.dart';
import 'package:client_nfc_mobile_app/screens/share_profile_screen/received_profile_screen.dart';
import 'package:client_nfc_mobile_app/screens/share_profile_screen/share_profile_screen.dart';
import 'package:client_nfc_mobile_app/utils/loading_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/data/employees_items.dart';
import 'package:client_nfc_mobile_app/pages/company_employees.dart';
import 'package:client_nfc_mobile_app/pages/manager_users.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../utils/colors.dart';

class CompanyProfilePage extends StatefulWidget {
  final companylogo;
  final companyName;
  final bio;
  final List<dynamic> employes;
  final token;
  final userDetails;
  final CompanyProfile? profileDetails;
  final auth_type;
  const CompanyProfilePage(
      {super.key,
      this.companylogo,
      this.companyName,
      this.bio,
      required this.employes,
      this.token,
      this.userDetails,
      this.profileDetails,
      this.auth_type});

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  void showMenuCard(BuildContext context, String token, bool isGoogle) {
    List<String> filteredChoices = CompanyPopUpMenuItems.choices
        .where((choice) =>
            !(isGoogle && choice == CompanyPopUpMenuItems.accountSetting))
        .toList();

    showMenu(
      color: Colors.black,
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
      items: filteredChoices.map((String choice) {
        return PopupMenuItem<String>(
          value: choice,
          child: ListTile(
            title: Text(
              choice,
              style: TextStyle(
                fontFamily: "GothamRegular",
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            leading: Icon(
              CompanyPopUpMenuItems.choiceIcons[choice],
              size: 24,
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
    ).then((value) {
      if (value != null) choiceAction(value, token);
    });
  }

  void _showDeleteDialog(BuildContext context, tokenId, auth_type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text('Are you sure you want to delete your account?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                print(tokenId);
                Navigator.of(context).pop();
                // Close the dialog

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DeleteAccountScreen(
                            userID: widget.userDetails.id,
                            auth_token: tokenId,
                            authType: widget.auth_type,
                          )),
                ); // Navigate to delete screen
              },
            ),
          ],
        );
      },
    );
  }

  void choiceAction(String choices, auth_token) {
    var gro = Provider.of<GoogleProvider>(context, listen: false);
    if (choices == CompanyPopUpMenuItems.receivedProfiles) {
      Navigator.push(
        context,
        CupertinoDialogRoute(
          builder: (context) => ReceivedProfileScreen(
            userDetails: widget.userDetails,
            auth_token: widget.token,
          ),
          context: context,
        ),
      );
    } else if (choices == CompanyPopUpMenuItems.accountSetting) {
      Navigator.push(
        context,
        CupertinoDialogRoute(
          builder: (context) => ManageAccountSetting(
            auth_token: widget.token,
          ),
          context: context,
        ),
      );
    } else if (choices == CompanyPopUpMenuItems.manageUser) {
      Navigator.push(
        context,
        CupertinoDialogRoute(
          builder: (context) => ManageUsers(
              employees: widget.employes,
              userDetails: widget.userDetails,
              companyDetails: widget.profileDetails,
              token: widget.token),
          context: context,
        ),
      );
    }
    // else if (choices == CompanyPopUpMenuItems.notification) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => NotificationSetting(),
    //     ),
    //   );
    // }
    else if (choices == CompanyPopUpMenuItems.deleteAccount) {
      showDialog(
          context: context,
          builder: (context) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You want to delete your account.",
                          style: TextStyle(
                            fontFamily: "GothamRegular",
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("Delete");
                              print(auth_token);
                              Navigator.of(context).pop(); // Close the dialog
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DeleteAccountScreen(
                                        userID: widget.userDetails.id,
                                        authType: widget.auth_type,
                                        auth_token: auth_token)),
                              ); // Navigate to delete screen
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
    } else if (choices == CompanyPopUpMenuItems.updateProfile) {
      Navigator.push(
          context,
          CupertinoDialogRoute(
              builder: (_) => CompanyUserCreateDetails(
                    userDetails: widget.userDetails,
                    create: false,
                    token: widget.token,
                    profileDetails: widget.profileDetails,
                  ),
              context: context));

      // profileUrl = URlProfile(widget.auth_token);
    } else if (choices == PopUpMenuItems.shareprofile) {
      Navigator.push(
          context,
          CupertinoDialogRoute(
              builder: (_) => ShareProfileScreen(auth_token: widget.token),
              context: context));
    } else if (choices == CompanyPopUpMenuItems.logout) {
      showDialog(
          context: context,
          builder: (context) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "You want to Logout your account.",
                          style: TextStyle(
                            fontFamily: "GothamRegular",
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Builder(builder: (context) {
                      var pro = context.watch<LoginUserProvider>();
                      return pro.logoutLoading
                          ? Center(child: LoadingCircle())
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await pro.logoutAccount(context,
                                          auth_token, widget.auth_type);
                                      gro.isGoogleLogin = false;
                                      print(
                                          "CompanyLogout:${gro.isGoogleLogin}");
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
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                            );
                    }),
                  ],
                ),
              ),
            );
          });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LoginUserProvider>().isLoading = false;
    context.read<LoginUserProvider>().logoutLoading = false;
  }

  var employees = EmployeesItems();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var gro = context.watch<GoogleProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: 100,
                            width: 100,
                          )
                          // Icon(
                          //   Icons.remove_red_eye_outlined,
                          //   size: 30,
                          //   color: AppColors.textColor10,
                          // ),
                          // SizedBox(width: 8.5),
                          // Text(
                          //   "Preview",
                          //   style: TextStyle(
                          //     fontFamily: "GothamRegular",
                          //     fontSize: 14.0,
                          //     fontWeight: FontWeight.w400,
                          //     color: AppColors.textColor8,
                          //   ),
                          // ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showMenuCard(
                              context, widget.token, gro.isGoogleLogin);
                        },
                        child: Icon(
                          Icons.more_horiz,
                          size: 30,
                          color: AppColors.textColor10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.containerColor8,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: widget.companylogo != null &&
                                    widget.companylogo.isNotEmpty
                                ? FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/logo.png',
                                    image: widget.companylogo!,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Icon(
                                        Icons
                                            .error, // Show an error icon if the image fails to load
                                        color: Colors.red,
                                      );
                                    },
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                : CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                        'assets/images/logo.png'), // Default icon when profile_pic is null
                                  ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width * .60,
                                child: Text(
                                  widget.companyName.isNotEmpty
                                      ? "${widget.companyName}"
                                      : "Update Profile",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "GothamBold",
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textColor14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                              Container(
                                width: size.width * .60,
                                child: Text(
                                  "${widget.bio}" ?? "John Doe",
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: "GothamBold",
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.textColor16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                          // Container(
                          //   height: 34,
                          //   width: 34,
                          //   padding: EdgeInsets.all(6),
                          //   decoration: BoxDecoration(
                          //     color: AppColors.containerColor10,
                          //     borderRadius: BorderRadius.circular(34),
                          //   ),
                          //   child: Center(
                          //     child: Icon(
                          //       Icons.keyboard_arrow_down_rounded,
                          //       color: AppColors.textColor10,
                          //       size: 24,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    height: 600,
                    decoration: BoxDecoration(
                      color: AppColors.containerColor8,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.employes.isNotEmpty
                                    ? "Our Employees"
                                    : "",
                                style: TextStyle(
                                  fontFamily: "GothamBold",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textColor14,
                                ),
                              ),
                              widget.employes.isNotEmpty
                                  ? TextButton(
                                      onPressed: () {
                                        // debugger();
                                        // print(widget.employes);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CompanyEmployees(
                                              employees: widget.employes,
                                            ),
                                          ),
                                        );
                                        /*
                                        
12:
"github" -> null
13:
"whatsapp" -> null
[0]:
Map (18 items)
0:
"id" -> 1
1:
"first_name" -> "Zeeshan"
2:
"last_name" -> "Malik"
3:
"email" -> "zeemalik0110@gmail.com"
4:
"position" -> "Flutter Developer"
5:
"phone" -> "03097325208"
6:
"address" -> null
7:
"bio" -> null
8:
"facebook" -> null
9:
"instagram" -> null
10:
"website" -> null
11:
"linkedin" -> null

                                        */
                                      },
                                      child: Text(
                                        "View All",
                                        style: TextStyle(
                                          fontFamily: "GothamRegular",
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textColor6,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(height: 24),
                          widget.employes.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                      itemCount: widget.employes.length,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final employee = widget.employes[index];
                                        final fullName =
                                            '${employee['first_name']} ${employee['last_name']}';
                                        final position = employee['position'];
                                        final profilePic =
                                            employee['profile_pic'];
                                        return InkWell(
                                          onTap: () {
                                            print(employee);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Container(
                                              height: 80,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
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
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 12.0),
                                                    child: ClipRRect(
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
                                                  ),
                                                  SizedBox(width: 12),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                            color: Color(
                                                                    0xFF111111)
                                                                .withOpacity(
                                                                    .6),
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
                                        "Please Add Employees in your Company Tab on the Add Employee Button",
                                        style: TextStyle(
                                          fontFamily: "GothamRegular",
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textColor8,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 25),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            CupertinoDialogRoute(
                                                builder: (_) =>
                                                    AddEmployeeScreen(
                                                        create: true,
                                                        authToken: widget.token,
                                                        userDetails:
                                                            widget.userDetails,
                                                        companyDetails: widget
                                                            .profileDetails),
                                                context: context));
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
                                            "Add Employee",
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
                                  // ListView.builder(
                                  //   itemCount: 1,
                                  //   scrollDirection: Axis.vertical,
                                  //   shrinkWrap: true,
                                  //   physics: NeverScrollableScrollPhysics(),
                                  //   itemBuilder:
                                  //       (BuildContext context, int index) {
                                  //     return Padding(
                                  //       padding:
                                  //           const EdgeInsets.only(bottom: 8.0),
                                  //       child: Container(
                                  //         height: 80,
                                  //         padding: EdgeInsets.symmetric(
                                  //           vertical: 10,
                                  //         ),
                                  //         width:
                                  //             MediaQuery.of(context).size.width,
                                  //         decoration: BoxDecoration(
                                  //           color: AppColors.containerColor3,
                                  //           borderRadius:
                                  //               BorderRadius.circular(16),
                                  //         ),
                                  //         child: Row(
                                  //           children: [
                                  //             Padding(
                                  //               padding:
                                  //                   EdgeInsets.only(left: 12.0),
                                  //               child: ClipRRect(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(60),
                                  //                 child: Image.asset(
                                  //                   employees
                                  //                       .myEmployees[index].image,
                                  //                   width: 60,
                                  //                   height: 60,
                                  //                   fit: BoxFit.cover,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             SizedBox(width: 12),
                                  //             Padding(
                                  //               padding: const EdgeInsets.only(
                                  //                   top: 10),
                                  //               child: Column(
                                  //                 crossAxisAlignment:
                                  //                     CrossAxisAlignment.start,
                                  //                 children: [
                                  //                   Text(
                                  //                     employees.myEmployees[index]
                                  //                         .title,
                                  //                     style: TextStyle(
                                  //                       fontFamily: "GothamBold",
                                  //                       fontSize: 18.0,
                                  //                       fontWeight:
                                  //                           FontWeight.w700,
                                  //                       color:
                                  //                           AppColors.textColor14,
                                  //                     ),
                                  //                   ),
                                  //                   Text(
                                  //                     employees.myEmployees[index]
                                  //                         .subtitle,
                                  //                     style: TextStyle(
                                  //                       fontFamily:
                                  //                           "GothamRegular",
                                  //                       fontSize: 13.0,
                                  //                       fontWeight:
                                  //                           FontWeight.w400,
                                  //                       color: Color(0xFF111111)
                                  //                           .withOpacity(.6),
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  // ),

                                  ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  // Container(
                  //   height: 400,
                  //   decoration: BoxDecoration(
                  //     color: AppColors.containerColor8,
                  //     borderRadius: BorderRadius.circular(16),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(
                  //             left: 12.0, top: 24, right: 12),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Text(
                  //               "Engagement Metrics",
                  //               style: TextStyle(
                  //                 fontFamily: "GothamBold",
                  //                 fontSize: 18.0,
                  //                 fontWeight: FontWeight.w700,
                  //                 color: AppColors.textColor14,
                  //               ),
                  //             ),
                  //             Text(
                  //               "2023-2024",
                  //               style: TextStyle(
                  //                 fontFamily: "GothamRegular",
                  //                 fontSize: 13.0,
                  //                 fontWeight: FontWeight.w400,
                  //                 color: Color(0XFF696974),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(height: 24),
                  //       PeakInteractionChart(
                  //         timescale: 'monthly',
                  //         auth_token: widget.token,
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
