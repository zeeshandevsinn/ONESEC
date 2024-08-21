import 'package:client_nfc_mobile_app/controller/services/appointment/appointment_service.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/material.dart';

class AppointmentProvider extends ChangeNotifier {
  bool isLoading = false;

  getUpcomingAppointment(token) async {
    isLoading = true;
    notifyListeners();
    try {
      final data = await AppointmentServices.getAppointments(token);
      if (data != null) {
        isLoading = false;
        notifyListeners();
        return data;
      }
    } catch (e) {
      MyToast("Some Issue Try Again", Type: false);
      return null;
    }
  }
}
