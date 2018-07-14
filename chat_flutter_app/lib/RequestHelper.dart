import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:chat_flutter_app/public/use_info.dart';

class ResponeObject{
  bool isSuccess;
  var  content;
  ResponeObject({this.isSuccess,this.content});
}


class RequestHelper {

  static  Future<ResponeObject> asyncRequest(bool isGetRequest,String actionUrl,Map<String, dynamic> param, bool tokenNeed) async{
    String url = 'https://service.newmoho.toyohu.com/';
    if (actionUrl != null){
      url+=actionUrl;
    }
    if(tokenNeed) {
      UserInfo userInfo = await UserInfoManager().loadUserInfo();
      if (userInfo != null && userInfo.token != null) {
        url += '?accesstoken=${userInfo.token}';
      }
    }
    Dio dio = new Dio();
    ResponeObject resultObject;
    print('开始请求 $url');
    try {
      Response response;
      if (isGetRequest){
        response = await dio.get(url, data: param);
      }
      else {
        response = await dio.post(url,data: param);
      }
      if (response.statusCode == HttpStatus.OK){
        var json = await response.data;
        if (json['code'].toString() == '1'){
          resultObject = new ResponeObject(isSuccess: true,content: json);
        }
        else {
          resultObject = new ResponeObject(isSuccess: false,content: json['msg']);
        }
      }
      else{
        resultObject = new ResponeObject(isSuccess: false,content: '${response.statusCode.toString()}');
      }
    }
    catch (exception) {
      resultObject = new ResponeObject(isSuccess: false,content: '服务器连接失败，请稍后再试');
    }

    return resultObject;
  }
}