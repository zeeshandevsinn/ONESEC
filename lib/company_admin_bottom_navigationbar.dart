import 'package:client_nfc_mobile_app/controller/OnWillPop.dart';
import 'package:client_nfc_mobile_app/controller/services/company_provider.dart';
import 'package:client_nfc_mobile_app/models/company/get_company_profile.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/pages/individual_analytic_page.dart';
import 'package:client_nfc_mobile_app/screens/card-details/company_card_profile.dart';
import 'package:client_nfc_mobile_app/screens/company/company_user_create_profile.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/pages/company_appointment_page.dart';
import 'package:client_nfc_mobile_app/pages/company_employees_page.dart';
import 'package:client_nfc_mobile_app/pages/company_profile_page.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:provider/provider.dart';
import 'utils/colors.dart';

class CompanyAdminBottomNavigationBar extends StatefulWidget {
  final CompanyProfile? profileData;
  final String authToken;
  final User? userDetails;

  const CompanyAdminBottomNavigationBar({
    Key? key,
    required this.profileData,
    required this.authToken,
    required this.userDetails,
  }) : super(key: key);

  @override
  State<CompanyAdminBottomNavigationBar> createState() =>
      _CompanyAdminBottomNavigationBarState();
}

class _CompanyAdminBottomNavigationBarState
    extends State<CompanyAdminBottomNavigationBar> {
  int currentIndex = 0;
  late Future<CompanyProfile?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = _fetchProfile();
  }

  CompanyProfile? companyData;

  Future<CompanyProfile?> _fetchProfile() async {
    try {
      var provider = context.read<CompanyProvider>();
      final CompanyProfile? data = await provider.GetCurrentUserProfile(
          widget.authToken, widget.userDetails!.id);
      if (data != null) {
        setState(() {
          companyData = data;
        });
      } else {
        setState(() {
          companyData = null;
        });
      }
      print(data);
      return data;
    } catch (e) {
      print("Error fetching profile: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onWillPop(context);
      },
      child: FutureBuilder<CompanyProfile?>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingScreen();
          } else if (snapshot.hasError) {
            return _buildErrorScreen();
          } else if (companyData == null) {
            // debugger();
            return _navigateToCreateProfileScreen();
          } else {
            return _buildMainScreen(snapshot.data);
          }
        },
      ),
    );
  }

  Scaffold _buildLoadingScreen() {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator.adaptive(),
            SizedBox(height: 20),
            Text(
              'Fetching Company Profile...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Scaffold _buildErrorScreen() {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor1,
      body: Center(
        child: Text(
          'Error fetching profile',
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      ),
    );
  }

  _navigateToCreateProfileScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompanyUserCreateDetails(
              userDetails: widget.userDetails,
              create: true,
              token: widget.authToken,
              profileDetails: null,
            ),
          ));
    });
    return const SizedBox.shrink();
  }

  Widget _buildMainScreen(CompanyProfile? data) {
    final pages = [
      CompanyProfilePage(
        companyName: data?.companyName,
        companylogo: data?.companyLogo,
        bio: data?.companyDescription,
        employes: data!.employees,
        token: widget.authToken,
        userDetails: widget.userDetails,
        profileDetails: data,
        auth_type: widget.userDetails?.auth_type,
      ),
      CompanyEmployeesPage(
        authToken: widget.authToken,
        userDetails: widget.userDetails,
        companyDetails: data,
      ),
      CompanyAppointmentPage(
        userDetails: widget.userDetails,
        auth_token: widget.authToken,
      ),
      CompandCardProfile(
        auth_token: widget.authToken,
        companyProfile: data,
      ),
      // CompanyAnalyticsPage(),
      IndividualAnalyticPage(
        auth_token: widget.authToken,
      ),
    ];

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
          const BottomNavigationBarItem(
            icon: GradientIcon(
              icon: Icons.person,
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            label: "Profile",
          ),
          const BottomNavigationBarItem(
            icon: GradientIcon(
              icon: Icons.people_alt_sharp,
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
              ),
            ),
            label: "Employees",
          ),
          const BottomNavigationBarItem(
            icon: GradientIcon(
              icon: Icons.calendar_month,
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
              ),
            ),
            label: "Appointment",
          ),
          const BottomNavigationBarItem(
            icon: GradientIcon(
              icon: Icons.card_membership,
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
              ),
            ),
            label: "Digital Card",
          ),
          const BottomNavigationBarItem(
            icon: GradientIcon(
              icon: Icons.analytics_outlined,
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
              ),
            ),
            label: "Analytics",
          ),
        ],
      ),
    );
  }
}
