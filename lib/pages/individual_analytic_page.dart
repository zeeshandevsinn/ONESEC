import 'package:client_nfc_mobile_app/screens/charts/bar_chart.dart';
import 'package:client_nfc_mobile_app/screens/charts/interaction_chart.dart';
import 'package:client_nfc_mobile_app/screens/charts/line_chart.dart';
import 'package:client_nfc_mobile_app/screens/charts/sf_maps.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';

class IndividualAnalyticPage extends StatefulWidget {
  final auth_token;
  const IndividualAnalyticPage({super.key, required this.auth_token});

  @override
  State<IndividualAnalyticPage> createState() => _IndividualAnalyticPageState();
}

class _IndividualAnalyticPageState extends State<IndividualAnalyticPage> {
  String _selectedValue = "Daily";
  final List<String> _options = [
    "Daily",
    "Weekly",
    "Monthly",
    // "Yearly",
  ];

  String _selectedValue2 = "Weekly";
  final List<String> _options2 = [
    "Time of Days",
    "Time of Week",
    "Time of Months",
    "Time of Years",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Analytics",
                  style: TextStyle(
                    fontFamily: "GothamBold",
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor14,
                  ),
                ),
                SizedBox(height: 24),
                InteractionChartWidget(auth_token: widget.auth_token),
                SizedBox(height: 24),
                SFMAPScreen(auth_token: widget.auth_token),
                SizedBox(height: 24),
                    ],
            ),
          ),
        ),
      ),
   
    );
  }

  Widget _buildChartContainer({
    required String title,
    required String hint,
    required String? selectedValue,
    required List<String> options,
    required void Function(String?) onChanged,
    required Widget chart,
  }) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        color: AppColors.containerColor8,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: "GothamBold",
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor14,
                ),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
                value: selectedValue,
                hint: Text(hint),
                style: TextStyle(
                  fontFamily: "GothamRegular",
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor12,
                ),
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 30,
                  color: AppColors.textColor10,
                ),
                iconSize: 24,
                decoration: InputDecoration(
                  fillColor: AppColors.containerColor8,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColors.textColor16,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: AppColors.textColor16,
                    ),
                  ),
                ),
                onChanged: onChanged,
                items: options.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
            SizedBox(height: 24),
            Expanded(child: chart),
          ],
        ),
      ),
    );
  }
}
