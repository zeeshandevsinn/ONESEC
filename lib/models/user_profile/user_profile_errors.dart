class UserProfileErrors {
  List<String>? facebook;
  List<String>? instagram;
  List<String>? website;
  List<String>? linkedin;
  List<String>? github;
  List<String>? whatsapp;
  List<String>? user;
  List<String>? profilePic;

  UserProfileErrors.fromJson(Map<String, dynamic> json) {
    facebook =
        json['facebook'] != null ? List<String>.from(json['facebook']) : null;
    instagram =
        json['instagram'] != null ? List<String>.from(json['instagram']) : null;
    website =
        json['website'] != null ? List<String>.from(json['website']) : null;
    linkedin =
        json['linkedin'] != null ? List<String>.from(json['linkedin']) : null;
    github = json['github'] != null ? List<String>.from(json['github']) : null;
    whatsapp =
        json['whatsapp'] != null ? List<String>.from(json['whatsapp']) : null;
    user = json['user'] != null ? List<String>.from(json['user']) : null;
    profilePic = json['profile_pic'] != null
        ? List<String>.from(json['profile_pic'])
        : null;
  }
}
