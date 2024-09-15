class CompanyUserProfile {
  final String companyName;
  final String adminName;
  final String? companyLogo;
  final String email;
  final String phone;
  final String address;
  final String companyDescription;
  final String display_email;
  final String username;
  final String? website;
  final String? linkedin;
  final int? user;

  CompanyUserProfile({
    required this.companyName,
    required this.adminName,
    this.companyLogo,
    required this.email,
    required this.display_email,
    required this.username,
    required this.phone,
    required this.address,
    required this.companyDescription,
    required this.user,
    this.website,
    this.linkedin,
  });

  factory CompanyUserProfile.fromJson(Map<String, dynamic> json) {
    return CompanyUserProfile(
        companyName: json['company_name'],
        adminName: json['admin_name'],
        companyLogo: json['company_logo'],
        email: json['email'],
        phone: json['phone'],
        address: json['address'],
        companyDescription: json['company_description'],
        display_email: json['display_email'],
        username: json['username'],
        website: json['website'],
        linkedin: json['linkedin'],
        user: json['user']);
  }

  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
      'admin_name': adminName,
      'company_logo': companyLogo,
      'email': email,
      'phone': phone,
      'address': address,
      'company_description': companyDescription,
      'display_email': display_email,
      'username': username,
      'website': website,
      'linkedin': linkedin,
      'user': user
    };
  }
}
