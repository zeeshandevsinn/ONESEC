import 'package:client_nfc_mobile_app/screens/charts/bar_chart.dart';
import 'package:client_nfc_mobile_app/screens/charts/line_chart.dart';
import 'package:client_nfc_mobile_app/screens/charts/sf_maps.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';

class CompanyAnalyticsPage extends StatefulWidget {
  final auth_token;
  const CompanyAnalyticsPage({super.key, required this.auth_token});

  @override
  State<CompanyAnalyticsPage> createState() => _CompanyAnalyticsPageState();
}

class _CompanyAnalyticsPageState extends State<CompanyAnalyticsPage> {
  String? _selectedValue;
  final List<String> _options = [
    "Distributed",
    "Not Distributed",
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
                Container(
                  height: 410,
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
                            "Card Distribution Chart",
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
                            value: _selectedValue,
                            hint: Text("Distributed"),
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
                                )),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedValue = newValue;
                              });
                            },
                            items: _options.map<DropdownMenuItem<String>>(
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
                        InteractionFrequencyChart()
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  height: 330,
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
                            "Engagement Metrics Chart",
                            style: TextStyle(
                              fontFamily: "GothamBold",
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textColor14,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        PeakInteractionChart(
                          timeScale: "Weekly",
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                SFMAPScreen(
                  auth_token: widget.auth_token,
                ),
                // Container(
                //   height: 300,
                //   decoration: BoxDecoration(
                //     color: AppColors.containerColor8,
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: Padding(
                //     padding: EdgeInsets.all(12),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(left: 12.0, right: 12),
                //           child: Text(
                //             "Department Comparison Chart",
                //             style: TextStyle(
                //               fontFamily: "GothamBold",
                //               fontSize: 17.0,
                //               fontWeight: FontWeight.w700,
                //               color: AppColors.textColor14,
                //             ),
                //           ),
                //         ),
                //         SizedBox(height: 24),
                //         Padding(
                //           padding: const EdgeInsets.only(left: 12.0, right: 12),
                //           child: Image.asset(
                //             "assets/images/line_graph.png",
                //             height: 220,
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                SizedBox(height: 24),
                // Container(
                //   height: 410,
                //   decoration: BoxDecoration(
                //     color: AppColors.containerColor8,
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: Padding(
                //     padding: EdgeInsets.all(12),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(left: 12.0, right: 12),
                //           child: Text(
                //             "Networking Effectiveness Stats",
                //             style: TextStyle(
                //               fontFamily: "GothamBold",
                //               fontSize: 17.0,
                //               fontWeight: FontWeight.w700,
                //               color: AppColors.textColor14,
                //             ),
                //           ),
                //         ),
                //         SizedBox(height: 24),
                //         Padding(
                //           padding: EdgeInsets.only(left: 12, right: 12),
                //           child: Column(
                //             children: [
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Container(
                //                     width: 60.14,
                //                     height: 53,
                //                     decoration: BoxDecoration(
                //                       image: DecorationImage(
                //                         image: AssetImage(
                //                           "assets/images/profile7.png",
                //                         ),
                //                         fit: BoxFit.fitWidth,
                //                       ),
                //                       borderRadius: BorderRadius.circular(14),
                //                       boxShadow: [
                //                         BoxShadow(
                //                           color:
                //                               Color(0XFFB5B5BE).withOpacity(.2),
                //                           blurRadius: 5,
                //                           spreadRadius: 0,
                //                           offset: Offset(0, 2),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   SizedBox(width: 17),
                //                   Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Padding(
                //                         padding: EdgeInsets.only(top: 12),
                //                         child: Text(
                //                           "Lily Saunders",
                //                           style: TextStyle(
                //                             fontFamily: "GothamBold",
                //                             fontSize: 14.0,
                //                             fontWeight: FontWeight.w700,
                //                             color: AppColors.textColor21,
                //                           ),
                //                         ),
                //                       ),
                //                       SizedBox(height: 4),
                //                       Row(
                //                         children: [
                //                           Text(
                //                             "ID #3124",
                //                             style: TextStyle(
                //                               fontFamily: "GothamRegular",
                //                               fontSize: 12.0,
                //                               fontWeight: FontWeight.w400,
                //                               color: AppColors.textColor22,
                //                             ),
                //                           ),
                //                           SizedBox(width: 6),
                //                           Text(
                //                             "-",
                //                             style: TextStyle(
                //                               color: Color(0XFFD8D8D8),
                //                             ),
                //                           ),
                //                           SizedBox(width: 6),
                //                           Text(
                //                             "Paid",
                //                             style: TextStyle(
                //                               fontFamily: "GothamRegular",
                //                               fontSize: 12.0,
                //                               fontWeight: FontWeight.w400,
                //                               color: Color(0xFF3DD598),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                   Spacer(),
                //                   Padding(
                //                     padding: const EdgeInsets.only(top: 12.0),
                //                     child: Image.asset(
                //                       "assets/images/line.png",
                //                       width: 58,
                //                       height: 35,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               SizedBox(height: 10),
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Container(
                //                     width: 60.14,
                //                     height: 53,
                //                     decoration: BoxDecoration(
                //                       image: DecorationImage(
                //                         image: AssetImage(
                //                           "assets/images/profile8.png",
                //                         ),
                //                         fit: BoxFit.fitWidth,
                //                       ),
                //                       borderRadius: BorderRadius.circular(14),
                //                       boxShadow: [
                //                         BoxShadow(
                //                           color:
                //                               Color(0XFFB5B5BE).withOpacity(.2),
                //                           blurRadius: 5,
                //                           spreadRadius: 0,
                //                           offset: Offset(0, 2),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   SizedBox(width: 17),
                //                   Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Padding(
                //                         padding: EdgeInsets.only(top: 12),
                //                         child: Text(
                //                           "Franklin Jackson",
                //                           style: TextStyle(
                //                             fontFamily: "GothamBold",
                //                             fontSize: 14.0,
                //                             fontWeight: FontWeight.w700,
                //                             color: AppColors.textColor21,
                //                           ),
                //                         ),
                //                       ),
                //                       SizedBox(height: 4),
                //                       Row(
                //                         children: [
                //                           Text(
                //                             "ID #3124",
                //                             style: TextStyle(
                //                               fontFamily: "GothamRegular",
                //                               fontSize: 12.0,
                //                               fontWeight: FontWeight.w400,
                //                               color: AppColors.textColor22,
                //                             ),
                //                           ),
                //                           SizedBox(width: 6),
                //                           Text(
                //                             "-",
                //                             style: TextStyle(
                //                               color: Color(0XFFD8D8D8),
                //                             ),
                //                           ),
                //                           SizedBox(width: 6),
                //                           Text(
                //                             "Paid",
                //                             style: TextStyle(
                //                               fontFamily: "GothamRegular",
                //                               fontSize: 12.0,
                //                               fontWeight: FontWeight.w400,
                //                               color: Color(0xFF3DD598),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                   Spacer(),
                //                   Padding(
                //                     padding: const EdgeInsets.only(top: 12.0),
                //                     child: Image.asset(
                //                       "assets/images/line.png",
                //                       width: 58,
                //                       height: 35,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               SizedBox(height: 10),
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Container(
                //                     width: 60.14,
                //                     height: 53,
                //                     decoration: BoxDecoration(
                //                       image: DecorationImage(
                //                         image: AssetImage(
                //                           "assets/images/profile9.png",
                //                         ),
                //                         fit: BoxFit.fitWidth,
                //                       ),
                //                       borderRadius: BorderRadius.circular(14),
                //                       boxShadow: [
                //                         BoxShadow(
                //                           color:
                //                               Color(0XFFB5B5BE).withOpacity(.2),
                //                           blurRadius: 5,
                //                           spreadRadius: 0,
                //                           offset: Offset(0, 2),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   SizedBox(width: 17),
                //                   Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Padding(
                //                         padding: EdgeInsets.only(top: 12),
                //                         child: Text(
                //                           "Kyle Duncan",
                //                           style: TextStyle(
                //                             fontFamily: "GothamBold",
                //                             fontSize: 14.0,
                //                             fontWeight: FontWeight.w700,
                //                             color: AppColors.textColor21,
                //                           ),
                //                         ),
                //                       ),
                //                       SizedBox(height: 4),
                //                       Row(
                //                         children: [
                //                           Text(
                //                             "ID #3124",
                //                             style: TextStyle(
                //                               fontFamily: "GothamRegular",
                //                               fontSize: 12.0,
                //                               fontWeight: FontWeight.w400,
                //                               color: AppColors.textColor22,
                //                             ),
                //                           ),
                //                           SizedBox(width: 6),
                //                           Text(
                //                             "-",
                //                             style: TextStyle(
                //                               color: Color(0XFFD8D8D8),
                //                             ),
                //                           ),
                //                           SizedBox(width: 6),
                //                           Text(
                //                             "Pending",
                //                             style: TextStyle(
                //                               fontFamily: "GothamRegular",
                //                               fontSize: 12.0,
                //                               fontWeight: FontWeight.w400,
                //                               color: Color(0xFFFC5A5A),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                   Spacer(),
                //                   Padding(
                //                     padding: const EdgeInsets.only(top: 12.0),
                //                     child: Image.asset(
                //                       "assets/images/line2.png",
                //                       width: 58,
                //                       height: 35,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               SizedBox(height: 10),
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Container(
                //                     width: 60.14,
                //                     height: 53,
                //                     decoration: BoxDecoration(
                //                       image: DecorationImage(
                //                         image: AssetImage(
                //                           "assets/images/profile8.png",
                //                         ),
                //                         fit: BoxFit.fitWidth,
                //                       ),
                //                       borderRadius: BorderRadius.circular(14),
                //                       boxShadow: [
                //                         BoxShadow(
                //                           color:
                //                               Color(0XFFB5B5BE).withOpacity(.2),
                //                           blurRadius: 5,
                //                           spreadRadius: 0,
                //                           offset: Offset(0, 2),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   SizedBox(width: 17),
                //                   Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Padding(
                //                         padding: EdgeInsets.only(top: 12),
                //                         child: Text(
                //                           "Alta Chandler",
                //                           style: TextStyle(
                //                             fontFamily: "GothamBold",
                //                             fontSize: 14.0,
                //                             fontWeight: FontWeight.w700,
                //                             color: AppColors.textColor21,
                //                           ),
                //                         ),
                //                       ),
                //                       SizedBox(height: 4),
                //                       Row(
                //                         children: [
                //                           Text(
                //                             "ID #3124",
                //                             style: TextStyle(
                //                               fontFamily: "GothamRegular",
                //                               fontSize: 12.0,
                //                               fontWeight: FontWeight.w400,
                //                               color: AppColors.textColor22,
                //                             ),
                //                           ),
                //                           SizedBox(width: 6),
                //                           Text(
                //                             "-",
                //                             style: TextStyle(
                //                               color: Color(0XFFD8D8D8),
                //                             ),
                //                           ),
                //                           SizedBox(width: 6),
                //                           Text(
                //                             "Pending",
                //                             style: TextStyle(
                //                               fontFamily: "GothamRegular",
                //                               fontSize: 12.0,
                //                               fontWeight: FontWeight.w400,
                //                               color: Color(0xFFFC5A5A),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                   Spacer(),
                //                   Padding(
                //                     padding: const EdgeInsets.only(top: 12.0),
                //                     child: Image.asset(
                //                       "assets/images/line2.png",
                //                       width: 58,
                //                       height: 35,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               SizedBox(height: 10),
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Container(
                //                     width: 60.14,
                //                     height: 53,
                //                     decoration: BoxDecoration(
                //                       image: DecorationImage(
                //                         image: AssetImage(
                //                           "assets/images/profile11.png",
                //                         ),
                //                         fit: BoxFit.fitWidth,
                //                       ),
                //                       borderRadius: BorderRadius.circular(14),
                //                       boxShadow: [
                //                         BoxShadow(
                //                           color:
                //                               Color(0XFFB5B5BE).withOpacity(.2),
                //                           blurRadius: 5,
                //                           spreadRadius: 0,
                //                           offset: Offset(0, 2),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   SizedBox(width: 17),
                //                   Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Padding(
                //                         padding: EdgeInsets.only(top: 12),
                //                         child: Text(
                //                           "Anthony Hubbard",
                //                           style: TextStyle(
                //                             fontFamily: "GothamBold",
                //                             fontSize: 14.0,
                //                             fontWeight: FontWeight.w700,
                //                             color: AppColors.textColor21,
                //                           ),
                //                         ),
                //                       ),
                //                       SizedBox(height: 4),
                //                       Row(
                //                         children: [
                //                           Text(
                //                             "ID #3124",
                //                             style: TextStyle(
                //                               fontFamily: "GothamRegular",
                //                               fontSize: 12.0,
                //                               fontWeight: FontWeight.w400,
                //                               color: AppColors.textColor22,
                //                             ),
                //                           ),
                //                           SizedBox(width: 6),
                //                           Text(
                //                             "-",
                //                             style: TextStyle(
                //                               color: Color(0XFFD8D8D8),
                //                             ),
                //                           ),
                //                           SizedBox(width: 6),
                //                           Text(
                //                             "Paid",
                //                             style: TextStyle(
                //                               fontFamily: "GothamRegular",
                //                               fontSize: 12.0,
                //                               fontWeight: FontWeight.w400,
                //                               color: Color(0xFF3DD598),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                   Spacer(),
                //                   Padding(
                //                     padding: const EdgeInsets.only(top: 12.0),
                //                     child: Image.asset(
                //                       "assets/images/line.png",
                //                       width: 58,
                //                       height: 35,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
