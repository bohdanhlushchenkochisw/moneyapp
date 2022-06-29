import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String get formattedDate => DateFormat('d MMMM').format(this);
  String get formattedDateFull => DateFormat('d MMMM yyyy h:mm a').format(this);

  bool get isToday => calculateDifference(this) == 0;
  bool get isYesterday => calculateDifference(this) == -1;

  DateTime get clampedToDays => DateTime(year, month, day);

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays;
  }
}
