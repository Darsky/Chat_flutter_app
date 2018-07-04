import 'package:flutter/material.dart';
import 'package:chat_flutter_app/home/controller/home_controller.dart';
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
              type: MaterialType.canvas,
              color: Colors.white,
              child: new TabBar(
                  isScrollable: false,
                  indicatorColor: Colors.white,
                  labelColor: Colors.blueAccent,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    new Tab(
                      icon: new Icon(
                        Icons.home,
                      ),
                      text: '首页',
                    ),
                    new Tab(
                      icon: new Icon(
                        Icons.camera,
                      ),
                      text: '圈子',
                    ),
                    new Tab(
                      icon: new Icon(
                        Icons.person,
                      ),
                      text: '我的',
                    ),
                  ]),
            ),
            body: new TabBarView(children: [
              new HomeController(),
              new TimelineController(),
              new MineController(),
            ]),
          )),
    );
  }
}
