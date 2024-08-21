import 'dart:convert';

import 'package:client_nfc_mobile_app/controller/endpoints.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:http/http.dart' as http;

class InteractionManager {
  static createInteraction(userID) async {
    try {
      final complete_url = '${EndPointsURLs.BASE_URL}api/create_interaction/';
      final url = Uri.parse(complete_url);

      final response = await http.post(url,
          body: {"interaction_type": "view_profile", "user": userID});
      if (response.statusCode == 201) {
        MyToast("Interaction Create Successfully");
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      MyToast("Something Wrong", Type: false);
      return null;
    }
  }
}
