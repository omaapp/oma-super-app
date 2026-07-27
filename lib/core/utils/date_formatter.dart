import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String date(DateTime date) {
    return DateFormat(
      "yyyy/MM/dd",
    ).format(date);
  }

  static String time(DateTime date) {
    return DateFormat(
      "HH:mm",
    ).format(date);
  }
}