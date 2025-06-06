class UserProfile {
  String name;
  String email;
  String phone;
  String gender;
  String accountType;
  String profileUrl;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.accountType,
    required this.profileUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    gender: json["gender"],
    accountType: json["accountType"],
    profileUrl: json["profileUrl"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "gender": gender,
    "accountType": accountType,
    "profileUrl": profileUrl,
  };
}
