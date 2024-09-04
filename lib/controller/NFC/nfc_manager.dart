import 'dart:convert';
import 'package:client_nfc_mobile_app/controller/endpoints.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart'; // Ensure the correct import for `ndef` package

class NfcService {
  final String baseUrl = EndPointsURLs.BASE_URL;
  final String authToken;

  NfcService({required this.authToken});

  Future<String?> nfcWrite(Map<String, dynamic> profileData) async {
    final url = Uri.parse('$baseUrl/api/nfc-write/');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $authToken',
        },
        body: jsonEncode(profileData),
      );
      // debugger();

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['encrypted_data'];
      } else if (response.statusCode == 400) {
        final error = jsonDecode(response.body)['error'];
        MyToast('Error: $error', Type: false);
        return null;
      } else {
        MyToast('Server encountered an error.', Type: false);
        return null;
      }
    } catch (e) {
      MyToast('Failed to write NFC: $e', Type: false);
      return null;
    }
  }

  Future<Map<String, dynamic>?> nfcRead(String encryptedData) async {
    final url = Uri.parse('$baseUrl/api/nfc-read/');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $authToken',
        },
        body: jsonEncode({'encrypted_data': encryptedData}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        final error = jsonDecode(response.body)['error'];
        MyToast('Error: $error', Type: false);
        return null;
      } else {
        MyToast('Server encountered an error.', Type: false);
        return null;
      }
    } catch (e) {
      MyToast('Failed to read NFC: $e', Type: false);
      return null;
    }
  }

  writeDataToNfc(Map<String, dynamic> profileData) async {
    try {
      // final encryptedData = await nfcWrite(profileData);

      // if (encryptedData == null) {
      //   MyToast('No encrypted data received.', Type: false);
      //   return null;
      // }

      // Start NFC session
      await FlutterNfcKit.poll();

      // Create NDEFRawRecord
      final record = NDEFRawRecord(
        '', // Identifier (empty if not used)
        profileData.toString(),
        'T', // Type 'T' for text
        TypeNameFormat.nfcWellKnown, // Use appropriate type name format
      );

      // debugger();

      // Convert NDEFRawRecord to ndef.NDEFRecord
      final ndefRecord = NDEFRecordConvert.fromRaw(record);

      // Write NDEF record to NFC tag
      await FlutterNfcKit.writeNDEFRecords([ndefRecord]);

      // End NFC session
      await FlutterNfcKit.finish();
      return ndefRecord;
    } catch (e) {
      // debugger();
      MyToast('Failed to write data to NFC: $e', Type: false);
      return null;
    }
  }

  Future<Map<String, dynamic>?> readDataFromNfc() async {
    try {
      // Start NFC session
      await FlutterNfcKit.poll();

      // Read NDEF records
      final records = await FlutterNfcKit.readNDEFRecords();

      if (records.isNotEmpty) {
        final payload = records.first.payload;
        if (payload != null && payload.isNotEmpty) {
          final encryptedData = utf8.decode(payload); // Ensure proper decoding
          return await nfcRead(encryptedData);
        } else {
          MyToast('No data found on the NFC tag.', Type: false);
          return null;
        }
      } else {
        MyToast('NFC tag does not contain NDEF records.', Type: false);
        return null;
      }
    } catch (e) {
      MyToast('Failed to read data from NFC: $e', Type: false);
      return null;
    }
  }
}
