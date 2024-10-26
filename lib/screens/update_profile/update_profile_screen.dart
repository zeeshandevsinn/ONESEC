import 'package:client_nfc_mobile_app/controller/permissions/permission_app.dart';
import 'package:client_nfc_mobile_app/controller/services/firebase%20storeage/storeage_image.dart';
import 'package:client_nfc_mobile_app/controller/services/login_api.dart';
import 'package:client_nfc_mobile_app/controller/services/user_profile_provider.dart';
import 'package:client_nfc_mobile_app/individual_bottom_navigationbar.dart';
import 'package:client_nfc_mobile_app/models/user_model.dart';
import 'package:client_nfc_mobile_app/models/user_profile/user_profile_details.dart';
import 'package:client_nfc_mobile_app/utils/colors.dart';
import 'package:client_nfc_mobile_app/utils/loading_circle.dart';
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

class CreatAndUpdateProfileScreen extends StatefulWidget {
  final User? userDetails;
  final bool create;
  final UserProfileModel? profileDetails;
  final token;

  CreatAndUpdateProfileScreen({
    super.key,
    required this.userDetails,
    required this.create,
    required this.token,
    this.profileDetails,
  });

  @override
  _CreatAndUpdateProfileScreenState createState() =>
      _CreatAndUpdateProfileScreenState();
}

