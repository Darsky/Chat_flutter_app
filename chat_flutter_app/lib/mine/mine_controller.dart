import 'package:flutter/material.dart';
import 'package:chat_flutter_app/login/login_controller.dart';

class MineController extends StatefulWidget
{
  @override
  createState()=>new _MineControllerState();
}
class _MineControllerState extends State<MineController>
{
  @override
  Widget build(BuildContext context) {
    Widget topSection = new Container(
        color: Colors.lightBlue,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Column(
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(top: 68.0),
                    child: new CircleAvatar(
                      maxRadius: 39.0,
                      backgroundImage: new AssetImage('images/homeHeader.png'),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    child: new Text(
                      '用户名称',
                      style: new TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.fromLTRB(13.0, 12.0, 13.0, 17.0),
                    child: new Text(
                      '个性签名',
                      style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  )
                  // ignore: argument_type_not_assignable
                ],
              ),
            )
          ],
        ));


    Column functionButton(String imageName, String title) {
      return new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: Colors.grey, width: 0.3),
              borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
            ),
            alignment: Alignment.center,
            child: new Image.asset(imageName,
                alignment: Alignment.center, width: 34.0, height: 34.0),
            width: 80.0,
            height: 80.0,
          ),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              title,
              style:
              new TextStyle(fontSize: 16.0, color: const Color(0xff585757)),
            ),
          )
        ],
      );
    }

    GestureDetector functionButtonColumn(String imageName, String title)
    {
      return new GestureDetector(
        onTap: () {
          print(title);
        },
        child:functionButton(imageName, title),
      );
    }

    Container sectionHeader(String title) {
      return new Container(
        margin: const EdgeInsets.only(left: 3.0),
        child: new Row(
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(left: 6.5),
              decoration: new BoxDecoration(color: const Color(0xff068afe)),
              width: 3.0,
              height: 17.0,
            ),
            new Container(
              margin: const EdgeInsets.only(left: 6.5),
              child: new Text(
                title,
                style: new TextStyle(
                    fontSize: 16.0, color: const Color(0xff585757)),
              ),
            )
          ],
        ),
      );
    }

    Widget functionSection = new Container(
      height: 120.0,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          functionButtonColumn('images/home_import.png', '添加照片'),
          functionButtonColumn('images/home_card.png', '浏览照片'),
          functionButtonColumn('images/home_task.png', '发日志'),
        ],
      ),
    );

    Widget mineClassView = new Card(
      child: new SizedBox.fromSize(
        size: Size(166.0, 111.0),
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Container(
              child: new Image.asset(
                'images/picture_demo.png',
                fit: BoxFit.cover,
              ),
            ),
            new Container(
              padding: const EdgeInsets.all(0.0),
              decoration: new BoxDecoration(
                color: Colors.black45,
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Group Name',
                    style: new TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                  new Text(
                    'Member Count',
                    style: new TextStyle(color: Colors.white, fontSize: 9.0),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );


    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
        ),
        home: new Scaffold(
          body: new ListView(
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              new UserInfoSection(),
              functionSection,
              sectionHeader('我管理的群组'),
              mineClassView,
              sectionHeader('我加入的群组'),
              mineClassView,
            ],
          ),
        ));
  }
}

class UserInfoSection extends StatefulWidget
{
  @override
  createState () =>new UserInfoSectionState();
}

class UserInfoSectionState extends State<UserInfoSection>
{
  bool _logined = false;
  String _userName = '请登录';
  String _userDes  = '';

  void _pushToLogin(){
    if (!_logined){
      Navigator.of(context).push(
        new MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) {
              return new LoginController();
              },
        )
      );
    }
  }

  void _setupDisplayWithUserInfo()
  {
    _logined = !_logined;
    setState(() {
      if (_logined) {
        _userName = '卖萌的二师兄';
        _userDes = '萌帅萌帅的';
      }
      else {
        _userName = '请登录';
        _userDes = '';
      }
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return new Container(
        color: Colors.lightBlue,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Column(
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(top: 68.0),
                    child: new FlatButton(
                      onPressed: _pushToLogin,
                      child: new CircleAvatar(
                      maxRadius: 39.0,
                      backgroundImage: new AssetImage('images/homeHeader.png'),
                    ),)
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    child: new Text(
                      _userName,
                      style: new TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.fromLTRB(13.0, 12.0, 13.0, 17.0),
                    child: new Text(
                      _userDes,
                      style: new TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  )
                  // ignore: argument_type_not_assignable
                ],
              ),
            )
          ],
        ));
  }
}

