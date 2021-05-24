import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app2/masterslaveprovider.dart';
import 'package:flutter_app2/splitter.dart';
import 'package:flutter_app2/weeklist.dart';
import 'package:flutter_app2/weekly.dart';
import 'package:provider/provider.dart';

//import 'dart:html' as html;
//import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stundenzettel',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.standard,
      ),
      home: _buildLayout(),
    );
  }

  Widget _buildLayout() {
    return ChangeNotifierProvider(
        create: (context) => MasterSlaveProvider(),
        child: Consumer<MasterSlaveProvider>(
          builder: (context, data, child) {
            if (data.isWide(context)) {
              return VerticalSplitView(
                left: Weeklist(title: 'Stundenzettel', model: data),
                right: Weekly(week: data.selected),
              );
            } else {
              return Weeklist(title: 'Stundenzettel', model: data);
            }
          },
        ));
  }
}
