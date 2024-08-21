import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:gradient_borders/gradient_borders.dart';
import '../utils/colors.dart';

class SocialMediaButtons extends StatelessWidget {
  final String image;
  final String text;
  const SocialMediaButtons({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 20,
            height: 20,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 8),
          GradientText(
            text,
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
        ],
      ),
    );
  }
}
