class CompanyUserProfile {
  final String companyName;
  final String adminName;
  final String? companyLogo;
  final String email;
  final String phone;
  final String address;
  final String companyDescription;
  final String? website;
  final String? linkedin;
  final int? user;

  CompanyUserProfile({
    required this.companyName,
    required this.adminName,
    this.companyLogo,
    required this.email,
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
      'website': website,
      'linkedin': linkedin,
      'user': user
    };
  }
}
