import 'package:flutter/material.dart';
import 'root_tab.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "知乎-高仿版",
      home: new RootTabController(),
    );
  }
}

