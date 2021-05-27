import 'package:flutter/material.dart';
import 'package:flutter_app2/weekly.dart';

import 'model/timesheet.dart';

class MasterSlaveProvider extends ChangeNotifier {
  Timesheet _selected;


  changed(Timesheet timesheet) {
    _selected = timesheet;
    notifyListeners();
  }



  bool isWide(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide > 900;
  }


  Timesheet get selected => _selected;

  void select(Timesheet s, BuildContext context) {

    if (isWide(context)) {
      changed(s);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Weekly(week: s)),
      );
    }


  }
}