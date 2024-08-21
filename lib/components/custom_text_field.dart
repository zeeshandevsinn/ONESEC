import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String? obscureCharacter;
  final String hintText;
  final Widget? prefixIcon;
  var validator;
  var enabled;
  CustomTextField(
      {super.key,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.isObscureText = false,
      this.obscureCharacter = "*",
      required this.hintText,
      this.prefixIcon,
      this.validator,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator != null
          ? validator
          : (val) {
              if (val!.isEmpty) {
                return "Field is Empty";
              }
              return null;
            },
      style: TextStyle(
        fontFamily: "GothamRegular",
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: AppColors.textColor12,
      ),
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isObscureText!,
      obscuringCharacter: obscureCharacter!,
      cursorColor: AppColors.textColor29,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: "GothamRegular",
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor10,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(width: 1, color: AppColors.textColor10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(width: 1, color: AppColors.textColor13),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(width: 1, color: AppColors.textColor13),
          ),
          fillColor: AppColors.containerColor8,
          filled: true,
          enabled: enabled),
    );
  }
}
