class EmployeeProfile {
  String? firstName;
  String? lastName;
  String email;
  String position;
  String? phone;
  String? address;
  String? bio;
  String? facebook;
  String? instagram;
  String? website;
  String? linkedin;
  String? github;
  String? whatsapp;
  String? profilePic;
  int? company;

  EmployeeProfile(
      {this.firstName,
      this.lastName,
      required this.email,
      required this.position,
      this.phone,
      this.address,
      this.bio,
      this.facebook,
      this.instagram,
      this.website,
      this.linkedin,
      this.github,
      this.whatsapp,
      this.profilePic,
      required this.company});

  // Convert JSON to EmployeeProfile
  factory EmployeeProfile.fromJson(Map<String, dynamic> json) {
    return EmployeeProfile(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        position: json['position'],
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
        company: json['company']);
  }

  // Convert EmployeeProfile to JSON
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'position': position,
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
      'company': company
    };
  }
}
