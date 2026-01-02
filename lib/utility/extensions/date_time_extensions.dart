import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String getGreeting() {
    final hour = this.hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    } else if (hour < 17) {
      return 'Selamat Siang';
    } else {
      return 'Selamat Sore';
    }
  }

  int calculateAge() {
    final now = DateTime.now();
    int age = now.year - year;

    // Adjust age if the birthday hasn't occurred yet this year
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }

    return age;
  }

  String convert({String format = "dd-MMMM-yyyy"}) {
    // Creating a DateFormat object with the desired format
    DateFormat formatter = DateFormat(format, 'id_ID');
    // Formatting the DateTime object to a string
    String formattedString = formatter.format(this);
    return formattedString;
  }

  String to12HourTimeString() {
    // Extract hour and minute from DateTime object
    int hour = this.hour;
    int minute = this.minute;

    // Convert hours to 12-hour format
    int hourIn12HourFormat = hour % 12;
    if (hourIn12HourFormat == 0) {
      hourIn12HourFormat = 12;
    }

    // Determine AM or PM
    String period = hour < 12 ? 'AM' : 'PM';

    // Format the time string
    String formattedTime =
        '${hourIn12HourFormat.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';

    return formattedTime;
  }

  DateTime daysBefore(int days) {
    return subtract(Duration(days: days));
  }

  bool areDatesEqual(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime addMonths(int months) {
    return DateTime(year, month + months, day, hour, minute, second, millisecond, microsecond);
  }

  DateTime getFirstDateOfMonth() {
    return DateTime(year, month, 1);
  }

  DateTime getLastDateOfMonth() {
    final nextMonth = DateTime(year, month + 1, 1);
    return nextMonth.subtract(Duration(days: 1));
  }

  int differenceInMinutes(DateTime other) {
    return difference(other).inMinutes.abs();
  }

  DateTime add7Hours() {
    if (this.isUtc) {
      return this.add(Duration(hours: 7)).toLocal();
    }
    return this;
  }

  /// Formats DateTime to API format: "yyyy-MM-dd"
  /// Example: DateTime(2025, 12, 31) -> "2025-12-31"
  String toApiFormat() {
    String year = this.year.toString();
    String month = this.month.toString().padLeft(2, '0');
    String day = this.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

// DayOfWeek get dayOfWeek {
//   switch (weekday) {
//     case DateTime.monday:
//       return DayOfWeek.monday;
//     case DateTime.tuesday:
//       return DayOfWeek.tuesday;
//     case DateTime.wednesday:
//       return DayOfWeek.wednesday;
//     case DateTime.thursday:
//       return DayOfWeek.thursday;
//     case DateTime.friday:
//       return DayOfWeek.friday;
//     case DateTime.saturday:
//       return DayOfWeek.saturday;
//     case DateTime.sunday:
//       return DayOfWeek.sunday;
//     default:
//       throw Exception("Invalid day of week");
//   }
// }
}

extension StringExtensions on String {
  /// Formats time string from "HH:mm:ss" to "HH:mm"
  /// Example: "07:00:00" -> "07:00"
  String formatTimeStart() {
    if (isEmpty) return '';

    try {
      // Parse the time string (format: "HH:mm:ss")
      final parts = split(':');
      if (parts.length >= 2) {
        // Return only hours and minutes (HH:mm)
        return '${parts[0]}:${parts[1]}';
      }
      return this;
    } catch (e) {
      return this;
    }
  }
}

extension IntExtensions on int {
  /// Converts month number (1-12) to Indonesian month name (full)
  /// Example: 1 -> "Januari", 5 -> "Mei", 12 -> "Desember"
  String toMonthName() {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    if (this < 1 || this > 12) return '';
    return months[this - 1];
  }

  /// Converts month number (1-12) to Indonesian month abbreviation
  /// Example: 1 -> "Jan", 5 -> "Mei", 12 -> "Des"
  String toMonthNameShort() {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];

    if (this < 1 || this > 12) return '';
    return months[this - 1];
  }
}