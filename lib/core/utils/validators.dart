class Validators {
  Validators._();

  static bool phone(String phone) {
    return phone.length == 10;
  }

  static bool otp(String code) {
    return code.length == 6;
  }

  static bool text(String text) {
    return text.trim().isNotEmpty;
  }
}