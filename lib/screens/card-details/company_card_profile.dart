import 'package:client_nfc_mobile_app/models/company/get_company_profile.dart';
import 'package:client_nfc_mobile_app/screens/share_profile_screen/share_profile_screen.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CompandCardProfile extends StatefulWidget {
  final auth_token;
  final CompanyProfile companyProfile;
  const CompandCardProfile(
      {super.key, required this.companyProfile, required this.auth_token});

  @override
  State<CompandCardProfile> createState() => _CompandCardProfileState();
}

class _CompandCardProfileState extends State<CompandCardProfile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    child: widget.companyProfile.companyLogo != null
                        ? FadeInImage.assetNetwork(
                            placeholder: 'assets/images/logo.png',
                            image: widget.companyProfile.companyLogo!,
                            fit: BoxFit.cover,
                            width: 140,
                            height: 140,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 70,
                                ),
                              );
                            },
                          )
                        : Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.business,
                              color: Colors.black,
                              size: 70,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60), // Adjusted to account for the avatar position
            Center(
              child: Column(
                children: [
                  Text(
                    widget.companyProfile.companyName,
                    style: TextStyle(
                      fontFamily: "GothamBold",
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Admin: ${widget.companyProfile.adminName}",
                    style: TextStyle(
                      fontFamily: "GothamRegular",
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.companyProfile.companyDescription ??
                    "No description available.",
                style: TextStyle(fontSize: 17),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Contact Information",
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
                  _buildContactInfo(Icons.email, widget.companyProfile.email),
                  _buildContactInfo(Icons.phone, widget.companyProfile.phone),
                  _buildContactInfo(
                      Icons.location_on, widget.companyProfile.address),
                ],
              ),
            ),
            SizedBox(height: 20),
            if (widget.companyProfile.website != null ||
                widget.companyProfile.linkedin != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Social Media",
                  style: TextStyle(
                    fontFamily: "GothamBold",
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            if (widget.companyProfile.website != null ||
                widget.companyProfile.linkedin != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.companyProfile.website != null)
                      _buildSocialIcon(
                        FontAwesomeIcons.globe,
                        widget.companyProfile.website!,
                      ),
                    if (widget.companyProfile.linkedin != null)
                      _buildSocialIcon(
                        FontAwesomeIcons.linkedin,
                        widget.companyProfile.linkedin!,
                      ),
                  ],
                ),
              ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoDialogRoute(
                        builder: (_) =>
                            ShareProfileScreen(auth_token: widget.auth_token),
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

  Widget _buildSocialIcon(IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () async {
          final bool isLinkedIn = url.contains('linkedin.com');

          // Define the URL launcher for LinkedIn and web
          final Uri uri = Uri.parse(url);

          // Open URL based on type
          if (await canLaunchUrl(uri)) {
            if (isLinkedIn) {
              // Open LinkedIn in the LinkedIn app or default browser
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            } else {
              // Open website in the default browser (e.g., Chrome)
              await launchUrl(uri, mode: LaunchMode.inAppWebView);
            }
          } else {
            throw 'Could not launch $url';
          }
          // Implement URL launch here
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent,
                Colors.purpleAccent,
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
}
