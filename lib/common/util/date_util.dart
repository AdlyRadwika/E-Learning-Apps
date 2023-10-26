import 'package:intl/intl.dart';

class DateUtil {
  static DateFormat dateFormat = DateFormat(
    "dd MMMM yyyy",
  );

  static String formatDate(String dateString) {
    final dateTime = DateTime.tryParse(dateString);
    return dateFormat.format(dateTime ?? DateTime.now());
  }

  //-1 = yesterday, 0 = today, and 1 = tomorrow
  static int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
