import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/screens/login_screen.dart';
import '../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;

  const CustomButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
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
            text,
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
    );
  }
}
