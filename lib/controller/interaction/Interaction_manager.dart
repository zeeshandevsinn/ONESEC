import 'dart:convert';
import 'dart:developer';

import 'package:client_nfc_mobile_app/controller/endpoints.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:http/http.dart' as http;

class InteractionManager {
  static createInteraction(int userId) async {
    final String url = 'https://api.onesec.shop/api/create_interaction/';

    final Map<String, dynamic> body = {
      'interaction_type': "view_profile",
      'user': userId,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // Add any required headers here
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        // MyToast("Interaction Created Successfully");
        // Assuming the API returns 201 Created on success
        return jsonDecode(response.body);
      } else {
        MyToast(
            'Failed to create interaction. Status code: ${response.statusCode}',
            Type: false);
        MyToast('Response body: ${response.body}', Type: false);
        return null;
      }
    } catch (e) {
      print('Error creating interaction: $e');
      return null;
    }
  }
}
