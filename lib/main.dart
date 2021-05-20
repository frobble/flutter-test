import 'dart:convert';

import 'package:flutter/material.dart';
import 'timesheet.dart';
import 'weekly.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stundenzettel',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Stundenzettel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Timesheet>> data;
  String _token;

  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            // onTap: () {
            //   Navigator.pop(context);
            //   // Update the state of the app.
            //   // ...
            // },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<Timesheet>> buildWeekList(Future<List<Timesheet>> data ) {
    return FutureBuilder<List<Timesheet>>(
      future: data,
      builder: (context, snapshot) => Container(
        child: ListView.builder(
            itemCount: snapshot.requireData.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text('${snapshot.requireData[index].startOfWeek}'),
                  subtitle: Text('${snapshot.requireData[index].hours}'),
                  onTap: () {
                    blubb(index);
                  },
                  enabled: true,
                  leading: Icon(Icons.access_alarm_outlined, color: Colors.green),
                  hoverColor: Colors.grey.shade200,
                  trailing: ElevatedButton(
                      child: Icon(Icons.arrow_upward),
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: CircleBorder(),
                      )));
            }),
      ),
    );
  }

  blubb(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Weekly(week: index)),
    );
  }

  final items = List<String>.generate(10000, (i) => "Item $i");

  @override
  void initState() {
    final currentUrl = Uri.base;
    const String clientId = "3b228211-de2b-4704-bc7f-85ed0f90364f";
    if (!currentUrl.fragment.contains('access_token=')) {
      // You are not connected so redirect to the Twitch authentication page.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        html.window.location.assign(
          'https://login.microsoftonline.com/27318665-5501-4f5d-9190-9451064ea4f4/oauth2/v2.0/authorize?response_type=token&client_id=$clientId&redirect_uri=${currentUrl.origin}&scope=profile openid https://tim-test.ecs-gmbh.de/timesheet.user',
        );
      });
    } else {
      // You are connected, you can grab the code from the url.
      final fragments = currentUrl.fragment.split('&');
      _token = fragments
          .firstWhere((e) => e.startsWith('access_token='))
          .substring('access_token='.length);
      print('TOKEN!!!! ' + _token);

      data = getResult(_token);

    }


  }

  Future<List<Timesheet>> getResult(String token) async {
    String request = '{"parameter":["BASE*WeeklyTimeSheet",{}],"expand":["StartOfWeek","Year","Review","Rejected","Protected","Hours","SheetUserDisplay","SheetUserName","RejectReason","WeekOfYear","Id","HoursMonday","HoursTuesday","HoursWednesday","HoursThursday","HoursFriday","CurrentUserIsReviewerForProject","CurrentUserIsReviewer","Assignees"]}';
    final response = await http.post(Uri.https('tim-service-test.ecs-gmbh.de', '/v2/services/GetTimeSheets'),headers: {'authorization' : ('Bearer ' + _token)}, body: request);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('RETURN' + response.body);

      Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> list = body["result"];
      List<Timesheet> sheets = list.map((i) => Timesheet.fromJson(i)).toList();

      return sheets;

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
