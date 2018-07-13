import 'package:flutter/material.dart';
import 'package:chat_flutter_app/home/controller/home_controller.dart';
import 'package:chat_flutter_app/timeline/timeline_controller.dart';
import 'package:chat_flutter_app/mine/mine_controller.dart';

class RootTabController extends StatefulWidget {
  @override
  createState() => new _RootTabControllerState();
}

class _RootTabControllerState extends State<RootTabController> with SingleTickerProviderStateMixin {

  HomeController homeController;
  TimelineController timelineController;
  MineController mineController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController = new HomeController();
    timelineController = new TimelineController();
    mineController = new MineController();
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(length: 3,
        child: new Scaffold(
          bottomNavigationBar: new TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
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
          ],) ,
          body: new TabBarView(children: <Widget>[
            homeController,
            timelineController,
            mineController,
          ],),
    ));
  }

}
