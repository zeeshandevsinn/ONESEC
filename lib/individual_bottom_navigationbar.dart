import 'dart:developer';
import 'package:client_nfc_mobile_app/controller/OnWillPop.dart';
import 'package:client_nfc_mobile_app/screens/card-details/card_profile_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client_nfc_mobile_app/controller/services/user_profile_provider.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/models/user_profile/user_profile_details.dart';
import 'package:client_nfc_mobile_app/screens/update_profile/update_profile_screen.dart';
import 'package:client_nfc_mobile_app/pages/individual_analytic_page.dart';
import 'package:client_nfc_mobile_app/pages/individual_appointment_page.dart';
import 'package:client_nfc_mobile_app/pages/individual_nfc_page.dart';
import 'package:client_nfc_mobile_app/pages/individual_profile_page.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:gradient_icon/gradient_icon.dart';

class IndividualBottomNavigationBar extends StatefulWidget {
  final String user_auth_token;
  final User? futureUser;

  IndividualBottomNavigationBar({
    super.key,
    required this.user_auth_token,
    required this.futureUser,
  });

  @override
  State<IndividualBottomNavigationBar> createState() =>
      _IndividualBottomNavigationBarState();
}

class _IndividualBottomNavigationBarState
    extends State<IndividualBottomNavigationBar> {
  int currentIndex = 0;
  late Future<UserProfileDetails?> _profileFuture;

  Future<UserProfileDetails?> _fetchProfile() async {
    var pro = context.read<UserProfileProvider>();
    final data =
        await pro.GetUserProfile(widget.futureUser?.id, widget.user_auth_token);
    print(data);
    // debugger();
    if (data != null) {
      setState(() {
        fullName = data.firstName;
        profilePic = data.profilePic;
      });
    }

    return data;
  }

  UserProfileDetails? profileDetails;
  String? fullName;
  String? profilePic;
  @override
  void initState() {
    super.initState();
    _profileFuture = _fetchProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh the profile future whenever dependencies change
    _profileFuture = _fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onWillPop(context);
      },
      child: FutureBuilder<UserProfileDetails?>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: AppColors
                  .backgroundColor1, // Set the background color to white
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(),
                    SizedBox(
                        height: 20), // Add space between the spinner and text
                    Text(
                      'Fetching Your Profile...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black, // Set text color
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              backgroundColor: AppColors.backgroundColor1,
              body: Center(
                child: Text(
                  'Error fetching profile',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),
            );
          } else {
            profileDetails = snapshot.data;

            List<Widget> pages = [
              IndividualProfilePage(
                userDetails: widget.futureUser,
                auth_type: widget.futureUser?.auth_type,
                auth_token: widget.user_auth_token,
                name: fullName,
                profile_pic: profilePic,
                userId: widget.futureUser?.id,
              ),
              IndividualNFCPage(),
              CreatAndUpdateProfileScreen(
                create: false,
                profileDetails: profileDetails,
                userDetails: widget.futureUser,
                token: widget.user_auth_token,
              ),
              IndividualAppointmentPage(
                auth_token: widget.user_auth_token,
                userDetails: widget.futureUser,
              ),
              DigitalCardProfile(
                  authToken: widget.user_auth_token,
                  profileDetails: profileDetails!),
              IndividualAnalyticPage(
                auth_token: widget.user_auth_token,
              ),
            ];

            if (profileDetails == null) {
              return CreatAndUpdateProfileScreen(
                  token: widget.user_auth_token,
                  create: true,
                  userDetails: widget.futureUser);
            } else {
              return Scaffold(
                backgroundColor: AppColors.backgroundColor1,
                body: SafeArea(
                  child: pages[currentIndex],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: AppColors.textColor16,
                  currentIndex: currentIndex,
                  onTap: (index) => setState(() => currentIndex = index),
                  items: [
                    BottomNavigationBarItem(
                      icon: GradientIcon(
                        icon: Icons.menu,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: GradientIcon(
                        icon: Icons.wifi,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor
                          ],
                        ),
                      ),
                      label: "NFC",
                    ),
                    BottomNavigationBarItem(
                      icon: GradientIcon(
                        icon: Icons.person,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor
                          ],
                        ),
                      ),
                      label: "Profile",
                    ),
                    BottomNavigationBarItem(
                      icon: GradientIcon(
                        icon: Icons.calendar_month,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor
                          ],
                        ),
                      ),
                      label: "Appointment",
                    ),
                    BottomNavigationBarItem(
                      icon: GradientIcon(
                        icon: Icons.card_membership,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor
                          ],
                        ),
                      ),
                      label: "Digital Card",
                    ),
                    BottomNavigationBarItem(
                      icon: GradientIcon(
                        icon: Icons.analytics_outlined,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor
                          ],
                        ),
                      ),
                      label: "Analytics",
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}

