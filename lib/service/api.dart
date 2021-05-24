import 'package:flutter_app2/model/timesheet.dart';

List<Timesheet> dataWeek() {
  return List.generate(
      21,
          (i) => Timesheet(
          year: 2021,
          startOfWeek: "${i * 7}.06",
          hours: 10 + i * 0.05,
          weekOfYear: i,
          released: (i > 3)));
}