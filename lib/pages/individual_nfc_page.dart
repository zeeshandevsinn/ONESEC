import 'package:client_nfc_mobile_app/components/custom_dialog_box.dart';
import 'package:client_nfc_mobile_app/controller/NFC/nfc_provider/nfc_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/share_profile_provider/share_profile_provider.dart';
import 'package:client_nfc_mobile_app/utils/loading_circle.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';

class IndividualNFCPage extends StatefulWidget {
  final String authToken;
  final Map<String, dynamic> profileDetails;

  const IndividualNFCPage(
      {Key? key, required this.authToken, required this.profileDetails})
      : super(key: key);

  @override
  State<IndividualNFCPage> createState() => _IndividualNFCPageState();
}

class _IndividualNFCPageState extends State<IndividualNFCPage> {
  String? profileUrl;

  @override
  void initState() {
    super.initState();
    _fetchProfileUrl(widget.authToken);
  }

  Future<void> _fetchProfileUrl(String auth) async {
    try {
      var pro = context.read<ShareProfileProvider>();
      final url = await pro.ShareProfileURL(auth);
      if(mounted)
      {setState(() {
        profileUrl = url;
      });}
    } catch (e) {
      MyToast(e.toString(), Type: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NFCNotifier>(builder: (context, nfc, child) {
      return Scaffold(
        body: nfc.isProcessing
            ? Center(child: LoadingCircle())
            : SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "NFC Card Management",
                          style: TextStyle(
                            fontFamily: "GothamBold",
                            fontSize: 26.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor14,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: 398,
                          height: 240,
                          decoration: BoxDecoration(
                            color: AppColors.containerColor8,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 23, top: 23.0),
                                child: Text(
                                  "Instructions",
                                  style: TextStyle(
                                    fontFamily: "GothamBold",
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textColor14,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InstructionRow(
                                            text:
                                                "Contrary to popular belief."),
                                        const SizedBox(height: 12),
                                        InstructionRow(
                                            text:
                                                "Lorem Contrary to popular belief."),
                                        const SizedBox(height: 12),
                                        InstructionRow(
                                            text:
                                                "Popular contrary to popular."),
                                        const SizedBox(height: 12),
                                        InstructionRow(
                                            text:
                                                "Lorem Contrary to popular belief."),
                                        const SizedBox(height: 12),
                                        InstructionRow(
                                            text:
                                                "Contrary to popular belief."),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Image.asset(
                                    "assets/images/couple.png",
                                    width: 80,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await nfc.startNFCOperation(
                                    nfcOperation: NFCOperation.read);
                              },
                              child: OperationButton(text: "Read Card"),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () async {
                                bool? result = await showDialog(
                                  context: context,
                                  builder: (context) => const CustomDialogBox(),
                                );
                                if (result == true && profileUrl != null) {
                                  await nfc.startNFCOperation(
                                    nfcOperation: NFCOperation.write,
                                    dataType: "URL",
                                    url: profileUrl!,
                                  );
                                }
                              },
                              child: OperationButton(text: "Write Profile"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }
}

class InstructionRow extends StatelessWidget {
  final String text;
  const InstructionRow({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: AppColors.containerColor13,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontFamily: "GothamRegular",
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor18,
          ),
        ),
      ],
    );
  }
}

class OperationButton extends StatelessWidget {
  final String text;
  const OperationButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: "GothamRegular",
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor24,
          ),
        ),
      ),
    );
  }
}
