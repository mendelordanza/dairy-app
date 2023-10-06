import 'package:purchases_flutter/models/period_unit.dart';

class DateHelper {
  static String getPeriod({
    required int value,
    required PeriodUnit unit,
  }) {
    switch (unit) {
      case PeriodUnit.week:
        if (value == 1) {
          return "7 days";
        } else if (value == 2) {
          return "14 days";
        } else {
          return "$value ${unit.name}";
        }
      case PeriodUnit.day:
        return "$value ${unit.name}";
      case PeriodUnit.month:
        return "$value ${unit.name}";
      case PeriodUnit.year:
        return "$value ${unit.name}";
      case PeriodUnit.unknown:
        return "";
    }
  }
}
