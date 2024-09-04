import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:nfc_manager/nfc_manager.dart';

class TagsNFC {
  static startNFCReading() async {
    try {
      bool isAvailable = await NfcManager.instance.isAvailable();

      //We first check if NFC is available on the device.
      if (isAvailable) {
        //If NFC is available, start an NFC session and listen for NFC tags to be discovered.
        NfcManager.instance.startSession(
          onDiscovered: (NfcTag tag) async {
            // Process NFC tag, When an NFC tag is discovered, print its data to the console.
            MyToast('NFC Tag Detected: ${tag.data}');
          },
        );
      } else {
        MyToast('NFC not available.');
      }
    } catch (e) {
      MyToast('Error reading NFC: $e');
    }
  }

  static Future<void> startNFCWriting(Map<String, dynamic> data) async {
    try {
      // Check if NFC is available on the device
      bool isAvailable = await NfcManager.instance.isAvailable();

      if (isAvailable) {
        // debugger();
        // Start NFC session
        NfcManager.instance.startSession(
            invalidateAfterFirstRead: true,
            onDiscovered: (NfcTag badge) async {
              // debugger();
              try {
                var ndef = Ndef.from(badge);

                if (ndef != null && ndef.isWritable) {
                  NdefRecord ndefRecord = NdefRecord.createText("record");
                  NdefMessage message = NdefMessage([ndefRecord]);

                  try {
                    await ndef.write(message);
                  } catch (e) {
                    NfcManager.instance.stopSession(
                        errorMessage: "Error while writing to badge");
                  }
                }

                NfcManager.instance.stopSession();

                String jsonString = jsonEncode(data);
                Uint8List payload = Uint8List.fromList(utf8.encode(jsonString));
                NdefRecord ndefRecord =
                    NdefRecord.createMime('application/json', payload);
                NdefMessage ndefMessage = NdefMessage([ndefRecord]);

                // Write the NDEF message to the NFC tag if it supports NDEF
                // Ndef? ndef = Ndef.from(tag);
                // if (ndef != null) {
                //   debugger();
                //   await ndef.write(ndefMessage);
                //   MyToast('Data emitted successfully');
                // } else {
                //   debugger();
                //   MyToast('Tag does not support NDEF.');
                // }

                // Stop the NFC session
                NfcManager.instance.stopSession();
              } catch (e) {
                // debugger();
                MyToast('Error emitting NFC data: $e');
                NfcManager.instance.stopSession(errorMessage: e.toString());
              }
            },
            onError: (e) async {
              print(e);
              // debugger();
            });
      } else {
        MyToast('NFC not available.');
      }
    } catch (e) {
      MyToast('Error writing to NFC: $e');
    }
  }
}
