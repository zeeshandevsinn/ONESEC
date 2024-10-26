import 'package:client_nfc_mobile_app/controller/services/appointment/appoinment_provider.dart';
import 'package:client_nfc_mobile_app/models/appointments/appointment_model.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/data/appointments_items.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class IndividualAppointmentPage extends StatefulWidget {
  final String auth_token;
  final User? userDetails;
  const IndividualAppointmentPage(
      {super.key, required this.auth_token, required this.userDetails});

  @override
  State<IndividualAppointmentPage> createState() =>
      _IndividualAppointmentPageState();
}

class _IndividualAppointmentPageState extends State<IndividualAppointmentPage> {
  late Future<List<dynamic>> _getAppointments;

  @override
  void initState() {
    super.initState();
    _getAppointments =
        _fetchReceivedAppointments(); // Call the async function here
  }

  Future<List<dynamic>> _fetchReceivedAppointments() async {
    var pro = context.read<AppointmentProvider>();
    final response = await pro.getUpcomingAppointment(widget.auth_token);

    if (response is Map<String, dynamic> && response.containsKey('results')) {
      return response['results'] as List<dynamic>;
    } else if (response is List) {
      return response;
    }
    return []; // Return an empty list in case of any other response
  }

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
                // Your title and other widgets here
                Container(
                  height: MediaQuery.of(context).size.height * .8,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.containerColor8,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: FutureBuilder<List<dynamic>>(
                      future: _getAppointments, // Use the future directly
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
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
                        } else {
                          final appointments = snapshot.data!;
                          return ListView.builder(
                            itemCount: appointments.length,
                            itemBuilder: (context, index) {
                              Appointments data =
                                  Appointments.fromJson(appointments[index]);
                              // Build your appointment card here
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 150,
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  margin: EdgeInsets.only(
                                    bottom: 20,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: AppColors.containerColor3,
                                    borderRadius: BorderRadius.circular(16),
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
                                                BorderRadius.circular(60),
                                            child: Image.asset(
                                              'assets/images/logo.png',
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .60,
                                            child: Text(
                                              data.title,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: "GothamRegular",
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textColor14,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            data.datetime.toString(),
                                            style: TextStyle(
                                              fontFamily: "GothamBold",
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .60,
                                            child: Text(
                                              data.attendeeEmail,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontFamily: "GothamBold",
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 10,
                                                height: 12,
                                                decoration: BoxDecoration(
                                                  color: data.meetingStatus ==
                                                          "pending"
                                                      ? Colors.red
                                                      : Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                data.meetingStatus,
                                                style: TextStyle(
                                                  fontFamily: "GothamRegular",
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0XFF44444F),
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
                            },
                          );
                        }
                      },
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
