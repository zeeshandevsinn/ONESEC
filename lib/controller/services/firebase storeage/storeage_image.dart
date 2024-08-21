import 'dart:io';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

compressAndUploadImage(File imageFile) async {
  try {
    final tempDir = await getTemporaryDirectory();
    final targetPath =
        path.join(tempDir.path, "${DateTime.now().millisecondsSinceEpoch}.jpg");

    // Compress the image
    // var result = await FlutterImageCompress.compressAndGetFile(
    //   imageFile.absolute.path,
    //   targetPath,
    //   quality: 85,
    // );

    // if (result == null) {
    //   return null;
    // }

    // Upload the compressed image to Firebase Storage
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
        .ref()
        .child('uploads/${DateTime.now().millisecondsSinceEpoch}.jpg');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  } catch (e) {
    print(e.toString());
    return null;
  }
  // Get the directory to save the compressed image
}
