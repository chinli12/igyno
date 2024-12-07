import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';

List<CalendarStruct> getCalendar(
  DateTime firstDayPeriod,
  DateTime lastDayPeriod,
  int cycleLength,
) {
// Constants for ovulation and fertile window calculation
  const int ovulationDayOffset = 14;
  const int fertileWindowStartOffset = 10;
  const int fertileWindowEndOffset = 15;

  DateTime startOfMonth =
      DateTime(firstDayPeriod.year, firstDayPeriod.month, 1);
  DateTime endOfMonth =
      DateTime(firstDayPeriod.year, firstDayPeriod.month + 1, 0);

  // Adjust start day to Monday
  DateTime calendarStartDay = startOfMonth;
  if (startOfMonth.weekday != DateTime.monday) {
    calendarStartDay =
        startOfMonth.subtract(Duration(days: startOfMonth.weekday - 1));
  }

  // Adjust end day to Sunday
  DateTime calendarEndDay = endOfMonth;
  if (endOfMonth.weekday != DateTime.sunday) {
    calendarEndDay = endOfMonth.add(Duration(days: 7 - endOfMonth.weekday));
  }

  // Calculate ovulation day and fertile window
  DateTime ovulationDay =
      firstDayPeriod.add(Duration(days: ovulationDayOffset));
  DateTime fertileWindowStart =
      firstDayPeriod.add(Duration(days: fertileWindowStartOffset));
  DateTime fertileWindowEnd =
      firstDayPeriod.add(Duration(days: fertileWindowEndOffset));

  // Generate the calendar
  List<CalendarStruct> calendar = [];
  DateTime currentDate = calendarStartDay;

  while (currentDate.isBefore(calendarEndDay.add(Duration(days: 1)))) {
    calendar.add(CalendarStruct(
      calendarDay: currentDate,
      isPreviousDay: currentDate.isBefore(startOfMonth),
      isNextMonth: currentDate.isAfter(endOfMonth),
      isInFertileWindow:
          currentDate.isAfter(fertileWindowStart.subtract(Duration(days: 1))) &&
              currentDate.isBefore(fertileWindowEnd.add(Duration(days: 1))),
      isInOvulation: currentDate.isAtSameMomentAs(ovulationDay),
      isInPeriod:
          currentDate.isAfter(firstDayPeriod.subtract(Duration(days: 1))) &&
              currentDate.isBefore(lastDayPeriod.add(Duration(days: 1))),
    ));
    currentDate = currentDate.add(Duration(days: 1));
  }

  return calendar;
}

String predictNextPeriodStart(
  DateTime startPeriod,
  int cycleLength,
) {
  // Calculate the next period's start date by adding the cycle length
  DateTime nextPeriodStart = startPeriod.add(Duration(days: cycleLength));

  // Format the date as "Month Day" (e.g., "June 29")
  return "${DateFormat('MMMM d').format(nextPeriodStart)}";
}

String calculateNextFertileWindow(
  DateTime startPeriod,
  int cycleLength,
) {
  // Calculate ovulation day (14 days before the next period starts)
  DateTime nextOvulationDay = startPeriod.add(Duration(days: cycleLength - 14));

  // Fertile window spans 4 days before ovulation + ovulation day
  DateTime fertileStart = nextOvulationDay.subtract(Duration(days: 4));
  DateTime fertileEnd = nextOvulationDay;

  // Format the dates as "Month Day-Day"
  String fertileWindow =
      "${DateFormat('MMMM d').format(fertileStart)}-${DateFormat('d').format(fertileEnd)}";

  return fertileWindow;
}
