import 'package:flutter/material.dart';

class Weekly extends StatefulWidget {
  Weekly({Key key, this.week}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final int week;

  @override
  _Weekly createState() => _Weekly();
}

class _Weekly extends State<Weekly> {

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Week " + widget.week.toString()),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: buildWeekList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  Container buildWeekList() {
    return Container(
        child: WeekTable()
    );
  }

  blubb() {
    print('Hello');
  }


  final items = List<String>.generate(7, (i) => "Day $i");
}

/// This is the stateless widget that the main application instantiates.
class WeekTable extends StatelessWidget {
  const WeekTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Kunde',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Arbeitszeit',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Beschreibung',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],

          rows: List<DataRow>.generate(
            21,
              (int index) => DataRow(
               color:MaterialStateProperty.resolveWith<Color>(
                       (Set<MaterialState> states) {
                     if ( data()[index].heading) return Colors.grey.shade300;
                     return null;
                   }),
              cells: <DataCell>[
                DataCell(Text(data()[index].name)),
                DataCell(Text(data()[index].hours.toString() + "h")),
                DataCell(Text('Row $index')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


List<WeekDataItem> data() {
  return List.generate(21, (i) =>
       i % 3 == 0
      ? WeekDataItem("Day " + (i / 3).toString(), 8, "desc", true)
      : WeekDataItem("Entry " + (i % 3).toString(), 8, "desc", false)
  );
}

class WeekDataItem {
  String name = "hello";
  int hours = 8;
  String description = "desc";
  bool heading = false;

  WeekDataItem(this.name, this.hours, this.description, this.heading);
}

