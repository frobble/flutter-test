import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app2/weeklist.dart';
import 'package:flutter_app2/weekly.dart';

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
    return Row(
      children: [
        Flexible(child: Weeklist(title: 'Stundenzettel')),
        Flexible(child: Weekly(week: null)),
      ],
    );
  }
}