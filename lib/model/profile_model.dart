class ProfileModel {
  final String id;
  final String fullName;
  final String email;
  final String role;

  ProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      role: json['role'],
    );
  }
}
