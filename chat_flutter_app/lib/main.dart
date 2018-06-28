import 'package:flutter/material.dart';
import './home/home_controller.dart';
import './timeline/timeline_controller.dart';
import './mine/mine_controller.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new DefaultTabController(
          length: 3,
          child: new Scaffold(
            bottomNavigationBar: new Material(
              color: Colors.white,
              child: new TabBar(tabs: [
                new Tab(icon: new Icon(Icons.home, color: Colors.grey,), text: '首页',),
                new Tab(icon: new Icon(Icons.camera, color: Colors.grey,), text: '圈子',),
                new Tab(icon: new Icon(Icons.person, color: Colors.grey,), text: '我的',),
              ]),
            ),
            body: new TabBarView(children: [
              new HomeController(),
              new TimelineController(),
              new MineController(),
            ]),
          )
      ),
    );
  }
}
