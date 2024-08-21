import 'dart:io';

class UserProfileDetails {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String postion;
  final String phone;
  final String address;
  final String bio;
  final String? facebook;
  final String? instagram;
  final String? website;
  final String? linkedin;
  final String? github;
  final int? whatsapp;
  final profilePic; // This should not be included in JSON conversion
  final int user;

  UserProfileDetails({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.postion,
    required this.phone,
    required this.address,
    required this.bio,
    this.facebook,
    this.instagram,
    this.website,
    this.linkedin,
    this.github,
    this.whatsapp,
    this.profilePic,
    required this.user,
  });

  factory UserProfileDetails.fromJson(Map<String, dynamic> json) {
    return UserProfileDetails(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      bio: json['bio'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      website: json['website'],
      linkedin: json['linkedin'],
      github: json['github'],
      whatsapp: json['whatsapp'],
      profilePic: json['profile_pic'], // handle it separately for file uploads
      user: json['user'], postion: json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'bio': bio,
      'facebook': facebook,
      'instagram': instagram,
      'website': website,
      'linkedin': linkedin,
      'github': github,
      'whatsapp': whatsapp,
      'profile_pic': profilePic,
      'position': postion
      // Do not include 'profile_pic' here as it's a file
    };
  }
}
