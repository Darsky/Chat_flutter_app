import 'package:flutter/material.dart';
import 'package:chat_flutter_app/home/controller/home_controller.dart';
import './timeline/timeline_controller.dart';
import './mine/mine_controller.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget
{
  @override
  createState() => new _MyAppState();
}
class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin{
  // This widget is the root of your application.

  TabBar bottomTabbar;
  TabController controller;
  List<StatefulWidget> pages;


  @override
  void initState() {
    // TODO: implement initState
    controller = new TabController(length: 3, vsync: this);
    bottomTabbar = new TabBar(
      indicatorColor: Colors.white,
      labelColor: Colors.blueAccent,
      unselectedLabelColor: Colors.grey,
      controller: controller,
      tabs: <Widget>[
        new Tab(
          icon: new Icon(Icons.home),
          text: '首页',
        ),
        new Tab(
          icon: new Icon(Icons.camera),
          text:'圈子',
        ),
        new Tab(
          icon: new Icon(Icons.person),
          text: '我的',
        ),
      ],
    );
    pages = <StatefulWidget>[
      new HomeController(),
      new TimelineController(),
      new MineController()];
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new TabBarView(
          controller: controller,
          children: pages,
        ),
        bottomNavigationBar: new Material(
          color: Colors.white,
          child: bottomTabbar,
        ),
      ),
    );
  }
}
