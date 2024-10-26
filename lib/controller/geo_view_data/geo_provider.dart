import 'dart:convert';

import 'package:client_nfc_mobile_app/controller/geo_view_data/geo_view_data.dart';
import 'package:client_nfc_mobile_app/utils/country_colors.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class GeoProvider extends ChangeNotifier {
  bool isLoading = false;

  fetchGeoViewData(token) async {
    try {
      isLoading = true;
      Future.microtask(() => notifyListeners());
      final response = await GeoDataService.fetchGeoData(token);
      if (response != null) {
        isLoading = false;
        Future.microtask(() => notifyListeners());

        // Convert API data to a map of country codes to colors

        print(response);
        return response;
        // return data;
      } else {
        isLoading = false;
        Future.microtask(() => notifyListeners());
        return null;
      }
    } catch (e) {
      isLoading = false;
      Future.microtask(() => notifyListeners());
      MyToast(e.toString(), Type: false);
      return null;
    }
  }
}