class _CreatAndUpdateProfileScreenState
    extends State<CreatAndUpdateProfileScreen> {
  File? _image;
  final picker = ImagePicker();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _linkedInController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _postionController = TextEditingController();
  final TextEditingController displayEmailController = TextEditingController();
  String? username;
  int? _whatsappNumber = null;

  // void _updateNumber() {}

  bool _isEmailLocked = false;
  // bool _isNameLocked = false;
  String networkUserImage = '';
  void profileDetailCheck() {
    if (widget.profileDetails != null) {
      setState(() {
        _firstNameController.text = widget.profileDetails!.firstName ?? "";
        _lastNameController.text = widget.profileDetails!.lastName ?? "";
        _emailController.text = widget.profileDetails!.email ?? "";
        _isEmailLocked = _emailController.text.isNotEmpty;
        username = widget.profileDetails!.username;
        displayEmailController.text =
            widget.profileDetails!.displayEmail.toString();
        // _isNameLocked = (_firstNameController.text.isNotEmpty) &&
        //     (_lastNameController.text.isNotEmpty);
        _phoneController.text = widget.profileDetails!.phone ?? "";
        _addressController.text = widget.profileDetails!.address ?? " ";
        _bioController.text = widget.profileDetails!.bio ?? "";
        _postionController.text = widget.profileDetails!.position ?? "";
        _websiteController.text = widget.profileDetails!.website ?? '';
        _facebookController.text = widget.profileDetails!.facebook ?? '';
        _instagramController.text = widget.profileDetails!.instagram ?? '';
        _linkedInController.text = widget.profileDetails!.linkedin ?? '';
        _githubController.text = widget.profileDetails!.github ?? '';
        _whatsappController.text =
            widget.profileDetails!.whatsapp?.toString() ?? '';
        _whatsappNumber = widget.profileDetails!.whatsapp;
        networkUserImage = widget.profileDetails!.profilePic ?? '';
        _downloadURL = networkUserImage;
        // Ensure this is handled appropriately
      });
    }
  }

  void userDetailCheck() {
    if (widget.userDetails != null) {
      setState(() {
        _firstNameController.text = widget.userDetails?.firstName ?? '';
        _lastNameController.text = widget.userDetails?.lastName ?? '';
        _emailController.text = widget.userDetails?.email ?? '';
        username = widget.userDetails!.username;

        _isEmailLocked = _emailController.text.isNotEmpty;
        // _isNameLocked = (_firstNameController.text.isNotEmpty) &&
        //     (_lastNameController.text.isNotEmpty);

        networkUserImage = widget.userDetails!.companyName;
        _downloadURL = networkUserImage;
      });
    }
  }

// ignore: unused_field
  String? _downloadURL;
  // ignore: unused_field
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    context.read<UserProfileProvider>();
    _initializeData();
  }

  void _initializeData() {
    if (widget.create) {
      userDetailCheck();
    } else {
      profileDetailCheck();
    }
  }

  final newKey = GlobalKey<FormState>();

  logoutDialogueBox(context, authToken, authType) {
    showDialog(
        context: context,
        builder: (context) {
          var pro = context.read<LoginUserProvider>();
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
                    return pro.isLoading
                        ? Center(child: LoadingCircle())
                        : Padding(
                            padding:
                                const EdgeInsets.only(left: 16, right: 16.0),
                            child: Column(
                              children: [
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
        var pro = context.watch<UserProfileProvider>();
        return pro.isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingCircle(),
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
                      const SizedBox(
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
                                Text(
                                  _firstNameController.text +
                                      ' ' +
                                      _lastNameController.text,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: "GothamBold",
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textColor14,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  widget.userDetails!.username,
                                  style: const TextStyle(
                                    fontFamily: "GothamRegular",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor14,
                                  ),
                                ),
                                SizedBox(height: 20),
                                _buildTextField(
                                  _firstNameController,
                                  'First Name',
                                ),
                                _buildTextField(
                                  _lastNameController,
                                  'Last Name',
                                ),
                                _buildTextField(_emailController, 'Email',
                                    enabled: !_isEmailLocked),
                                _buildTextField(_postionController, 'Position'),
                                // SizedBox(height: 15),
                                // Text(
                                //   '',
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .subtitle1!
                                //       .copyWith(
                                //           fontWeight: FontWeight.normal,
                                //           color: Colors.black87),
                                // ),
                                _buildTextField(
                                    displayEmailController, 'Display Email',
                                    validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'The email you want to show in your digital profile';
                                  }
                                  return null;
                                }, keyboardType: TextInputType.emailAddress),
                                _buildTextField(_phoneController, 'Phone',
                                    validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Phone Field is required";
                                  }
                                  return null;
                                }, keyboardType: TextInputType.number),
                                _buildTextField(_addressController, 'Address',
                                    maxLines: 2),
                                _buildTextField(_bioController, 'Bio',
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
                                    _facebookController, 'Facebook (Optional)',
                                    validator: (val) {
                                  if (val!.isEmpty) {
                                    return null;
                                  }
                                  return null;
                                }, keyboardType: TextInputType.url),
                                _buildTextField(_instagramController,
                                    'Instagram (Optional)', validator: (val) {
                                  if (val!.isEmpty) {
                                    return null;
                                  }
                                  return null;
                                }, keyboardType: TextInputType.url),
                                _buildTextField(
                                    _linkedInController, 'LinkedIn (Optional)',
                                    validator: (val) {
                                  if (val!.isEmpty) {
                                    return null;
                                  }
                                  return null;
                                }, keyboardType: TextInputType.url),
                                _buildTextField(
                                    _githubController, 'Github (Optional)',
                                    validator: (val) {
                                  if (val!.isEmpty) {
                                    return null;
                                  }
                                  return null;
                                }, keyboardType: TextInputType.url),
                                _buildTextField(_whatsappController,
                                    'Whatsapp(966xxxxxxxxx) (Optional)',
                                    OnChange: (val) {
                                  if (val.isNotEmpty) {
                                    // Check if the first character is '0'
                                    if (val[0] == '0') {
                                      // Remove the '0' from the beginning
                                      val = val.substring(1);
                                    }

                                    // Parse the remaining value as a number
                                    final number = int.tryParse(val);

                                    if (number != null) {
                                      setState(() {
                                        _whatsappNumber = number;
                                      });
                                      // Optionally, show a success message or perform an action
                                      print(
                                          "WhatsApp Number Updated: $_whatsappNumber");
                                    }
                                  }
                                }, validator: (val) {
                                  if (val!.isEmpty) {
                                    return null;
                                  }
                                  return null;
                                },
                                    keyboardType: TextInputType.number),
                                SizedBox(height: 20),
                                GestureDetector(
                                  onTap: widget.create
                                      ? () async {
                                          if (newKey.currentState!.validate()) {
                                               {
                                              if (_whatsappController
                                                  .text.isEmpty) {
                                                // if (mounted)
                                                setState(() {
                                                  _whatsappNumber = 0;
                                                });
                                              }
                                              print(widget.userDetails!.id);

                                              final response =
                                                  await pro.CreateProfileData(
                                                displayEmail:
                                                    displayEmailController.text
                                                        .trim(),
                                                username: widget
                                                    .userDetails!.username,
                                                authToken: widget.token,
                                                firstName: _firstNameController
                                                    .text
                                                    .trim(),
                                                lastName: _lastNameController
                                                    .text
                                                    .trim(),
                                                email: _emailController.text
                                                    .trim(),
                                                phone: _phoneController.text
                                                    .trim(),
                                                address: _addressController.text
                                                    .trim(),
                                                bio: _bioController.text.trim(),
                                                facebook: _facebookController
                                                    .text
                                                    .trim(),
                                                instagram: _instagramController
                                                    .text
                                                    .trim(),
                                                website: _websiteController.text
                                                    .trim(),
                                                linkedin: _linkedInController
                                                    .text
                                                    .trim(),
                                                github: _githubController.text
                                                    .trim(),
                                                whatsapp: _whatsappNumber!,
                                                profilePic: _downloadURL,
                                                user: widget.userDetails!.id,
                                                position: _postionController
                                                    .text
                                                    .trim(),
                                              );
                                              if (response != null) {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    CupertinoDialogRoute(
                                                        builder: (_) =>
                                                            IndividualBottomNavigationBar(
                                                              user_auth_token:
                                                                  widget.token,
                                                              futureUser: widget
                                                                  .userDetails,
                                                            ),
                                                        context: context),
                                                    (route) => false);
                                              }
                                            }
                                          }
                                        }
                                      : () async {
                                          //Update Profile
                                          if (newKey.currentState!.validate()) {
                                            {
                                              // debugger();
                                              if (_whatsappController
                                                  .text.isEmpty) {
                                                setState(() {
                                                  _whatsappNumber = 0;
                                                });
                                              }
                                              //

                                              print(_downloadURL);
                                              print(widget.token);
                                              // debugger();
                                              final response =
                                                  await pro.UpdateUserProfile(
                                                display_email:
                                                    displayEmailController.text
                                                        .trim(),
                                                username: widget
                                                    .userDetails!.username,
                                                authToken: widget.token,
                                                id: widget.userDetails!.id,
                                                firstName: _firstNameController
                                                    .text
                                                    .trim(),
                                                lastName: _lastNameController
                                                    .text
                                                    .trim(),
                                                email: _emailController.text
                                                    .trim(),
                                                phone: _phoneController.text
                                                    .trim(),
                                                address: _addressController.text
                                                    .trim(),
                                                bio: _bioController.text.trim(),
                                                facebook: _facebookController
                                                    .text
                                                    .trim(),
                                                instagram: _instagramController
                                                    .text
                                                    .trim(),
                                                website: _websiteController.text
                                                    .trim(),
                                                linkedin: _linkedInController
                                                    .text
                                                    .trim(),
                                                github: _githubController.text
                                                    .trim(),
                                                whatsapp: _whatsappNumber!,
                                                profilePic: _downloadURL,
                                                user: widget.userDetails!.id,
                                                position: _postionController
                                                    .text
                                                    .trim(),
                                              );
                                              // debugger();
                                              if (response != null) {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    CupertinoDialogRoute(
                                                        builder: (_) =>
                                                            IndividualBottomNavigationBar(
                                                              user_auth_token:
                                                                  widget.token,
                                                              futureUser: widget
                                                                  .userDetails,
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
                                            ? "Create User"
                                            : "Update User",
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

  Future<void> getImage(ImageSource source) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool permission = prefs.getBool('allPermissionsGranted') ?? false;
      var pickedFile;

      if (source == ImageSource.camera) {
        PermissionStatus permissionCamera = await Permission.camera.request();
        if (permissionCamera.isGranted) {
          // Pick an image from the selected source (camera or gallery)
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
            pickedFile = await ImagePicker().pickImage(source: source);
          } else {
            pickedFile = null;
          }
        } else {
          PermissionStatus permissionStoreage =
              await Permission.storage.request();

          if (permissionStoreage.isGranted) {
            pickedFile = await ImagePicker().pickImage(source: source);
          } else {
            pickedFile = null;
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
      // MyToast('An error occurred: $e', Type: false);
    }
  }

  Future<void> _pickAndCropImage() async {
    try {
      // Pick an image from the gallery
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

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
            _image =
                File(croppedFile.path); // Update the UI with the cropped image
            networkUserImage = ''; // Reset network image URL
            _isUploading = true; // Indicate upload is in progress
          });

          // Compress and upload the image, then get the download URL
          String? downloadURL = await compressAndUploadImage(_image!);

          // Check if the image was uploaded successfully
          if (downloadURL != null) {
            setState(() {
              _downloadURL = downloadURL;
              networkUserImage = _downloadURL!;
              _isUploading = false; // Upload is complete
            });
            MyToast('Image uploaded successfully.', Type: true);
          } else {
            setState(() {
              _isUploading = false; // Upload failed
            });
            MyToast('Failed to upload image.', Type: false);
          }
        } else {
          MyToast('Image cropping canceled.', Type: false);
        }
      } else {
        MyToast('No image selected.', Type: false);
      }
    } catch (e) {
      // Handle the error gracefully
      // MyToast("Error: $e", Type: false);
      setState(() {
        _isUploading = false; // Ensure upload state is reset
      });
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
                onTap: () async {
                  Navigator.of(context).pop();
                  // await getImage(ImageSource.gallery);
                  await _pickAndCropImage();
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
          // textAlign: TextAlign.left,
          onChanged: OnChange,
          maxLines: maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator != null
              ? validator
              : (val) {
                  if (val!.isEmpty) {
                    return "Field is Empty";
                  }
                  return null;
                },
          style: TextStyle(
            fontFamily: "GothamRegular",
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor12,
          ),
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: AppColors.textColor29,
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              labelText: label,
              labelStyle: TextStyle(
                fontFamily: "GothamRegular",
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor10,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(width: 1, color: AppColors.textColor10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(width: 1, color: AppColors.textColor13),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(width: 1, color: AppColors.textColor13),
              ),
              fillColor: AppColors.containerColor8,
              filled: true,
              enabled: enabled),
        ));
  }
}
