import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var displayHeight = MediaQuery.of(context).size.height;
    return SpinKitFadingCircle(
      color: AppColors.primaryColor,
      size: displayHeight * 0.08,
    );
  }
}
