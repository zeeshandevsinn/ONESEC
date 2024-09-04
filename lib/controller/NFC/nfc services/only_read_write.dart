import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:flutter/material.dart';
import 'package:ndef/ndef.dart';

class NFCReadWrite {
  /// Method to perform NFC operation based on the provided profile data
  static Future<void> performNfcOperation(
      Map<String, dynamic> profileData) async {
    try {
      // Check NFC availability
      // debugger();
      final nfcAvailability = await FlutterNfcKit.nfcAvailability;

      if (nfcAvailability == NFCAvailability.available) {
        // NFC is available, continue with NFC operations
        await _attemptWriteDataToNfc(profileData, retries: 3);
      } else {
        _showToast('NFC is not available on this device.');
      }
    } catch (e) {
      _showToast('Error checking NFC availability: $e');
    }
  }

  /// Method to attempt writing data to an NFC tag with retry logic
  static Future<void> _attemptWriteDataToNfc(Map<String, dynamic> profileData,
      {int retries = 3}) async {
    for (int attempt = 0; attempt < retries; attempt++) {
      try {
        var pollResult =
            await FlutterNfcKit.poll(timeout: Duration(seconds: 60));

        if (pollResult == null) {
          _showToast('No NFC tag detected.');
          return;
        }

        final ndefRecord = NDEFRecord(
          tnf: TypeNameFormat.nfcWellKnown,
          type: utf8.encode('T'),
          payload: utf8.encode(jsonEncode(profileData)),
        );
        // debugger();
        await FlutterNfcKit.writeNDEFRecords([ndefRecord]);
        await FlutterNfcKit.finish();
        _showToast('Data written successfully!');
        return; // Exit the function if successful
      } catch (e) {
        if (e is PlatformException && e.code == '408') {
          _showToast(
              'Polling tag timeout. Retrying... (${attempt + 1}/$retries)');
        } else {
          _showToast('Failed to write data to NFC: $e');
          return;
        }
      }
    }
    _showToast(
        'Failed to write data after $retries attempts. Please try again.');
  }

  /// Method to read data from an NFC tag
  static readDataFromNfc() async {
    try {
      var pollResult = await FlutterNfcKit.poll(timeout: Duration(seconds: 60));

      if (pollResult == null) {
        _showToast('No NFC tag detected.');
        return;
      }

      final records = await FlutterNfcKit.readNDEFRecords();

      if (records.isEmpty) {
        _showToast('No NDEF records found.');
        return null;
      }

      // Assuming that the payload is in JSON format
      final payload = utf8.decode(records[0].payload!);
      final data = jsonDecode(payload);

      _showToast('Data read successfully: $data');
      await FlutterNfcKit.finish();
      return data;
    } catch (e) {
      if (e is PlatformException && e.code == '408') {
        _showToast('Polling tag timeout.');
      } else {
        _showToast('Failed to read data from NFC: $e');
        return null;
      }
    }
  }

  /// Method to show toast or notification
  static void _showToast(String message) {
    print(
        message); // Replace with your actual toast or notification implementation
  }
}
