import 'dart:developer';

import 'package:client_nfc_mobile_app/company_admin_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/controller/endpoints.dart';
import 'package:client_nfc_mobile_app/individual_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:client_nfc_mobile_app/components/custom_schedule_dialog_box.dart';
import 'package:client_nfc_mobile_app/pages/appointments_view.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ScheduleAppointment extends StatefulWidget {
  final userID;
  final email;
  final User? userDetails;
  final token;
  const ScheduleAppointment(
      {super.key,
      required this.userID,
      required this.email,
      required this.userDetails,
      required this.token});

  @override
  State<ScheduleAppointment> createState() => _ScheduleAppointmentState();
}

class _ScheduleAppointmentState extends State<ScheduleAppointment> {
  bool value = true;
  onChangeFunction(bool newValue) {
    setState(() {
      value = newValue;
    });
  }

  TextEditingController _date = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  String? timeText;
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("hh:mm a");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor1,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Schedule Appointments",
                    style: TextStyle(
                      fontFamily: "GothamBold",
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor14,
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    height: 640,
                    width: 398,
                    decoration: BoxDecoration(
                      color: AppColors.containerColor8,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Schedule Appointment",
                            style: TextStyle(
                              fontFamily: "GothamBold",
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textColor12,
                            ),
                          ),
                          SizedBox(height: 24),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please Pick the Date";
                              }
                              return null;
                            },
                            controller: _date,
                            style: TextStyle(
                              fontFamily: "GothamRegular",
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor12,
                            ),
                            keyboardType: TextInputType.name,
                            cursorColor: AppColors.textColor12,
                            decoration: InputDecoration(
                              hintText: "Select Date",
                              hintStyle: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0XFFAEAEAE),
                              ),
                              prefixIcon: IconButton(
                                onPressed: () async {
                                  DateTime? datePicked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  );
                                  if (datePicked != null) {
                                    setState(
                                      () {
                                        _date.text = DateFormat("MM-dd-yyyy")
                                            .format(datePicked);

                                        print(_date.text);
                                      },
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.calendar_month,
                                  size: 30,
                                  color: AppColors.textColor16,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.textColor13,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.textColor13,
                                ),
                              ),
                              fillColor: AppColors.containerColor8,
                              filled: true,
                            ),
                          ),
                          SizedBox(height: 16),
                          DateTimeField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (val) {
                              if (val == null) {
                                return "Please Pick the Time";
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontFamily: "GothamRegular",
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor12,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.alarm,
                                size: 30,
                                color: AppColors.textColor16,
                              ),
                              hintText: "Select Time",
                              hintStyle: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0XFFAEAEAE),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.textColor13,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.textColor13,
                                ),
                              ),
                              fillColor: AppColors.containerColor8,
                              filled: true,
                            ),
                            format: format,
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                  currentValue ?? DateTime.now(),
                                ),
                              );
                              // print(TimeOfDay(
                              //     hour: time!.hour, minute: time.minute));
                              final timeData = DateTimeField.convert(time);
                              // print(timeData);
                              setState(() {
                                timeText = timeData.toString();
                              });

                              print(timeText);
                              return timeData;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _titleController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please type the Title";
                              }
                              return null;
                            },
                            style: TextStyle(
                              fontFamily: "GothamRegular",
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor12,
                            ),
                            keyboardType: TextInputType.name,
                            cursorColor: AppColors.textColor12,
                            decoration: InputDecoration(
                              hintText: "Title",
                              hintStyle: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0XFFAEAEAE),
                              ),
                              prefixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.title,
                                  size: 30,
                                  color: AppColors.textColor16,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.textColor13,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.textColor13,
                                ),
                              ),
                              fillColor: AppColors.containerColor8,
                              filled: true,
                            ),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _descriptionController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please type description";
                              }
                              return null;
                            },
                            maxLines: 6,
                            style: TextStyle(
                              fontFamily: "GothamRegular",
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor12,
                            ),
                            keyboardType: TextInputType.name,
                            cursorColor: AppColors.textColor12,
                            decoration: InputDecoration(
                              hintText: "Description",
                              hintStyle: TextStyle(
                                fontFamily: "GothamRegular",
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0XFFAEAEAE),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.textColor13,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: AppColors.textColor13,
                                ),
                              ),
                              fillColor: AppColors.containerColor8,
                              filled: true,
                            ),
                          ),
                          // SizedBox(height: 16),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Google Meet",
                          //       style: TextStyle(
                          //         fontFamily: "GothamRegular",
                          //         fontSize: 14.0,
                          //         fontWeight: FontWeight.w400,
                          //         color: AppColors.textColor23,
                          //       ),
                          //     ),
                          //     Switch(
                          //       activeColor: AppColors.containerColor8,
                          //       activeTrackColor: AppColors.switchColor,
                          //       inactiveThumbColor: Colors.grey,
                          //       inactiveTrackColor: Colors.grey.withOpacity(.2),
                          //       value: value,
                          //       onChanged: (newValue) {
                          //         onChangeFunction(newValue);
                          //       },
                          //     ),
                          //   ],
                          // ),

                          SizedBox(height: 24),
                          GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                String date = _date.text; // MM-dd-yyyy format
                                String time = timeText!; // Time in ISO format

                                // Convert the date string to a DateTime object
                                // Manually reorder the date parts to fit yyyy-MM-dd
                                List<String> dateParts = date.split('-');
                                String formattedDate =
                                    "${dateParts[2]}-${dateParts[0].padLeft(2, '0')}-${dateParts[1].padLeft(2, '0')}";
                                DateTime parsedDate =
                                    DateTime.parse(formattedDate);

                                // Extract time from the time string
                                DateTime parsedTime = DateTime.parse(time);

                                // Merge date and time into a single DateTime object
                                DateTime combinedDateTime = DateTime(
                                  parsedDate.year,
                                  parsedDate.month,
                                  parsedDate.day,
                                  parsedTime.hour,
                                  parsedTime.minute,
                                  parsedTime.second,
                                  parsedTime.millisecond,
                                );

                                // Convert the combined DateTime to UTC and format it in ISO format
                                String utcIsoFormat =
                                    combinedDateTime.toUtc().toIso8601String();

                                print(utcIsoFormat);

                                showDialog(
                                  context: context,
                                  builder: (context) => CustomScheduleDialogBox(
                                    ontap: () {
                                      openAppointmentUrl(
                                          title: _titleController.text.trim(),
                                          description: _descriptionController
                                              .text
                                              .trim(),
                                          startDatetime: utcIsoFormat,
                                          userId: widget.userID,
                                          attendeeEmail: widget.email);
                                    },
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * .80,
                              height: 40,
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
                                  "Create Appointment",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          // Row(
                          //   children: [
                          //     SizedBox(width: 10),
                          //     GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => ViewAppointments(),
                          //           ),
                          //         );
                          //       },
                          //       child: Container(
                          //         width: 130,
                          //         height: 40,
                          //         decoration: BoxDecoration(
                          //           gradient: LinearGradient(
                          //             colors: [
                          //               AppColors.primaryColor,
                          //               AppColors.secondaryColor,
                          //             ],
                          //           ),
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //         child: Center(
                          //           child: Text(
                          //             "View",
                          //             textAlign: TextAlign.center,
                          //             style: TextStyle(
                          //               fontFamily: "GothamRegular",
                          //               fontSize: 16.0,
                          //               fontWeight: FontWeight.w400,
                          //               color: AppColors.textColor24,
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),

                          //   ],
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
      ),
    );
  }

  void openAppointmentUrl({
    required String title,
    required String description,
    required String startDatetime, // ISO Format UTC
    required int userId,
    required String attendeeEmail,
  }) async {
    final Uri uri = Uri.parse(
        //  "${EndPointsURLs.BASE_URL}google/auth-request/?title=$title&description=$description&start_datetime=$startDatetime&attendee_email=$attendeeEmail&user_id=$userId"
        '${EndPointsURLs.BASE_URL}google/auth-request/').replace(
      queryParameters: {
        'title': title,
        'description': description,
        'start_datetime': startDatetime,
        'user_id': userId.toString(), // Convert int to String
        'attendee_email': attendeeEmail,
      },
    );
    print(uri);
    // debugger();
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      if (widget.userDetails!.profileType == "company") {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoDialogRoute(
                builder: (_) => CompanyAdminBottomNavigationBar(
                    profileData: null,
                    authToken: widget.token,
                    userDetails: widget.userDetails),
                context: context),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoDialogRoute(
                builder: (_) => IndividualBottomNavigationBar(
                    user_auth_token: widget.token,
                    futureUser: widget.userDetails),
                context: context),
            (route) => false);
      }
    } else {
      MyToast('Could not launch $uri', Type: false);
    }
  }
}
