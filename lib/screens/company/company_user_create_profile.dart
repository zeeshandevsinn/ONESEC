import 'package:client_nfc_mobile_app/company_admin_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/controller/permissions/permission_app.dart';
import 'package:client_nfc_mobile_app/controller/services/company_provider.dart';
import 'package:client_nfc_mobile_app/controller/services/firebase%20storeage/storeage_image.dart';
import 'package:client_nfc_mobile_app/controller/services/login_api.dart';
import 'package:client_nfc_mobile_app/controller/services/user_profile_provider.dart';
import 'package:client_nfc_mobile_app/models/company/company_user.dart';
import 'package:client_nfc_mobile_app/models/company/get_company_profile.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:client_nfc_mobile_app/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
  final TextEditingController displayEmailController = TextEditingController();
  String username = "";
  bool _isEmailLocked = false;
  String networkUserImage = '';

  void profileDetailCheck() {
    if (widget.profileDetails != null) {
      if (mounted)
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
          _downloadURL = networkUserImage;
          displayEmailController.text = widget.profileDetails!.displayEmail!;
          username = widget.userDetails!.username;
        });
    } else {
      if (mounted)
        setState(() {
          _companyNameController.text = widget.userDetails!.companyName;
          _adminNameController.text = widget.userDetails!.adminName;
          _emailController.text = widget.userDetails!.email;
          _isEmailLocked = _emailController.text.isNotEmpty;
          username = widget.userDetails!.username;
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

  Future<void> getImage(ImageSource source) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool permission = prefs.getBool('allPermissionsGranted') ?? false;
      var pickedFile;
      print(permission);
      if (!permission) {
        if (source == ImageSource.camera) {
          PermissionStatus permissionCamera = await Permission.camera.request();
          if (permissionCamera.isGranted) {
            // Pick an image from the selected source (camera or gallery)
            print("Camera Granted");
            pickedFile = await ImagePicker().pickImage(source: source);
          } else {
            pickedFile = null;
          }
        } else if (ImageSource.gallery == source) {
          String number = await PermissionService().getAndroidVersion();
          int version = int.parse(number);
          if (version >= 11) {
            PermissionStatus permissionStoreage =
                await Permission.manageExternalStorage.request();

            if (permissionStoreage.isGranted) {
              print("Storeage Granted");
              pickedFile = await ImagePicker().pickImage(source: source);
            } else {
              pickedFile = null;
            }
          } else {
            PermissionStatus permissionStoreage =
                await Permission.storage.request();

            if (permissionStoreage.isGranted) {
              print("Storeage Granted");
              pickedFile = await ImagePicker().pickImage(source: source);
            } else {
              pickedFile = null;
            }
          }
        }
      }

      // Check if an image was picked
      if (pickedFile != null) {
        // Crop the image
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9,
          ],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              minimumAspectRatio: 1.0,
            ),
          ],
        );

        // Check if the image was cropped successfully
        if (croppedFile != null) {
          setState(() {
            _image = File(croppedFile.path);
            networkUserImage = ''; // Reset network image
          });

          // Compress and upload the image, then get the download URL
          var downloadURL = await compressAndUploadImage(_image!);

          // Check if the image was uploaded successfully
          if (downloadURL != null) {
            setState(() {
              _downloadURL = downloadURL;
              networkUserImage = _downloadURL!;
              _isUploading = false;
            });
          } else {
            MyToast('Failed to upload image.', Type: false);
          }
        } else {
          MyToast('Image cropping canceled.', Type: false);
        }
      } else {
        MyToast('No image selected.', Type: false);
      }
    } catch (e) {
      // Handle any exceptions that occur during the process
      MyToast('An error occurred: $e', Type: false);
    }
  }

  Future<void> _showImageSourceDialog() async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  getImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  getImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  final newKey = GlobalKey<FormState>();
  logoutDialogueBox(context, authToken, authType) {
    showDialog(
        context: context,
        builder: (context) {
          var pro = context.watch<LoginUserProvider>();
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
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.containerColor5,
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/images/icon1.png",
                        width: 47,
                        height: 63,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Text(
                    "Are You Sure?",
                    style: TextStyle(
                      fontFamily: "GothamBold",
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textColor14,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You want to Logout your account.",
                        style: TextStyle(
                          fontFamily: "GothamRegular",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16.0),
                      child: Column(
                        children: [
                          // pro.isLoading
                          //     ? Center(
                          //         child: CircularProgressIndicator.adaptive())
                          //     :
                          GestureDetector(
                            onTap: () async {
                              await pro.logoutAccount(
                                  context, authToken, authType);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 42,
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
                                  "Yes, Sure",
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
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: AppColors.containerColor8,
                                  border: const GradientBoxBorder(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColor,
                                        AppColors.secondaryColor,
                                      ],
                                    ),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: GradientText(
                                    "No",
                                    style: TextStyle(
                                      fontFamily: "GothamRegular",
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    colors: [
                                      AppColors.textColor9,
                                      AppColors.textColor28,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        });
  }

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
                      Row(
                        children: [
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
                          const Spacer(),
                          Spacer(),
                          if (widget.create)
                            GestureDetector(
                              onTap: () {
                                logoutDialogueBox(context, widget.token,
                                    widget.userDetails!.auth_type);
                              },
                              child: Icon(Icons.logout_sharp),
                            )
                        ],
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
                                const SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: _showImageSourceDialog,
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
                                _buildTextField(
                                    displayEmailController, 'Display Email',
                                    validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'The email you want to show in your digital profile';
                                  } else if (!displayEmailController.text
                                          .contains('@') &&
                                      !displayEmailController.text
                                          .contains('.com')) {
                                    return "Email is not Correct";
                                  }
                                  return null;
                                }, keyboardType: TextInputType.emailAddress),
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
                                              MyToast("Please Put Image",
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
                                                display_email:
                                                    displayEmailController.text
                                                        .trim(),
                                                username: widget
                                                    .userDetails!.username,
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
                                              final company_user_profile = CompanyUserProfile(
                                                  companyName:
                                                      _companyNameController.text
                                                          .trim(),
                                                  adminName:
                                                      _adminNameController.text
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
                                                  website: _websiteController
                                                      .text
                                                      .trim(),
                                                  linkedin: _linkedinController
                                                      .text
                                                      .trim(),
                                                  companyLogo: _downloadURL,
                                                  user: widget.userDetails!.id,
                                                  display_email:
                                                      displayEmailController
                                                          .text
                                                          .trim(),
                                                  username: widget
                                                      .userDetails!.username);
                                              final data =
                                                  company_user_profile.toJson();
                                              print(_downloadURL);
                                              print(widget.userDetails?.id);
                                              final response = await pro
                                                  .UpdateCompanyProfile(
                                                      widget.token,
                                                      widget.userDetails
                                                          ?.username,
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
