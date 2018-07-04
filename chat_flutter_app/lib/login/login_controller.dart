import 'package:flutter/material.dart';


class LoginController extends StatelessWidget
{
  final TextEditingController _controller = new TextEditingController();

  TextField userNameField = new TextField(
  controller: null,
  decoration: new InputDecoration(
  hintText: '请输入用户名',
  ),
  style: new TextStyle(fontSize: 14.0,color: Colors.black45),
  );

  TextField passwordField = new TextField(
    decoration: new InputDecoration(
      hintText: '请输入密码',
    ),
    obscureText: true,
    style: new TextStyle(fontSize: 14.0,color: Colors.black45),
  );

  void _didLoginButtonTouch(){

  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Fetch Data Example',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
            title: new Text('登录')
        ),
        body: new Form(
          child: new Column(
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                margin: const EdgeInsets.only(top: 40.0),
                height: 60.0,
                child: userNameField,
              ),
              new Container(
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                height: 60.0,
                child: passwordField,
              ),
              new Container(
                margin: const EdgeInsets.only(top: 40.0),
                padding: const EdgeInsets.fromLTRB(40.0, 5.0, 40.0, 5.0),
                height: 60.0,
                decoration: new BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(const Radius.circular(10.0)),
                ),
                child: new FlatButton(
                    onPressed: _didLoginButtonTouch,
                    child: new Text('登录',style: new TextStyle(color: Colors.white),),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
