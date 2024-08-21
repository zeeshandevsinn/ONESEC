import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/components/custom_calendar.dart';
import 'package:client_nfc_mobile_app/data/upcoming_appointment_items.dart';
import 'package:client_nfc_mobile_app/pages/appointment_details.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';

class ViewAppointments extends StatefulWidget {
  const ViewAppointments({super.key});

  @override
  State<ViewAppointments> createState() => _ViewAppointmentsState();
}

class _ViewAppointmentsState extends State<ViewAppointments> {
  var schedule = UpcomingAppointmentsItems();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.backgroundColor1),
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
                    Text(
                      "Appointments",
                      style: TextStyle(
                        fontFamily: "GothamBold",
                        fontSize: 28.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textColor14,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle_outline_outlined,
                        size: 30,
                        color: Color(0xFF3C4B4B),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Container(
                  height: 360,
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
                        CustomCalender(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  height: 345,
                  width: 398,
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Row(
                            children: [
                              Text(
                                "Appointments",
                                style: TextStyle(
                                  fontFamily: "GothamBold",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textColor14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AppointmentsDetails(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 80,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  margin: EdgeInsets.only(
                                    bottom: 20,
                                    left: 16,
                                    right: 12,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: AppColors.containerColor3,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child: Image.asset(
                                            schedule.appointments[index].image,
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    schedule.appointments[index]
                                                        .title,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "GothamRegular",
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColors.textColor14,
                                                    ),
                                                  ),
                                                  Text(
                                                    schedule.appointments[index]
                                                        .time,
                                                    style: TextStyle(
                                                      fontFamily: "GothamBold",
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    schedule.appointments[index]
                                                        .subtitle,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "GothamRegular",
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColors.textColor15,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .check_circle_outline_outlined,
                                                        color: AppColors
                                                            .switchColor,
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        "Finished",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "GothamRegular",
                                                          fontSize: 13.0,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColors
                                                              .textColor15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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
