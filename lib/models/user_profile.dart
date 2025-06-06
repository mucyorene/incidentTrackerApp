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

class LoginResponse {
  final bool error;
  final String message;
  final User user;
  final String token;

  LoginResponse({
    required this.error,
    required this.message,
    required this.user,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    error: json['error'],
    message: json['message'],
    user: User.fromJson(json['user']),
    token: json['token'],
  );
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String phone;
  final String password;
  final bool receiveNotificationsEmail;
  final String accountType;
  final String status;
  final String pictureUrl;
  final String? resetPasswordToken;
  final String? resetPasswordExpires;
  final int createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLogin;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.phone,
    required this.password,
    required this.receiveNotificationsEmail,
    required this.accountType,
    required this.status,
    required this.pictureUrl,
    required this.resetPasswordToken,
    required this.resetPasswordExpires,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    gender: json['gender'],
    email: json['email'],
    phone: json['phone'],
    password: json['password'],
    receiveNotificationsEmail: json['recieveNotificationsEmail'],
    accountType: json['accountType'],
    status: json['status'],
    pictureUrl: json['pictureUrl'],
    resetPasswordToken: json['resetPasswordToken'],
    resetPasswordExpires: json['resetPasswordExpires'],
    createdBy: json['createdBy'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    lastLogin:
        json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "email": email,
      "phone": phone,
      "password": password,
      "receiveNotificationsEmail": receiveNotificationsEmail,
      "accountType": accountType,
    };
  }
}
