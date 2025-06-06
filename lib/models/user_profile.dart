class UserProfile {
  final bool error;
  final String? message;
  final ResponseUser user;
  final String token;

  UserProfile({
    this.message,
    required this.user,
    this.error = false,
    required this.token,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    error: json['error'],
    message: json['message'],
    user: ResponseUser.fromJson(json['user']),
    token: json['token'],
  );

  factory UserProfile.fromJsonLocal(Map<String, dynamic> json) => UserProfile(
    token: json['token'],
    user: ResponseUser.fromJson(json['user']),
  );

  Map<String, dynamic> toJson() => {
    'error': error,
    'message': message,
    'user': user.toJson(),
    'token': token,
  };
}

class ResponseUser {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String phone;
  final String password;
  final bool? receiveNotificationsEmail;
  final String? accountType;
  final String? status;
  final String? pictureUrl;
  final String? resetPasswordToken;
  final String? resetPasswordExpires;
  final int createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastLogin;

  ResponseUser({
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

  factory ResponseUser.fromJson(Map<String, dynamic> json) {
    return ResponseUser(
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
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "email": email,
      "phone": phone,
      "password": password,
      "recieveNotificationsEmail": receiveNotificationsEmail,
      "accountType": accountType,
      "status": status,
      "pictureUrl": pictureUrl,
      "resetPasswordToken": resetPasswordToken,
      "resetPasswordExpires": resetPasswordExpires,
      "createdBy": createdBy,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "lastLogin": lastLogin?.toIso8601String(),
    };
  }
}