// import 'package:client_nfc_mobile_app/screens/update_profile/update_profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:client_nfc_mobile_app/controller/services/user_profile_provider.dart';
// import 'package:client_nfc_mobile_app/models/user_model.dart';
// import 'package:client_nfc_mobile_app/models/user_profile/user_profile_details.dart';
// import 'package:client_nfc_mobile_app/pages/individual_profile_page.dart';
// import 'package:client_nfc_mobile_app/pages/individual_nfc_page.dart';
// import 'package:client_nfc_mobile_app/pages/individual_appointment_page.dart';
// import 'package:client_nfc_mobile_app/pages/individual_analytic_page.dart';
// import 'package:client_nfc_mobile_app/utils/colors.dart';
// import 'package:gradient_icon/gradient_icon.dart';

// class IndividualBottomNavigationBar extends StatefulWidget {
//   final String userAuthToken;
//   final User? futureUser;

//   IndividualBottomNavigationBar({
//     Key? key,
//     required this.userAuthToken,
//     required this.futureUser,
//   }) : super(key: key);

//   @override
//   State<IndividualBottomNavigationBar> createState() =>
//       _IndividualBottomNavigationBarState();
// }

// class _IndividualBottomNavigationBarState
//     extends State<IndividualBottomNavigationBar> {
//   int currentIndex = 0;
//   late Future<UserProfileDetails?> _profileFuture;
//   late List<Widget> pages;
//   final ValueNotifier<UserProfileDetails?> _profileNotifier =
//       ValueNotifier<UserProfileDetails?>(null);

//   Future<UserProfileDetails?> _fetchProfile() async {
//     var pro = context.read<UserProfileProvider>();
//     return await pro.GetUserProfile(
//         widget.futureUser!.id, widget.userAuthToken);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _profileFuture = _fetchProfile();
//     _profileFuture.then((profileDetails) {
//       _profileNotifier.value = profileDetails;
//     });
//     pages = [
//       CheckingProfileDetails(
//           authToken: widget.userAuthToken, profileNotifier: _profileNotifier),
//       IndividualNFCPage(),
//       CreatAndUpdateProfileScreen(
//         create: false,
//         profileDetails: _profileNotifier.value,
//         userDetails: widget.futureUser,
//         token: widget.userAuthToken,
//       ),
//       IndividualAppointmentPage(),
//       IndividualAnalyticPage(),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor1,
//       body: SafeArea(
//         child: ValueListenableBuilder<UserProfileDetails?>(
//           valueListenable: _profileNotifier,
//           builder: (context, profileDetails, child) {
//             if (profileDetails == null) {
//               return Center(
//                 child: CircularProgressIndicator.adaptive(),
//               );
//             }

//             pages[2] = CreatAndUpdateProfileScreen(
//               token: widget.userAuthToken,
//               create: false,
//               profileDetails: profileDetails,
//               userDetails: widget.futureUser,
//             );

//             return pages[currentIndex];
//           },
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         unselectedItemColor: AppColors.textColor16,
//         currentIndex: currentIndex,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: GradientIcon(
//               icon: Icons.menu,
//               gradient: LinearGradient(
//                 colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: GradientIcon(
//               icon: Icons.wifi,
//               gradient: LinearGradient(
//                 colors: [AppColors.primaryColor, AppColors.secondaryColor],
//               ),
//             ),
//             label: "NFC",
//           ),
//           BottomNavigationBarItem(
//             icon: GradientIcon(
//               icon: Icons.person,
//               gradient: LinearGradient(
//                 colors: [AppColors.primaryColor, AppColors.secondaryColor],
//               ),
//             ),
//             label: "Profile",
//           ),
//           BottomNavigationBarItem(
//             icon: GradientIcon(
//               icon: Icons.calendar_month,
//               gradient: LinearGradient(
//                 colors: [AppColors.primaryColor, AppColors.secondaryColor],
//               ),
//             ),
//             label: "Appointment",
//           ),
//           BottomNavigationBarItem(
//             icon: GradientIcon(
//               icon: Icons.analytics_outlined,
//               gradient: LinearGradient(
//                 colors: [AppColors.primaryColor, AppColors.secondaryColor],
//               ),
//             ),
//             label: "Analytics",
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CheckingProfileDetails extends StatelessWidget {
//   final String authToken;
//   final ValueNotifier<UserProfileDetails?> profileNotifier;

//   CheckingProfileDetails({
//     Key? key,
//     required this.authToken,
//     required this.profileNotifier,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<UserProfileDetails?>(
//       valueListenable: profileNotifier,
//       builder: (context, profileDetails, child) {
//         if (profileDetails == null) {
//           return Center(
//             child: CircularProgressIndicator.adaptive(),
//           );
//         }

//         // Your profile page implementation
//         return IndividualProfilePage(
//           auth_token: authToken,
//         );
//       },
//     );
//   }
// }
