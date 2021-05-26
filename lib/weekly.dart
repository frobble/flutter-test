import 'package:flutter/material.dart';
import 'package:flutter_app2/model/timesheet.dart';
import 'package:flutter_app2/service/convertToTimeString.dart';

class Weekly extends StatefulWidget {
  Weekly({Key key, this.week}) : super(key: key);
  final Timesheet week;

  @override
  _Weekly createState() => _Weekly();
}

class _Weekly extends State<Weekly> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
            "2021 KW ${widget.week.weekOfYear} (${convertToTimeString(widget.week.hours)}h)"),
      ),
      body: Center(
        child: buildWeekList(),
      ),

    );
  }

  Container buildWeekList() {
    return Container(child: WeekTable(weekOfYear: widget.week.weekOfYear));
  }


  final items = List<String>.generate(7, (i) => "Day $i");
}

/// This is the stateless widget that the main application instantiates.
class WeekTable extends StatelessWidget {
  final int weekOfYear;

  const WeekTable({Key key, this.weekOfYear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: DataTable(
          headingRowColor: MaterialStateColor.resolveWith(
            (states) {
              return Colors.blueAccent;
            },
          ),
          sortAscending: false,
          sortColumnIndex: 0,
          columns: const <DataColumn>[
            DataColumn(

              label: Center(
                child: Text(
                  'Aktivität', ///Kunde (Projekt)
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Arbeitszeit',
              ),
            ),
            DataColumn(
              label: Text(
                'Beschreibung',
              ),
            ),
          ],
          rows: List<DataRow>.generate(
            21,
            (int index) => DataRow(
              color: buildResolveWith(index),
              cells: <DataCell>[
                DataCell(Text(data()[index].name)),
                DataCell(Text(data()[index].hours.toString() + "h")),
                DataCell(Column(mainAxisSize: MainAxisSize.max, children: [
                  Text(
                      'Row $index $weekOfYear asdf asdf asfd asdf l a alsd fjl alsdkfjlaskd flskdfjla ksj  asdlkj asd lksdfj ')
                ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  MaterialStateProperty<Color> buildResolveWith(int index) {
    return MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
      if (data()[index].heading) return Colors.grey.shade300;
      return null;
    });
  }
}

List<WeekDataItem> data() {
  return List.generate(
      21,
      (i) => i % 3 == 0
          ? WeekDataItem("Day " + (i / 3).toString(), 8, "desc", true)
          : WeekDataItem("Entry " + (i % 3).toString(), 8, "desc", false));
}

class WeekDataItem {
  String name = "hello";
  int hours = 8;
  String description = "desc";
  bool heading = false;

  WeekDataItem(this.name, this.hours, this.description, this.heading);
}
