import 'package:intl/intl.dart';

class DateUtil {
  static DateFormat dateFormat = DateFormat(
    "dd MMMM yyyy",
  );

  static String formatDate(String dateString) {
    final dateTime = DateTime.tryParse(dateString);
    return dateFormat.format(dateTime ?? DateTime.now());
  }
}
