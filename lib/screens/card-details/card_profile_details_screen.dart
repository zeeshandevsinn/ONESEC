import 'package:client_nfc_mobile_app/models/user_profile/user_profile_details.dart';
import 'package:client_nfc_mobile_app/screens/share_profile_screen/share_profile_screen.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DigitalCardProfile extends StatefulWidget {
  final authToken;
  final UserProfileDetails profileDetails;
  const DigitalCardProfile(
      {super.key, required this.authToken, required this.profileDetails});

  @override
  State<DigitalCardProfile> createState() => _DigitalCardProfileState();
}

class _DigitalCardProfileState extends State<DigitalCardProfile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/background.png",
                  height: size.height / 3,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    bottom: -50,
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/logo.png',
                        image: widget.profileDetails.profilePic,
                        fit: BoxFit.cover,
                        width:
                            140, // Adjust width and height to match the radius * 2
                        height:
                            140, // Adjust width and height to match the radius * 2
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors
                                .grey[200], // Background color when image fails
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 70, // Adjust size to fit within the circle
                            ),
                          );
                        },
                      ),
                    )),
              ],
            ),
            SizedBox(height: 60), // Adjusted to account for the avatar position
            Center(
              child: Column(
                children: [
                  Text(
                    widget.profileDetails.firstName +
                        ' ' +
                        widget.profileDetails.lastName,
                    style: TextStyle(
                      fontFamily: "GothamBold",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.profileDetails.postion,
                    style: TextStyle(
                      fontFamily: "GothamRegular",
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(FontAwesomeIcons.facebookF,
                      widget.profileDetails.facebook ?? ""),
                  _buildSocialIcon(FontAwesomeIcons.instagram,
                      widget.profileDetails.instagram ?? ""),
                  _buildSocialIcon(FontAwesomeIcons.github,
                      widget.profileDetails.github ?? ""),
                  _buildSocialIcon(FontAwesomeIcons.globe,
                      widget.profileDetails.website ?? ""),
                  _buildSocialIcon(FontAwesomeIcons.linkedin,
                      widget.profileDetails.linkedin ?? ""),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "About",
                style: TextStyle(
                  fontFamily: "GothamBold",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                widget.profileDetails.bio,
                style: TextStyle(fontSize: 17),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Contact Me",
                style: TextStyle(
                  fontFamily: "GothamBold",
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContactInfo(Icons.email, widget.profileDetails.email),
                  _buildContactInfo(Icons.phone, widget.profileDetails.phone),
                  _buildContactInfo(
                      Icons.location_on, widget.profileDetails.address),
                ],
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoDialogRoute(
                        builder: (_) =>
                            ShareProfileScreen(auth_token: widget.authToken),
                        context: context));
              },
              child: Container(
                margin: EdgeInsets.all(20),
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
                child: const Center(
                  child: Text(
                    "Share Profile",
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

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: () async {
          if (url.isEmpty) {
            MyToast(
                "Oops! The URL hasn’t been updated yet. Please update it before continuing.",
                Type: false);
          } else {
            final bool appCheck = url.contains('linkedin.com')
                ? true
                : url.contains('github.com')
                    ? true
                    : url.contains('facebook.com')
                        ? true
                        : url.contains('instagram.com')
                            ? true
                            : false;

            // Define the URL launcher for LinkedIn and web
            final Uri uri = Uri.parse(url);

            // Open URL based on type
            if (await canLaunchUrl(uri)) {
              if (appCheck) {
                // Open LinkedIn in the LinkedIn app or default browser
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              } else {
                // Open website in the default browser (e.g., Chrome)
                await launchUrl(uri, mode: LaunchMode.inAppWebView);
              }
            } else {
              throw 'Could not launch $url';
            }
          }
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.secondaryColor,
              ],
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          SizedBox(width: 12),
          Flexible(
            child: Container(
              child: Text(
                info,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
