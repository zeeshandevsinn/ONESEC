import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

MyToast(message, {Type = true}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Type ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
