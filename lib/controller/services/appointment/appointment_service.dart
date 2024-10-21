import 'dart:convert';
import 'dart:developer';

import 'package:client_nfc_mobile_app/controller/endpoints.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:http/http.dart' as http;

class AppointmentServices {
  static getAppointments(token) async {
    try {
      final completeUrl =
          EndPointsURLs.BASE_URL + EndPointsURLs.get_appointments;

      final url = Uri.parse(completeUrl);

      final response =
          await http.get(url, headers: {"Authorization": "Token $token"});
      // debugger();
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        MyToast("Here Some thing Went Wrong", Type: false);
        return null;
      }
    } catch (e) {
      // MyToast(e.toString(), Type: false);
      return null;
    }
  }
}
