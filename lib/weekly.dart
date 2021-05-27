import 'package:flutter/material.dart';
import 'package:flutter_app2/model/timesheet.dart';
import 'package:flutter_app2/service/api.dart';
import 'package:flutter_app2/service/convertToTimeString.dart';

class Weekly extends StatefulWidget {
  Weekly({Key key, this.week}) : super(key: key);
  final Timesheet week;

  @override
  _Weekly createState() => _Weekly();
}

class _Weekly extends State<Weekly> {
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
    return Container(
      child: WeekTable(sheet: widget.week),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class WeekTable extends StatelessWidget {
  final Timesheet sheet;

  WeekTable({Key key, @required this.sheet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: generateWeekEntryAsync(sheet),
          builder: (context, d) {
            if (d.connectionState != ConnectionState.done) {
              return Center(
                  child: CircularProgressIndicator(
                value: null,
              ));
            }
            return DataTable(
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
                      'Aktivität',
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
              rows: buildList(d.data),
            );
          },
        ),
      ),
    );
  }

  MaterialStateProperty<Color> buildResolveWith(WeekDataItem e) {
    return MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
      if (e.heading) return Colors.grey.shade300;
      return null;
    });
  }

  List<DataRow> buildList(List<WeekDataItem> d) {
    return d
        .map(
          (e) => DataRow(
            color: buildResolveWith(e),
            cells: <DataCell>[
              DataCell(Text(e.name)),
              DataCell(Text(e.hours.toString() + "h")),
              DataCell(Column(mainAxisSize: MainAxisSize.max, children: [
                Text(
                    'Row  ${sheet.weekOfYear} asdf asdf asfd asdf l a alsd fjl alsdkfjlaskd flskdfjla ksj  asdlkj asd lksdfj ')
              ])),
            ],
          ),
        )
        .toList();
  }
}
