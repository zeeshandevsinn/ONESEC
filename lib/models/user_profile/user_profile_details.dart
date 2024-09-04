import 'dart:io';

class UserProfileDetails {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String position; // Corrected from 'postion'
  final String phone;
  final String address;
  final String bio;
  final String? facebook;
  final String? instagram;
  final String? website;
  final String? linkedin;
  final String? github;
  final int? whatsapp;
  final String profilePic; // Changed to String?
  final int user;

  UserProfileDetails({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.position, // Corrected
    required this.phone,
    required this.address,
    required this.bio,
    this.facebook,
    this.instagram,
    this.website,
    this.linkedin,
    this.github,
    this.whatsapp,
    required this.profilePic,
    required this.user,
  });

  factory UserProfileDetails.fromJson(Map<String, dynamic> json) {
    return UserProfileDetails(
      id: json['id'],
      firstName: json['first_name'] ?? '', // Handle null with default value
      lastName: json['last_name'] ?? '', // Handle null with default value
      email: json['email'] ?? '', // Handle null with default value
      position: json['position'] ?? '', // Handle null with default value
      phone: json['phone'] ?? '', // Handle null with default value
      address: json['address'] ?? '', // Handle null with default value
      bio: json['bio'] ?? '', // Handle null with default value
      facebook: json['facebook'], // Handle null
      instagram: json['instagram'], // Handle null
      website: json['website'], // Handle null
      linkedin: json['linkedin'], // Handle null
      github: json['github'], // Handle null
      whatsapp: json['whatsapp'], // Handle null
      profilePic: json['profile_pic'] ?? '', // Handle null
      user: json['user'],
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
      'position': position, // Corrected from 'postion'
    };
  }
}
