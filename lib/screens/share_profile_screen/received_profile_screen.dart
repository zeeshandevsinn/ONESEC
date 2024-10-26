import 'dart:developer';

import 'package:client_nfc_mobile_app/controller/services/share_profile_provider/share_profile_provider.dart';
import 'package:client_nfc_mobile_app/screens/share_profile_screen/appointment_share_profile.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:client_nfc_mobile_app/utils/loading_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceivedProfileScreen extends StatefulWidget {
  final String auth_token;
  final userDetails;
  const ReceivedProfileScreen(
      {super.key, required this.auth_token, required this.userDetails});

  @override
  State<ReceivedProfileScreen> createState() => _ReceivedProfileScreenState();
}

class _ReceivedProfileScreenState extends State<ReceivedProfileScreen> {
  late Future<List<dynamic>> _receivedProfilesFuture;

  Future<List<dynamic>> _fetchReceivedProfiles() async {
    var pro = context.read<ShareProfileProvider>();
    final data = await pro.ReceivedProfiles(widget.auth_token);

    if (data is List) {
      // If data is already a List, return it
      return data;
    } else if (data is Map<String, dynamic>) {
      // Handle the case where the API response is a Map and the list is within a key
      if (data.containsKey('results')) {
        return data['results'] as List<dynamic>;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _receivedProfilesFuture = _fetchReceivedProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Received Profiles",
                style: TextStyle(
                  fontFamily: "GothamBold",
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textColor14,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: _receivedProfilesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: LoadingCircle(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {
                      final profiles = snapshot.data!;
                      if (profiles.isEmpty) {
                        return Center(
                          child: Text(
                            'No Received Profiles',
                            style: TextStyle(
                              fontFamily: "GothamBold",
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor14,
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: profiles.length,
                          itemBuilder: (context, index) {
                            final profile = profiles[index];
                            print(profile);
                            // debugger();
                            final sharedDate =
                                DateTime.parse(profile['shared_at']).toLocal();
                            final profileType =
                                profile['profile_type_who_shared'];
                            final sharedFrom = profile['shared_from'];
                            final username = profile['shared_from_username'];
                            final user_email = profile['shared_from_email'];

                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              elevation: 5,
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Profile Type: $profileType',
                                      style: TextStyle(
                                        fontFamily: "GothamBold",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textColor14,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Shared Date: ${sharedDate.toLocal().toString()}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.textColor14,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'User Email: $user_email',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.textColor14,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Username: $username',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.textColor14,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            CupertinoDialogRoute(
                                                builder: (_) =>
                                                    AppoinmentShareProfileScreen(
                                                        username: username,
                                                        userDetails:
                                                            widget.userDetails,
                                                        auth_token:
                                                            widget.auth_token,
                                                        userID_share_from:
                                                            sharedFrom,
                                                        profile_type:
                                                            profileType),
                                                context: context));
                                        // Add your action here
                                      },
                                      child: Text('View Profile'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return Center(
                        child: Text('No data found'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
