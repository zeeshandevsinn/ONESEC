import 'dart:convert';
import 'dart:developer';

import 'package:client_nfc_mobile_app/company_admin_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/components/custom_text_field.dart';
import 'package:client_nfc_mobile_app/controller/services/company%20profile/company_profile_details.dart';
import 'package:client_nfc_mobile_app/controller/services/company_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/firebase%20storeage/storeage_image.dart';
import 'package:client_nfc_mobile_app/controller/services/user_profile_provider.dart';
import 'package:client_nfc_mobile_app/individual_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/models/company/company_user.dart';
import 'package:client_nfc_mobile_app/models/company/get_company_profile.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/models/user_profile/user_profile_details.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class CompanyUserCreateDetails extends StatefulWidget {
  final User? userDetails;
  final bool create;
  final CompanyProfile? profileDetails;
  final token;

  CompanyUserCreateDetails({
    super.key,
    required this.userDetails,
    required this.create,
    required this.token,
    this.profileDetails,
  });

  @override
  _CompanyUserCreateDetailsState createState() =>
      _CompanyUserCreateDetailsState();
}

class _CompanyUserCreateDetailsState extends State<CompanyUserCreateDetails> {
  File? _image;
  final picker = ImagePicker();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _adminNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _companyDescriptionController =
      TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();

  bool _isEmailLocked = false;
  String networkUserImage = '';

  void profileDetailCheck() {
    if (widget.profileDetails != null) {
      setState(() {
        _companyNameController.text = widget.profileDetails!.companyName;
        _adminNameController.text = widget.profileDetails!.adminName;
        _emailController.text = widget.profileDetails!.email;
        _isEmailLocked = _emailController.text.isNotEmpty;
        _phoneController.text = widget.profileDetails!.phone;
        _addressController.text = widget.profileDetails!.address;
        _companyDescriptionController.text =
            widget.profileDetails!.companyDescription ?? '';
        _websiteController.text = widget.profileDetails!.website ?? '';
        _linkedinController.text = widget.profileDetails!.linkedin ?? '';
        networkUserImage = widget.profileDetails!.companyLogo ?? '';
      });
    } else {
      setState(() {
        _companyNameController.text = widget.userDetails!.companyName;
        _adminNameController.text = widget.userDetails!.adminName;
        _emailController.text = widget.userDetails!.email;
        _isEmailLocked = _emailController.text.isNotEmpty;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<UserProfileProvider>();

    profileDetailCheck();
  }

  String? _downloadURL;
  bool? _isUploading;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        networkUserImage = '';
      } else {
        print('No image selected.');
      }
    });

