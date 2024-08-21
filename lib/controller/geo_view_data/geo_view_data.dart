import 'dart:convert';
import 'package:client_nfc_mobile_app/controller/endpoints.dart';
import 'package:http/http.dart' as http;

class GeoDataService {
  // Function to fetch geographical data
  static Future<List<Map<String, dynamic>>?> fetchGeoData(String token) async {
    final url = Uri.parse('${EndPointsURLs.BASE_URL}api/geo-data/');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        // Success: Parse and return the JSON data as a list of maps
        return List<Map<String, dynamic>>.from(
          json.decode(response.body) as List<dynamic>,
        );
      } else if (response.statusCode == 500) {
        // Server error: Handle or log error
        throw Exception('Server encountered an error.');
      } else {
        // Handle other statuses if necessary
        throw Exception('Failed to load data.');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      return null;
    }
  }
}
