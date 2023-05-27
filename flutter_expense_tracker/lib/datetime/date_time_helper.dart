// convert DateTime object to a String yyyymmdd
String convertDateTimeToString(DateTime dateTime) {
  // year in the format -> yyyy
  String year = dateTime.year.toString();

  // month in the format -> mm
  String month = dateTime.month.toString();
  if (month.length == 1) month = '0$month'; // add leading zero if needed (e.g. 1 -> 01

  // day in the format -> dd
  String day = dateTime.day.toString();
  if (day.length == 1) day = '0$day'; // add leading zero if needed (e.g. 1 -> 01

  // final format -> yyyymmdd
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

/*
DateTime.now() -> 2023/2/11/hour/minutes/seconds.... -> 20230211
*/
