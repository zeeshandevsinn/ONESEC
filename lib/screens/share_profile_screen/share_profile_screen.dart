import 'dart:io';
import 'dart:ui';

import 'package:client_nfc_mobile_app/components/custom_text_field.dart';
import 'package:client_nfc_mobile_app/controller/services/share_profile_provider/share_profile_manager.dart';
import 'package:client_nfc_mobile_app/controller/services/share_profile_provider/share_profile_provider.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:client_nfc_mobile_app/utils/loading_circle.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Import the qr_flutter package

class ShareProfileScreen extends StatefulWidget {
  final String auth_token;

  const ShareProfileScreen({super.key, required this.auth_token});

  @override
  State<ShareProfileScreen> createState() => _ShareProfileScreenState();
}

class _ShareProfileScreenState extends State<ShareProfileScreen> {
  TextEditingController emailController = TextEditingController();
  String? profileUrl;

  @override
  void initState() {
    super.initState();
    context.read<ShareProfileProvider>();
    _fetchProfileUrl(widget.auth_token);
  }

  Future<void> _fetchProfileUrl(auth) async {
    try {
      var pro = context.read<ShareProfileProvider>();
      final url = await pro.ShareProfileURL(auth);
      if(mounted)
     { setState(() {
        profileUrl = url;
      });}
    } catch (e) {
      MyToast(e.toString(), Type: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        var pro = context.watch<ShareProfileProvider>();
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(34),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 113,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 13.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.containerColor1,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            /*

       Spacer(),
                            Row(
                              children: [
                                Text(
                                  "English (United States)",
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor7,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ],
                            ),
                                               */
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: GradientText(
                          "SHARE PROFILE!",
                          style: TextStyle(
                            fontFamily: "GothamBold",
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700,
                          ),
                          colors: [
                            AppColors.textColor1,
                            AppColors.textColor2,
                          ],
                        ),
                      ),
                      SizedBox(height: 17),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Text(
                          "WELCOME TO SHARE PROFILE SCREEN.YOU CAN SHARE YOUR PROFILE THROUGH EMAIL OR LINK.",
                          style: TextStyle(
                            fontFamily: "GothamRegular",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor8,
                          ),
                        ),
                      ),
                      SizedBox(height: 22),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              color: Colors.grey[200],
                              child: Row(
                                children: [
                                  Expanded(child: Text(profileUrl ?? "")),
                                  GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                          text: profileUrl ?? ""));
                                      MyToast("URL copied to Clipboard");
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          .20,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.primaryColor,
                                            AppColors.secondaryColor,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Copy",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 22),
                            // QR Code Section
                            if (profileUrl != null)
                              GestureDetector(
                                onTap: () {
                                  _shareQrCode(profileUrl!);
                                },
                                child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: QrImageView(
                                      data: profileUrl!,
                                      version: QrVersions.auto,
                                      size: 100.0,
                                    )),
                              ),
                            Row(
                              children: [
                                Expanded(
                                  child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 24.0, right: 12.0),
                                    child: Divider(
                                      thickness: 1,
                                      color: AppColors.containerColor9,
                                    ),
                                  ),
                                ),
                                Text(
                                  "or",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor10,
                                  ),
                                ),
                                Expanded(
                                  child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 12.0, right: 24.0),
                                    child: Divider(
                                      thickness: 1,
                                      color: AppColors.containerColor9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            CustomTextField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return null;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              hintText: "ex.email@domain.com",
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                size: 24,
                                color: AppColors.textColor10,
                              ),
                            ),
                            SizedBox(height: 20),
                            pro.isLoading
                                ? Center(
                                    child: LoadingCircle(),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      String email = emailController.text;
                                      if (email.isEmpty) {
                                        MyToast(
                                            "Please Make sure Field is not Empty",
                                            Type: false);
                                      } else {
                                        final data =
                                            await pro.ShareProfileThroughEmail(
                                                widget.auth_token, email);
                                        if (data != null) {
                                          emailController.text = "";
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 42,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.primaryColor,
                                            AppColors.secondaryColor,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "SHARE",
                                          style: TextStyle(
                                            fontFamily: "GothamRegular",
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _shareQrCode(String url) async {
    try {
      // Generate the QR code
      final qrCode = QrPainter(
        data: url,
        version: QrVersions.auto,
        gapless: false,
        color: Colors.black,
        emptyColor: Colors.white,
      );

      // Convert the QR code to image
      final qrImage = await qrCode.toImage(300);
      final qrByteData = await qrImage.toByteData(format: ImageByteFormat.png);
      final Uint8List qrPngBytes = qrByteData!.buffer.asUint8List();

      // Get the temporary directory to save the image
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/qr_code.png';

      // Save the image as a file
      final qrFile = File(imagePath);
      await qrFile.writeAsBytes(qrPngBytes);

      // Share the image file
      await Share.shareFiles([imagePath],
          text: 'Scan this QR code to visit the URL\n $url.');
    } catch (e) {
      print('Error: $e');
    }
  }
}
