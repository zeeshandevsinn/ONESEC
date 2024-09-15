class UserProfileModel {
  final int? id; // Added id field
  final String firstName;
  final String lastName;
  final String email;
  final String? username;
  final String? displayEmail;
  final String phone;
  final String address;
  final String bio;
  final String? facebook;
  final String? instagram;
  final String? website;
  final String? linkedin;
  final String? github;
  final int? whatsapp;
  final String profilePic;
  final String position;
  final int user;

  UserProfileModel(
      {required this.id, // Added id field
      required this.firstName,
      required this.lastName,
      required this.email,
      this.username,
      this.displayEmail,
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
      required this.position});

  // Factory method to create an instance from a JSON map
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
        id: json['id'], // Parse id field
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        username: json['username'],
        displayEmail: json['display_email'],
        phone: json['phone'],
        address: json['address'],
        bio: json['bio'],
        facebook: json['facebook'],
        instagram: json['instagram'],
        website: json['website'],
        linkedin: json['linkedin'],
        github: json['github'],
        whatsapp: json['whatsapp'],
        profilePic: json['profile_pic'],
        user: json['user'],
        position: json['position']);
  }

  // Method to convert the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      // 'id': id, // Include id in JSON
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'username': username,
      'display_email': displayEmail,
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
      'user': user,
      'position': position
    };
  }
}
