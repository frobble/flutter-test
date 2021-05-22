import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/weekly.dart';

import 'model/timesheet.dart';

class Weeklist extends StatefulWidget {
  Weeklist({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WeeklistState createState() => _WeeklistState();
}

class _WeeklistState extends State<Weeklist> {
  Future<List<Timesheet>> data;
  String _token;

  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: buildWeekList(data),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 90,
            child: DrawerHeader(
              child: ListTile(
                leading: Icon(Icons.verified_user),
                title: Text('Björn Schmacka'),
                // decoration: BoxDecoration(
                //   color: Colors.white,
                // ),
              ),
            ),
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app_outlined),
             onTap: () {
              Navigator.pop(context);
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Stundenzettel'),
            leading: Icon(Icons.home),
            onTap: () {
            },
          ),
          ListTile(
            title: Text('Monatsübersicht'),
            leading: Icon(Icons.calendar_today),
            onTap: () {
            },
          ),
          ListTile(
            title: Text('Aufträge'),
            leading: Icon(Icons.cases_sharp),
            onTap: () {
            },
          ),
          ListTile(
            title: Text('Urlaubsanträge'),
            leading: Icon(Icons.holiday_village),
            onTap: () {
            },
          ),
          ListTile(
            title: Text('Überprüfen'),
            leading: Icon(Icons.compare_arrows_sharp),
            onTap: () {},
          ),
          ListTile(
            title: Text('Einstellungen'),
            leading: Icon(Icons.settings),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<Timesheet>> buildWeekList(Future<List<Timesheet>> data) {
    print('now3');
    return FutureBuilder<List<Timesheet>>(
      future: data,
      builder: (context, AsyncSnapshot<List<Timesheet>> snapshot) =>
          buildAsyncList(snapshot),
    );
  }

  Container buildAsyncList(AsyncSnapshot<List<Timesheet>> snapshot) {
    if (!snapshot.hasData) return Container();
    return Container(
      child: ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return buildWeekTile(snapshot, index);
          }),
    );
  }

  Widget buildWeekTile(AsyncSnapshot<List<Timesheet>> snapshot, int index) {
    var time = snapshot.data[index].hours.floor();
    var mins =
        (snapshot.data[index].hours - snapshot.data[index].hours.floor()) *
            100 *
            6 /
            10;
    // Container(
    //   foregroundDecoration: BoxDecoration(
    //     color: Colors.grey,
    //     backgroundBlendMode: BlendMode.saturation,
    //   ),
    //   child: child,
    // )
    return Opacity(
      opacity: snapshot.data[index].released ? 0.5 : 1,
      child: ListTile(
          title: Text(
              '${snapshot.data[index].year} KW ${snapshot.data[index].weekOfYear}'),
          subtitle: Row(
            children: [
              Text("Arbeitszeit:"),
              SizedBox(width: 5),
              Text(
                "$time:${mins.floor()}h,",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),
              Text("Begin: ${snapshot.data[index].startOfWeek}"),
            ],
          ),
          onTap: () {
            blubb(index);
          },
          enabled: true,
          leading: buildFrontIcon((snapshot.data[index])),
          hoverColor: Colors.grey.shade200,
          trailing: determineButtonForRow(snapshot.data[index])),
    );
  }

  Icon buildFrontIcon(Timesheet data) {
    if (data.released) return Icon(Icons.air_outlined, color: Colors.grey);
    return Icon(Icons.access_alarm_outlined, color: Colors.green);
  }

  Widget determineButtonForRow(Timesheet data) {
    if (data.released) return null;
    return ElevatedButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape: CircleBorder(),
        ));
  }

  blubb(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Weekly(week: index)),
    );
  }

  final items = List<String>.generate(10000, (i) => "Item $i");

  Future<List<Timesheet>> getResult(String token) {
    print('now');
    return Future.value(dataWeek());
  }

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

  @override
  void initState() {
    // final currentUrl = Uri.base;
    // const String clientId = "3b228211-de2b-4704-bc7f-85ed0f90364f";
    // if (!currentUrl.fragment.contains('access_token=')) {
    //   // You are not connected so redirect to the Twitch authentication page.
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     html.window.location.assign(
    //       'https://login.microsoftonline.com/27318665-5501-4f5d-9190-9451064ea4f4/oauth2/v2.0/authorize?response_type=token&client_id=$clientId&redirect_uri=${currentUrl.origin}&scope=profile openid https://tim-test.ecs-gmbh.de/timesheet.user',
    //     );
    //   });
    // } else {
    //   // You are connected, you can grab the code from the url.
    //   final fragments = currentUrl.fragment.split('&');
    //   _token = fragments
    //       .firstWhere((e) => e.startsWith('access_token='))
    //       .substring('access_token='.length);
    //   print('TOKEN!!!! ' + _token);

    data = getResult(_token);
  }
}
