import 'package:flutter/material.dart';

class TimelineController extends StatefulWidget
{
  @override
  createState() => _TimeLineControllerState();
}

class _TimeLineControllerState extends State<TimelineController> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fetch Data Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Fetch Data Example'),
        ),
        body: new Center(
          child: new Text('Timeline'),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
