class User {
  String token;
  LocalUser? user;

  User({required this.token, required this.user});

  factory User.fromJson(Map<String, dynamic> json) => User(
    token: json["token"],
    user: json["user"] != null ? LocalUser.fromJson(json["user"]) : null,
  );
}

class LocalUser {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String phone;
  final String password;
  final bool receiveNotificationsEmail;
  final String accountType;

  LocalUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.phone,
    required this.password,
    required this.receiveNotificationsEmail,
    required this.accountType,
  });

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      receiveNotificationsEmail: json['receiveNotificationsEmail'],
      accountType: json['accountType'],
    );
  }
}
