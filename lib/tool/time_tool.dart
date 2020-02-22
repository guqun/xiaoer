class TimeTool
{
  static int getCurrentDayLastSecond()
  {
    DateTime dateTime = DateTime.now();
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    DateTime newDateTime = new DateTime(year, month, day, 23, 59, 59, 999);
    return newDateTime.millisecondsSinceEpoch;
  }

  static String formatTime(int time)
  {
    DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(time);
    return dateTime.year.toString() + "-" + dateTime.month.toString() + "-" + dateTime.day.toString();
  }

  static String customFormatTime(int time)
  {
    DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(time);
    DateTime nowDateTime = DateTime.now();
    DateTime todayLastDateTime = DateTime(nowDateTime.year, nowDateTime.month, nowDateTime.day, 23, 59, 59);
    Duration diff = todayLastDateTime.difference(dateTime);
    if (diff < Duration(days: 1)) {
      return "Today";
    } else if (diff >= Duration(days: 1) && diff < Duration(days: 2)) {
      return "yesterday";
    } else {
      return dateTime.year.toString() + "-" + dateTime.month.toString() + "-" + dateTime.day.toString();
    }
  }

  static bool isSameDay(int standard, int other)
  {
    DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(standard);
    DateTime otherTime = new DateTime.fromMillisecondsSinceEpoch(other);
    DateTime standardDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
    Duration diff = standardDateTime.difference(otherTime);
    if (diff < Duration(days: 1) && diff > Duration(seconds: 0)) {
      return true;
    } else {
      return false;
    }
  }
}