    var downloadURL = await compressAndUploadImage(_image!);
    // debugger();
    if (downloadURL != null) {
      setState(() {
        _downloadURL = downloadURL;
        _isUploading = false;
      });
    }
  }

  final newKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        var pro = context.watch<CompanyProvider>();
        return pro.isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(),
                    SizedBox(height: 20),
                    // Add space between the spinner and text
                    Text(
                      widget.create
                          ? 'Waiting Create Your Profile...'
                          : 'Waiting Update Your Profile...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black, // Set text color
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.create ? "Create Profile" : "Update Profile",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: "GothamBold",
                          fontSize: 28.0,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textColor14,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.containerColor8,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24.0),
                          child: Form(
                            key: newKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: getImage,
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.textColor14,
                                        radius: 20,
                                        child: Icon(
                                          Icons.edit_outlined,
                                          color: AppColors.containerColor8,
                                        ),
                                      ),
                                    ),
                                  ),
                                  radius: 62,
                                  backgroundImage: networkUserImage.isNotEmpty
                                      ? NetworkImage(networkUserImage)
                                      : _image == null
                                          ? AssetImage(
                                              'assets/images/profile4.png')
                                          : FileImage(_image!) as ImageProvider,
                                ),
                                SizedBox(height: 14),
                                _buildTextField(
                                    _companyNameController, 'Company Name'),
                                _buildTextField(
                                    _adminNameController, 'Admin Name'),
                                _buildTextField(_emailController, 'Email',
                                    enabled: !_isEmailLocked),
                                _buildTextField(_phoneController, 'Phone',
                                    keyboardType: TextInputType.number),
                                _buildTextField(_addressController, 'Address',
                                    maxLines: 2),
                                _buildTextField(_companyDescriptionController,
                                    'Company Description',
                                    maxLines: 4),
                                _buildTextField(
                                    _websiteController, 'Website (Optional)',
                                    validator: (val) {
                                  if (val!.isEmpty) {
                                    return null;
                                  }
                                  return null;
                                }, keyboardType: TextInputType.url),
                                _buildTextField(
                                    _linkedinController, 'LinkedIn (Optional)',
                                    validator: (val) {
                                  if (val!.isEmpty) {
                                    return null;
                                  }
                                  return null;
                                }, keyboardType: TextInputType.url),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: widget.create
                                      ? () async {
                                          if (newKey.currentState!.validate()) {
                                            if (_image == null &&
                                                networkUserImage == null) {
                                              MyToast(
                                                  "Please upload a company logo",
                                                  Type: false);
                                            } else if (_downloadURL == null) {
                                              MyToast(
                                                  "Please wait few second Image Uploading...");
                                            } else {
                                              final company_user_profile =
                                                  CompanyUserProfile(
                                                companyName:
                                                    _companyNameController.text
                                                        .trim(),
                                                adminName: _adminNameController
                                                    .text
                                                    .trim(),
                                                email: _emailController.text
                                                    .trim(),
                                                phone: _phoneController.text
                                                    .trim(),
                                                address: _addressController.text
                                                    .trim(),
                                                companyDescription:
                                                    _companyDescriptionController
                                                        .text
                                                        .trim(),
                                                website: _websiteController.text
                                                    .trim(),
                                                linkedin: _linkedinController
                                                    .text
                                                    .trim(),
                                                companyLogo: _downloadURL,
                                                user: widget.userDetails!.id,
                                              );
                                              final data =
                                                  company_user_profile.toJson();

                                              final response =
                                                  await pro.CreateCompanyUser(
                                                      context,
                                                      widget.token,
                                                      data);

                                              if (response != null) {
                                                final data =
                                                    CompanyProfile.fromJson(
                                                        response);
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    CupertinoDialogRoute(
                                                        builder: (_) =>
                                                            CompanyAdminBottomNavigationBar(
                                                              profileData: data,
                                                              userDetails: widget
                                                                  .userDetails,
                                                              authToken:
                                                                  widget.token,
                                                            ),
                                                        context: context),
                                                    (route) => false);
                                              }
                                            }
                                          }
                                        }
                                      : () async {
                                          if (newKey.currentState!.validate()) {
                                            if (_image == null &&
                                                networkUserImage == null) {
                                              MyToast(
                                                  "Please upload a company logo",
                                                  Type: false);
                                            } else if (_downloadURL == null) {
                                              MyToast(
                                                  "Please wait few second Image Uploading...");
                                            } else {
                                              final company_user_profile =
                                                  CompanyUserProfile(
                                                companyName:
                                                    _companyNameController.text
                                                        .trim(),
                                                adminName: _adminNameController
                                                    .text
                                                    .trim(),
                                                email: _emailController.text
                                                    .trim(),
                                                phone: _phoneController.text
                                                    .trim(),
                                                address: _addressController.text
                                                    .trim(),
                                                companyDescription:
                                                    _companyDescriptionController
                                                        .text
                                                        .trim(),
                                                website: _websiteController.text
                                                    .trim(),
                                                linkedin: _linkedinController
                                                    .text
                                                    .trim(),
                                                companyLogo: _downloadURL,
                                                user: widget.userDetails!.id,
                                              );
                                              final data =
                                                  company_user_profile.toJson();
                                              print(_downloadURL);
                                              print(widget.userDetails?.id);
                                              final response = await pro
                                                  .UpdateCompanyProfile(
                                                      widget.token,
                                                      widget.userDetails?.id,
                                                      data);

                                              if (response != null) {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    CupertinoDialogRoute(
                                                        builder: (_) =>
                                                            CompanyAdminBottomNavigationBar(
                                                              profileData: widget
                                                                  .profileDetails,
                                                              userDetails: widget
                                                                  .userDetails,
                                                              authToken:
                                                                  widget.token,
                                                            ),
                                                        context: context),
                                                    (route) => false);
                                              }
                                            }
                                          }
                                        },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          AppColors.primaryColor,
                                          AppColors.secondaryColor,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.create
                                            ? "Create Company Profile"
                                            : "Update Company Profile",
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool enabled = true,
      var keyboardType = TextInputType.text,
      var prefixIcon,
      var validator,
      var maxLines = 1,
      OnChange}) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          //onChanged: OnChange,
          enabled: enabled,
          validator: validator ??
              (val) {
                if (val == null || val.isEmpty) {
                  return '$label cannot be empty';
                }
                return null;
              },
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: TextStyle(
            fontFamily: "GothamRegular",
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor15,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.containerColor8,
            labelText: label,
            labelStyle: TextStyle(
              fontFamily: "GothamRegular",
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.containerColor8,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.containerColor8,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ));
  }
}
