import 'dart:developer';

import 'package:client_nfc_mobile_app/components/custom_text_field.dart';
import 'package:client_nfc_mobile_app/controller/prefrences.dart';
import 'package:client_nfc_mobile_app/controller/services/appointment/appoinment_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/google_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/login_api.dart';
import 'package:client_nfc_mobile_app/controller/services/share_profile_provider/share_profile_manager.dart';
import 'package:client_nfc_mobile_app/controller/services/share_profile_provider/share_profile_provider.dart';
import 'package:client_nfc_mobile_app/models/appointments/appointment_model.dart';
import 'package:client_nfc_mobile_app/screens/delete_account_screen.dart';
import 'package:client_nfc_mobile_app/screens/share_profile_screen/received_profile_screen.dart';
import 'package:client_nfc_mobile_app/screens/share_profile_screen/share_profile_screen.dart';
import 'package:client_nfc_mobile_app/utils/loading_circle.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/data/popup_menu_items.dart';
import 'package:client_nfc_mobile_app/data/upcoming_appointment_items.dart';
import 'package:client_nfc_mobile_app/pages/manage_account_setting.dart';
import 'package:client_nfc_mobile_app/pages/monitor_system_activities.dart';
import 'package:client_nfc_mobile_app/pages/notification_setting.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class IndividualProfilePage extends StatefulWidget {
  final auth_token;
  String? name;
  String? profile_pic;
  final auth_type;
  final userId;
  final userDetails;
  IndividualProfilePage(
      {super.key,
      required this.auth_token,
      this.name,
      this.profile_pic,
      this.auth_type,
      required this.userId,
      required this.userDetails});

  @override
  State<IndividualProfilePage> createState() => _IndividualProfilePageState();
}

