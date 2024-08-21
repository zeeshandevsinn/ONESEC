import 'package:client_nfc_mobile_app/controller/services/appointment/appoinment_provider.dart';
import 'package:client_nfc_mobile_app/models/appointments/appointment_model.dart';
import 'package:client_nfc_mobile_app/screens/share_profile_screen/received_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/data/appointments_items.dart';
import 'package:client_nfc_mobile_app/pages/appointment_schedule.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class CompanyAppointmentPage extends StatefulWidget {
  final auth_token;
  final userDetails;
  const CompanyAppointmentPage(
      {super.key, required this.auth_token, required this.userDetails});

  @override
  State<CompanyAppointmentPage> createState() => _CompanyAppointmentPageState();
}

class _CompanyAppointmentPageState extends State<CompanyAppointmentPage> {
  late Future<List<dynamic>> _getAppointments;

  Future<List<dynamic>> _fetchReceivedAppointments() async {
    var pro = context.read<AppointmentProvider>();
    final response = await pro.getUpcomingAppointment(widget.auth_token);

    if (response is Map<String, dynamic>) {
      // Assuming the list of appointments is inside the 'appointments' key
      if (response.containsKey('results')) {
        return response['results'] as List<dynamic>;
      } else {
        return [];
      }
    } else if (response is List) {
      return response;
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _getAppointments = _fetchReceivedAppointments();
  }

  var myAppointments = AppointmentsItems();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        child: Text(
                          "Company Appointments",
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: "GothamBold",
                            fontSize: 28.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor14,
                          ),
                        ),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //         context,
                    //         CupertinoDialogRoute(
                    //             builder: (_) => ReceivedProfileScreen(
                    //                 auth_token: widget.auth_token,
                    //                 userDetails: widget.userDetails),
                    //             context: context));
                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(
                    //     //     builder: (context) => ScheduleAppointment(),
                    //     //   ),
                    //     // );
                    //   },
                    //   icon: Icon(
                    //     Icons.add_circle_outline_outlined,
                    //     size: 30,
                    //     color: Color(0xFF3C4B4B),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 24),
                // TextField(
                //   style: TextStyle(
                //     fontFamily: "GothamRegular",
                //     fontSize: 15.0,
                //     fontWeight: FontWeight.w400,
                //     color: AppColors.textColor18,
                //   ),
                //   keyboardType: TextInputType.name,
                //   cursorColor: AppColors.textColor18,
                //   decoration: InputDecoration(
                //     hintText: "Search User",
                //     hintStyle: TextStyle(
                //       fontFamily: "GothamRegular",
                //       fontSize: 14.0,
                //       fontWeight: FontWeight.w400,
                //       color: AppColors.textColor12,
                //     ),
                //     suffixIcon: Icon(
                //       Icons.search,
                //       size: 24,
                //       color: Color(0XFF667085),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(9),
                //       borderSide:
                //           BorderSide(width: 1, color: AppColors.textColor16),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(9),
                //       borderSide:
                //           BorderSide(width: 1, color: AppColors.textColor16),
                //     ),
                //     fillColor: AppColors.containerColor8,
                //     filled: true,
                //   ),
                // ),
                // SizedBox(height: 24),

                Container(
                  height: MediaQuery.of(context).size.height * .80,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Expanded(
                          child: FutureBuilder<List<dynamic>>(
                            future: _getAppointments,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (snapshot.hasData) {
                                final appointments = snapshot.data!;
                                if (appointments.isEmpty) {
                                  return Center(
                                      child: Text(
                                    'No appointments available.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "GothamBold",
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textColor14,
                                    ),
                                  ));
                                } else {
                                  return ListView.builder(
                                    itemCount: appointments.length,
                                    itemBuilder: (context, index) {
                                      Appointments data = Appointments.fromJson(
                                          appointments[index]);
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 150,
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16),
                                          margin: EdgeInsets.only(
                                            bottom: 20,
                                          ),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: AppColors.containerColor3,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                    child: Image.asset(
                                                      'assets/images/logo.png',
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .60,
                                                    child: Text(
                                                      data.title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "GothamRegular",
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .textColor14,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    data.datetime.toString(),
                                                    style: TextStyle(
                                                      fontFamily: "GothamBold",
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .60,
                                                    child: Text(
                                                      data.attendeeEmail,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "GothamBold",
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 10,
                                                        height: 12,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              data.meetingStatus ==
                                                                      "pending"
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        data.meetingStatus,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "GothamRegular",
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0XFF44444F),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [],
                                              )
                                            ],
                                          ),
                                        ),
                                      );

                                      // Your ListTile or custom widget code here
                                    },
                                  );
                                }
                              } else {
                                return Center(
                                    child: Text(
                                  'No Appointments Found!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "GothamBold",
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor14,
                                  ),
                                ));
                              }
                            },
                          ),
                        ),

                        // Expanded(
                        //   child: ListView.builder(
                        //     itemCount: 12,
                        //     scrollDirection: Axis.vertical,
                        //     shrinkWrap: true,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       return
                        //       Container(
                        //         height: 80,
                        //         padding: EdgeInsets.only(left: 16, right: 16),
                        //         margin: EdgeInsets.only(
                        //           bottom: 20,
                        //         ),
                        //         width: MediaQuery.of(context).size.width,
                        //         decoration: BoxDecoration(
                        //           color: AppColors.containerColor3,
                        //           borderRadius: BorderRadius.circular(16),
                        //         ),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             ClipRRect(
                        //               borderRadius: BorderRadius.circular(60),
                        //               child: Image.asset(
                        //                 myAppointments
                        //                     .scheduleAppointments[index].image,
                        //                 width: 60,
                        //                 height: 60,
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //             Column(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               children: [
                        //                 Text(
                        //                   myAppointments
                        //                       .scheduleAppointments[index]
                        //                       .title,
                        //                   style: TextStyle(
                        //                     fontFamily: "GothamRegular",
                        //                     fontSize: 16.0,
                        //                     fontWeight: FontWeight.w400,
                        //                     color: AppColors.textColor14,
                        //                   ),
                        //                 ),
                        //                 Text(
                        //                   myAppointments
                        //                       .scheduleAppointments[index].time,
                        //                   style: TextStyle(
                        //                     fontFamily: "GothamBold",
                        //                     fontSize: 14.0,
                        //                     fontWeight: FontWeight.w700,
                        //                     color: Colors.black,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //             Row(
                        //               children: [
                        //                 Container(
                        //                   height: 34,
                        //                   width: 34,
                        //                   padding: EdgeInsets.all(6),
                        //                   decoration: BoxDecoration(
                        //                     color: AppColors.containerColor6,
                        //                     shape: BoxShape.circle,
                        //                   ),
                        //                   child: Center(
                        //                     child: GestureDetector(
                        //                       onTap: () {
                        //                         print("edit appointment");
                        //                       },
                        //                       child: Icon(
                        //                         Icons.edit,
                        //                         color:
                        //                             AppColors.containerColor8,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 SizedBox(width: 10),
                        //                 Container(
                        //                   height: 34,
                        //                   width: 34,
                        //                   padding: EdgeInsets.all(6),
                        //                   decoration: BoxDecoration(
                        //                     color: AppColors.containerColor7,
                        //                     shape: BoxShape.circle,
                        //                   ),
                        //                   child: Center(
                        //                     child: GestureDetector(
                        //                       onTap: () {
                        //                         print("delete appointment");
                        //                       },
                        //                       child: Icon(
                        //                         Icons.delete_outline,
                        //                         color:
                        //                             AppColors.containerColor8,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             )
                        //           ],
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
