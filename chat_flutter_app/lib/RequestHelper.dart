import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

class ResponeObject{
  bool isSuccess;
  var  content;
  ResponeObject({this.isSuccess,this.content});
}


class RequestHelper {

  RequestHelper();
  static  Future<ResponeObject> asyncRequest(bool isGetRequest,String actionUrl,Map<String, dynamic> param, bool tokenNeed) async{
    String url = 'https://service.newmoho.toyohu.com/';
    Dio dio = new Dio();
    ResponeObject resultObject;
    try {
      Response response;
      if (isGetRequest){
        response = await dio.get(url+actionUrl, data: param);
      }
      else {
        response = await dio.post(url+actionUrl,data: param);
      }
      if (response.statusCode == HttpStatus.OK){
        var json = await response.data;
        resultObject = new ResponeObject(isSuccess: true,content: json);
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