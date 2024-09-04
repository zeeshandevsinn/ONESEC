import 'package:client_nfc_mobile_app/components/custom_text_field.dart';
import 'package:client_nfc_mobile_app/controller/interaction/services/interaction_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/company_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/share_profile_provider/share_profile_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/user_profile_provider.dart';
import 'package:client_nfc_mobile_app/models/company/get_company_profile.dart';
import 'package:client_nfc_mobile_app/models/user_profile/user_profile_details.dart';
import 'package:client_nfc_mobile_app/pages/appointment_schedule.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AppoinmentShareProfileScreen extends StatefulWidget {
  final auth_token;
  final userID_share_from;
  final profile_type;
  final userDetails;
  const AppoinmentShareProfileScreen(
      {super.key,
      required this.auth_token,
      required this.userID_share_from,
      required this.profile_type,
      required this.userDetails});

  @override
  State<AppoinmentShareProfileScreen> createState() =>
      _AppoinmentShareProfileScreenState();
}

class _AppoinmentShareProfileScreenState
    extends State<AppoinmentShareProfileScreen> {
  final passwordController = TextEditingController();
  var newKey = GlobalKey<FormState>();
  late Future<CompanyProfile?> _profileFuture;
  @override
  void initState() {
    super.initState();
    context.read<ShareProfileProvider>();
    context.read<InteractionProvider>();
    InteractionCreater();
    ProfileTypeFunc(widget.profile_type);
  }

  InteractionCreater() async {
    await createInteraction(widget.userID_share_from);
  }

  createInteraction(userID) async {
    var pro = context.read<InteractionProvider>();
    final data = await pro.createInteraction(userID);
    return data;
  }

  ProfileTypeFunc(profile_type) {
    if (profile_type == 'company') {
      setState(() {
        _profileFuture = _fetchCompanyProfile();
      });
    } else {
      setState(() {
        _profileUserFuture = _fetchUserProfile();
      });
    }
  }

  late Future<UserProfileDetails?> _profileUserFuture;

  Future<UserProfileDetails?> _fetchUserProfile() async {
    var pro = context.read<UserProfileProvider>();
    final data =
        await pro.GetUserProfile(widget.userID_share_from, widget.auth_token);
    print(data);

    return data;
  }

  Future<CompanyProfile?> _fetchCompanyProfile() async {
    try {
      var provider = context.read<CompanyProvider>();
      final CompanyProfile? data = await provider.GetCurrentUserProfile(
          widget.auth_token, widget.userID_share_from);

      print(data);
      return data;
    } catch (e) {
      print("Error fetching profile: $e");
      return null;
    }
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

  CompanyProfile? companyProfile;
  UserProfileDetails? userProfile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        var pro = context.watch<ShareProfileProvider>();
        var gro = context.watch<InteractionProvider>();
        if (pro.isLoading) {
          _showLoadingDialog(context);
        }
        return gro.isLoading
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : SingleChildScrollView(
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
                            height: MediaQuery.of(context).size.height * .90,
                            width: double.infinity,
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
                                SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.only(left: 24.0),
                                  child: GradientText(
                                    "Share Profile Details!",
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
                                  padding: const EdgeInsets.only(
                                      left: 24, right: 24),
                                  child: Text(
                                    "You can Share back your Profile or Fix Appoinment with its User",
                                    style: TextStyle(
                                      fontFamily: "GothamRegular",
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textColor8,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 22),
                                widget.profile_type != 'company'
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child:
                                            FutureBuilder<UserProfileDetails?>(
                                          future: _profileUserFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                  'Error: ${snapshot.error}',
                                                  style: TextStyle(
                                                    fontFamily: "GothamBold",
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColors.textColor14,
                                                  ),
                                                ),
                                              );
                                            } else if (!snapshot.hasData ||
                                                snapshot.data == null) {
                                              return Center(
                                                child: Text(
                                                  'Internet Issue, Try Again',
                                                  style: TextStyle(
                                                    fontFamily: "GothamBold",
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColors.textColor14,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              userProfile = snapshot.data!;
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                      radius: 62,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              userProfile!
                                                                  .profilePic)),
                                                  Text(
                                                    '${userProfile?.firstName} ${userProfile?.lastName}',
                                                    style: TextStyle(
                                                      fontFamily: "GothamBold",
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    '${userProfile?.email}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "GothamRegular",
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  // Add more fields as necessary
                                                ],
                                              );
                                            }
                                          },
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                        child: FutureBuilder<CompanyProfile?>(
                                          future: _profileFuture,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                  'Error: ${snapshot.error}',
                                                  style: TextStyle(
                                                    fontFamily: "GothamBold",
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColors.textColor14,
                                                  ),
                                                ),
                                              );
                                            } else if (!snapshot.hasData ||
                                                snapshot.data == null) {
                                              return Center(
                                                child: Text(
                                                  'Internet Issue, Try Again',
                                                  style: TextStyle(
                                                    fontFamily: "GothamBold",
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColors.textColor14,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              companyProfile = snapshot.data!;
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                      radius: 62,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              companyProfile!
                                                                  .companyLogo!)),
                                                  Text(
                                                    '${companyProfile!.companyName}',
                                                    style: TextStyle(
                                                      fontFamily: "GothamBold",
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    '${companyProfile!.email}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "GothamRegular",
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  // Add more fields as necessary
                                                ],
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (widget.profile_type == 'company') {
                                          await pro.ShareProfileThroughEmail(
                                              widget.auth_token,
                                              companyProfile?.email);
                                        } else {
                                          await pro.ShareProfileThroughEmail(
                                              widget.auth_token,
                                              userProfile?.email);
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        padding: EdgeInsets.all(10.0),
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
                                            "Share back",
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
                                    GestureDetector(
                                      onTap: () {
                                        if (widget.profile_type == 'company') {
                                          Navigator.push(
                                              context,
                                              CupertinoDialogRoute(
                                                  builder: (_) =>
                                                      ScheduleAppointment(
                                                          token:
                                                              widget.auth_token,
                                                          userDetails: widget
                                                              .userDetails,
                                                          userID: widget
                                                              .userID_share_from,
                                                          email: companyProfile
                                                              ?.email),
                                                  context: context));
                                        } else {
                                          Navigator.push(
                                              context,
                                              CupertinoDialogRoute(
                                                  builder: (_) =>
                                                      ScheduleAppointment(
                                                          token:
                                                              widget.auth_token,
                                                          userDetails: widget
                                                              .userDetails,
                                                          userID: widget
                                                              .userID_share_from,
                                                          email: userProfile
                                                              ?.email),
                                                  context: context));
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        padding: EdgeInsets.all(10.0),
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
                                            "Appointment Shedule",
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
                                SizedBox(height: 30),
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
