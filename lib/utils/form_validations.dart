class FormValidations {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static bool validatePassword(String password) {
    if (password.length < 6) {
      return false;
    } else {
      return false;
    }
  }
}
