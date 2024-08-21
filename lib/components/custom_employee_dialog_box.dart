import 'package:flutter/material.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';

class EmployeeDialogBox extends StatelessWidget {
  final employee;
  const EmployeeDialogBox({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final fullName = '${employee['first_name']} ${employee['last_name']}';
    final position = employee['position'];
    final profilePic = employee['profile_pic'];
    final email = employee['email'];
    final phone = employee['phone'];
    final bio = employee['bio'];

    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.containerColor8,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30,
                    color: AppColors.textColor15,
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: profilePic != null
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/images/logo.png',
                      image: profilePic,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons
                              .error, // Show an error icon if the image fails to load
                          color: Colors.red,
                        );
                      },
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    )
                  : CircleAvatar(
                      child: Icon(Icons
                          .person), // Default icon when profile_pic is null
                    ),
            ),
            SizedBox(height: 35),
            Text(
              fullName,
              style: TextStyle(
                fontFamily: "GothamBold",
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
                color: AppColors.textColor14,
              ),
            ),
            SizedBox(height: 16),
            Text(
              bio ?? "Hi. I am Peter Parker",
              style: TextStyle(
                fontFamily: "GothamRegular",
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor18,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding:
                  EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 40),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.containerColor4,
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                          fontFamily: "GothamRegular",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor17,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        email,
                        style: TextStyle(
                          fontFamily: "GothamRegular",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor18,
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Position",
                        style: TextStyle(
                          fontFamily: "GothamRegular",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor17,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        position,
                        style: TextStyle(
                          fontFamily: "GothamRegular",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor18,
                        ),
                      ),
                      SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Number",
                            style: TextStyle(
                              fontFamily: "GothamRegular",
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor17,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            phone ?? "+1 84900 94046",
                            style: TextStyle(
                              fontFamily: "GothamRegular",
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
