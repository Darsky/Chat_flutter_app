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

  Timer codeTimer;

  int countDownSecond = 0;

  Widget codeButton () {
    return new Container(
      width: 100.0,
      height: 35.0,
      decoration: new BoxDecoration(
        color: countDownSecond == 0?Colors.blueAccent:Colors.grey[400],
        borderRadius: BorderRadius.all(const Radius.circular(10.0)),
      ),
      child: new FlatButton(
          onPressed: _didCodeButtonTouch,
          child: new Text(
            countDownSecond == 0 ?'获取验证码':'${countDownSecond}s',
            style: new TextStyle(color: countDownSecond == 0? Colors.white:Colors.grey,fontSize: 12.0),
          )),
    );
  }

  void _didCodeButtonTouch(){
    if (countDownSecond != 0){
      return;
    }
    if (_inputUserName == null || _inputUserName.length == 0){
      showDialog(context: context,
        builder: (BuildContext context){
          return new AlertDialog(
            title: new Text('温馨提示'),
            content: new Text('请输入手机号'),
          );
        },
      );
    }
    else if (_inputUserName.length != 11){
      showDialog(context: context,
        builder: (BuildContext context){
          return new AlertDialog(
            title: new Text('温馨提示'),
            content: new Text('请输入正确的手机号'),
          );
        },
      );
    }
    else {
      _startGetCode();
    }
  }

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
            content: new Text('请输入验证码'),
          );
        },
      );
      return;
    }
    _startLogin();
  }

  void _startGetCode() {

    new Future.delayed(const Duration(seconds:2),
            (){
              showDialog(context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context){
                    return new AlertDialog(
                      title: new Text('温馨提示'),
                      content: new Text('验证码获取成功'),
                    );

              });
              countDownSecond = 20;
              if (codeTimer == null){
                codeTimer = new Timer.periodic(const Duration(seconds: 1), (timer){
                  if (countDownSecond > 0){
                    print('倒数计时$countDownSecond');
                    countDownSecond--;
                    setState(() {

                    });
                  }
                  else{
                    timer.cancel();
                    codeTimer = null;
                  }
                });
              }
        }
    );



//    var submitDic = {"mobile":_inputUserName};
//    ResponeObject asyncRequest = await RequestHelper.asyncRequest(true, 'user/getValidCode', submitDic,true);
//    String alertStirng;
//    if (asyncRequest.isSuccess){
//      alertStirng = '请求验证码成功';
//    }
//    else {
//      alertStirng = '${asyncRequest.content}';
//    }
//    setState(() {
//      showDialog(context: context,
//        builder: (BuildContext context){
//          return new AlertDialog(
//            title: new Text('温馨提示'),
//            content: new Text(alertStirng),
//          );
//        },
//      );
//      if(asyncRequest.isSuccess){
//        codeButton.touchEnable = false;
//      }
//    });
  }


  void _startLogin() async{

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameField = new TextField(
      controller: null,
      decoration: new InputDecoration(
        hintText: '请输入手机号',
      ),
      keyboardType: TextInputType.number,
      style: new TextStyle(fontSize: 14.0,color: Colors.black45),
      onChanged: (String inputString){
        _inputUserName = inputString;
      },
    );
    passwordField = new TextField(
      decoration: new InputDecoration(
        hintText: '请输入验证码',
      ),
      maxLength: 6,
      maxLengthEnforced: false,
      keyboardType: TextInputType.number,
      style: new TextStyle(fontSize: 14.0,color: Colors.black45),
      onChanged: (String inputPassword){
        _inputPassword = inputPassword;
      },
    );
  }

  @override
  Widget build(BuildContext context) {

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
              child: new Row(
                children: <Widget>[
                  new Expanded(child: passwordField),
                  codeButton(),
                ],
              ),
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

