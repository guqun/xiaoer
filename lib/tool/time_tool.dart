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
}