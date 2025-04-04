List<DateTime> getCurrentWeek({required DateTime date}) {
  List<DateTime> currentWeek = [];

  DateTime monday = date.subtract(Duration(days: date.weekday - 1));

  for (int i = 0; i < 7; i++) {
    currentWeek.add(monday);
    monday = monday.add(Duration(days: 1));
  }
  return currentWeek;
}
