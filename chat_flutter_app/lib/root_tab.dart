import 'package:flutter/material.dart';
import 'package:chat_flutter_app/home/controller/home_controller.dart';
import 'package:chat_flutter_app/timeline/timeline_controller.dart';
import 'package:chat_flutter_app/mine/mine_controller.dart';

class RootTabController extends StatefulWidget {
  @override
  createState() => new _RootTabControllerState();
}

class _RootTabControllerState extends State<RootTabController> with SingleTickerProviderStateMixin{

  TabBar bottomTabbarView;
  TabController controller;
  List<StatefulWidget> pages;


  @override
  void initState() {
    // TODO: implement initState
    controller = new TabController(length: 3, vsync: this);
    bottomTabbarView = new TabBar(
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
          child: bottomTabbarView,
        ),
      ),
    );
  }
}
