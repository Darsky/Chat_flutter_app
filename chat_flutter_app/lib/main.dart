import 'package:flutter/material.dart';
import 'root_tab.dart';
import 'public/use_info.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    UserInfoManager();

    return new MaterialApp(
      title: "知乎-高仿版",
      home: new RootTabController(),
    );
  }
}