class _IndividualProfilePageState extends State<IndividualProfilePage> {
  _showPopupMenu(BuildContext context, auth_token) async {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        PopupMenuItem(
          child: ListTile(
            title: Text('Delete Account'),
            onTap: () {
              Navigator.pop(context); // Close the popup menu
              _showDeleteDialog(context, auth_token, widget.auth_type);
            },
          ),
        ),
      ],
    );
  }

  void showMenuCard(BuildContext context, token, bool isGoogle) {
    List<String> filteredChoices = PopUpMenuItems.choices
        .where(
            (choice) => !(isGoogle && choice == PopUpMenuItems.accountSetting))
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
              PopUpMenuItems.choiceIcons[choice],
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
                            userID: widget.userId,
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
    if (choices == PopUpMenuItems.receivedProfiles) {
      Navigator.push(
        context,
        CupertinoDialogRoute(
          builder: (context) => ReceivedProfileScreen(
            userDetails: widget.userDetails,
            auth_token: widget.auth_token,
          ),
          context: context,
        ),
      );
    } else if (choices == PopUpMenuItems.accountSetting) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ManageAccountSetting(
            auth_token: widget.auth_token,
          ),
        ),
      );
    }
    // else if (choices == PopUpMenuItems.monitorSetting) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => MonitorSystemActivities(),
    //     ),
    //   );
    // }
    // else if (choices == PopUpMenuItems.notification) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => NotificationSetting(),
    //     ),
    //   );
    // }

    else if (choices == PopUpMenuItems.deleteAccount) {
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
                                        userID: widget.userId,
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
    } else if (choices == PopUpMenuItems.shareprofile) {
      Navigator.push(
          context,
          CupertinoDialogRoute(
              builder: (_) => ShareProfileScreen(auth_token: widget.auth_token),
              context: context));

      // profileUrl = URlProfile(widget.auth_token);
    } else if (choices == PopUpMenuItems.logout) {
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

  String? profileUrl;
  late Future<List<dynamic>> _getAppointments;

  Future<List<dynamic>> _fetchReceivedAppointments() async {
    var pro = context.read<AppointmentProvider>();
    final response = await pro.getUpcomingAppointment(widget.auth_token);
    // debugger();
    if (response is Map<String, dynamic>) {
      // Assuming the list of appointments is inside the 'appointments' key
      if (response.containsKey('results')) {
        print(response);
        return response['results'];
      } else {
        return [];
      }
    } else if (response is List) {
      print(response);
      return response;
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<LoginUserProvider>();
    context.read<AppointmentProvider>();
    context.read<LoginUserProvider>().logoutLoading = false;
    // Assign the function to the Future variable
    _getAppointments = _fetchReceivedAppointments();
  }

  @override
  Widget build(BuildContext context) {
    var gro = context.watch<GoogleProvider>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Icon(
                        //     Icons.remove_red_eye_outlined,
                        //     size: 30,
                        //     color: AppColors.textColor10,
                        //   ),
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
                    IconButton(
                      onPressed: () {
                        // _showPopupMenu(context, widget.auth_token);
                        showMenuCard(
                            context, widget.auth_token, gro.isGoogleLogin);
                        // print(widget.auth_token);
                      },
                      icon: Icon(
                        Icons.more_horiz,
                        size: 30,
                        color: AppColors.textColor10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
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
                          child: widget.profile_pic != null
                              ? FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/logo.png',
                                  image: widget.profile_pic!,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
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
                        Flexible(
                          child: Container(
                            width: size.width * .70,
                            child: Text(
                              "Hi, ${widget.name}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "GothamBold",
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textColor14,
                              ),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                        ),
                        // GestureDetector(
                        //   onTap: () async {
                        //     final token = await AuthTokenStorage.getAuthToken();
                        //     print(token);
                        //   },
                        //   child: Container(
                        //     height: 34,
                        //     width: 34,
                        //     padding: EdgeInsets.all(6),
                        //     decoration: BoxDecoration(
                        //       color: AppColors.containerColor10,
                        //       borderRadius: BorderRadius.circular(34),
                        //     ),
                        //     child: Center(
                        //       child: Icon(
                        //         Icons.keyboard_arrow_down_rounded,
                        //         color: AppColors.textColor10,
                        //         size: 24,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: Row(
                            children: [
                              Text(
                                "Upcoming Appointments",
                                style: TextStyle(
                                  fontFamily: "GothamBold",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textColor14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: FutureBuilder<List<dynamic>>(
                            future: _getAppointments,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(child: LoadingCircle());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                final appointments = snapshot.data;
                                // debugger();
                                if (appointments!.isEmpty) {
                                  return const Center(
                                      child: Text(
                                    'No appointments available.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "GothamBold",
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textColor14,
                                    ),
                                  ));
                                } else {
                                  return ListView.builder(
                                    itemCount: appointments.length,
                                    itemBuilder: (context, index) {
                                      Appointments data = Appointments.fromJson(
                                          appointments[index]);
                                      String isoDate = data.datetime.toString();

                                      // Parse the ISO string to a DateTime object
                                      DateTime dateTime =
                                          DateTime.parse(isoDate);

                                      // Format the DateTime object into a human-readable string
                                      String formattedDate =
                                          DateFormat.yMMMMd('en_US')
                                              .add_jm()
                                              .format(dateTime);
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: size.height * .20,
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          margin: const EdgeInsets.only(
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                    child: Image.asset(
                                                      'assets/images/logo.png',
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  if (data.type == "host")
                                                    Text(
                                                      "Hosted by You:",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            "GothamRegular",
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .textColor14,
                                                      ),
                                                    )
                                                  else
                                                    Text(
                                                      "Attendee by You:",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            "GothamRegular",
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .textColor14,
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .60,
                                                    child: Text(
                                                      data.title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            "GothamRegular",
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .textColor14,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    formattedDate,
                                                    style: const TextStyle(
                                                      fontFamily: "GothamBold",
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  if (data
                                                      .attendeeEmail.isNotEmpty)
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .60,
                                                      child: Text(
                                                        data.attendeeEmail,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        softWrap: true,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              "GothamBold",
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        size: 15,
                                                        color:
                                                            data.meetingStatus ==
                                                                    "pending"
                                                                ? Colors.red
                                                                : Colors.green,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        data.meetingStatus,
                                                        style: const TextStyle(
                                                          fontFamily:
                                                              "GothamRegular",
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0XFF44444F),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const Row(
                                                children: [],
                                              )
                                            ],
                                          ),
                                        ),
                                      );

                                      // Your ListTile or custom widget code here
                                    },
                                  );
                                }
                              } else {
                                return const Center(
                                    child: Text(
                                  'No Appointments Found!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "GothamBold",
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor14,
                                  ),
                                ));
                              }
                            },
                          ),
                        ),
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
