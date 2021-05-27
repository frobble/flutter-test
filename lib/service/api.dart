import 'package:flutter_app2/model/timesheet.dart';

List<Timesheet> dataWeek() {
  return List.generate(
      21,
          (i) =>
          Timesheet(
              year: 2021,
              startOfWeek: "${i * 7}.06",
              hours: 10 + i * 0.05,
              weekOfYear: i,
              released: (i > 3)));
}

class WeekDataItem {
  String name = "hello";
  int hours = 8;
  String description = "desc";
  bool heading = false;

  WeekDataItem(this.name, this.hours, this.description, this.heading);
}

Future<List<WeekDataItem>> generateWeekEntryAsync(Timesheet sheet) async {
  print('Generate...');
  return Future.delayed(Duration(milliseconds: 200), ()  {
      print('done!');
      return _generateWeekEntry(sheet.weekOfYear);
});
}

List<WeekDataItem> _generateWeekEntry(int week) {
  print('Building list');
  return List.generate(
      21,
          (i) =>
      i % 3 == 0
          ? WeekDataItem("Day " + (i / 3).toString(), 8, "desc", true)
          : WeekDataItem("Entry $week " + (i % 3).toString(), 8, "desc", false));
}


