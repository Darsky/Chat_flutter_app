import 'package:flutter/material.dart';
import 'package:chat_flutter_app/RequestHelper.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';

class LoginController extends StatefulWidget
{
  @override
  createState() => new _LoginControllerState();
}


class _LoginControllerState extends State<LoginController>
{
  final TextEditingController _controller = new TextEditingController();

  String _inputUserName;
  String _inputPassword;

  TextField userNameField;

  TextField passwordField;

  void _didLoginButtonTouch(){
    if (_inputUserName == null || _inputUserName.length == 0){
      showDialog(context: context,
        builder: (BuildContext context){
        return new AlertDialog(
          title: new Text('温馨提示'),
          content: new Text('请输入用户名'),
        );
        },
      );
      return;
    }
    if (_inputPassword == null || _inputPassword.length == 0){
      showDialog(context: context,
        builder: (BuildContext context){
          return new AlertDialog(
            title: new Text('温馨提示'),
            content: new Text('请输入密码'),
          );
        },
      );
      return;
    }
    _startLogin();
  }

  void _startLogin() async{
    var submitDic = {"mobile":_inputUserName};
    ResponeObject asyncRequest = await RequestHelper.asyncRequest(true, 'user/getValidCode', submitDic,true);
    setState(() {
      showDialog(context: context,
        builder: (BuildContext context){
          return new AlertDialog(
            title: new Text('温馨提示'),
            content: new Text('${asyncRequest.content}'),
          );
        },
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    userNameField = new TextField(
      controller: null,
      decoration: new InputDecoration(
        hintText: '请输入用户名',
      ),
      style: new TextStyle(fontSize: 14.0,color: Colors.black45),
      onChanged: (String inputString){
        _inputUserName = inputString;
      },
    );
    passwordField = new TextField(
      decoration: new InputDecoration(
        hintText: '请输入密码',
      ),
      obscureText: true,
      style: new TextStyle(fontSize: 14.0,color: Colors.black45),
      onChanged: (String inputPassword){
        _inputPassword = inputPassword;
      },
    );
    return  new Scaffold(
        appBar: new AppBar(
            title: new Text('登录')
        ),
        body: new ListView(
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
              margin: const EdgeInsets.fromLTRB(40.0,40.0,40.0,0.0),
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
        ),
      bottomNavigationBar: null,
      );
  }
}
