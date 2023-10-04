import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime? {
  String formatDate({required String pattern}) {
    if (this != null) {
      final formatter = DateFormat(pattern);
      return formatter.format(this!);
    }
    return "No date";
  }

  DateTime getStartOfDay() {
    return DateTime(this!.year, this!.month, this!.day);
  }

  DateTime getEndOfDay() {
    return DateTime(
      this!.year,
      this!.month,
      this!.day,
      23,
      59,
      59,
    );
  }

  String calculateWeeksElapsed() {
    DateTime currentDate = DateTime.now().getStartOfDay();
    if (this != null) {
      int differenceInDays =
          currentDate.difference(this!.getStartOfDay()).inDays;
      if (differenceInDays >= 7) {
        double weeksElapsed = differenceInDays / 7;
        return "${weeksElapsed.toStringAsFixed(1)}\nWeeks";
      } else {
        return "$differenceInDays\nDays";
      }
    }
    return "0.0";
  }

  int daysRemaining() {
    DateTime now = DateTime.now();
    if (this != null) {
      Duration difference = this!.difference(now);
      return difference.inDays;
    }
    return 0;
  }

  bool isToday() {
    DateTime now = DateTime.now();
    if (this != null) {
      return this!.year == now.year &&
          this!.month == now.month &&
          this!.day == now.day;
    }
    return false;
  }

  DateTime getLast7Days() {
    final startOfWeek = this!.subtract(const Duration(days: 6));
    return startOfWeek;
  }
}
