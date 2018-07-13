import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoManager {

  static Map<String, UserInfoManager> _cache = <String, UserInfoManager>{};
  factory UserInfoManager(){
    if (_cache.containsKey('userInfo')){
      print('有，不再造');
      return _cache['userInfo'];
    }
    else {
      print('没有，再造');
      final UserInfoManager userInfoManager = new  UserInfoManager._internal();
      userInfoManager.loadUserInfo();
      _cache['userInfo'] = userInfoManager;
      print(_cache.values);
      return userInfoManager;
    }
  }

  void updateUserInfo(UserInfo targetUserInfo) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userInfo', jsonEncode(targetUserInfo.toJson()));
  }


  Future<UserInfo> loadUserInfo() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserInfo userInfo;
    try {
      String userInfoString = prefs.get('userInfo');
      userInfo = UserInfo.modelFromJson(json.decode(userInfoString)) ;
    } catch (exception) {
      print('获取用户信息失败');

    } finally {
    }

    return userInfo;
  }

  UserInfoManager._internal();
}

class UserInfo {
  String uId;
  String uNickName;
  String uHeadUrl;
  bool   uSex;
  String uBirthDate;
  String uMobile;
  String uAuthentication;
  String openId;
  String unionId;
  String uSignature;
  String createTime;
  int subscribeNum;
  int beSubscribeCount;
  int mediaNum;
  String isSubscribe;
  String joinBlacklist;
  String favoritesNum;
  String groupNum;
  String activityNum;
  String mediaNumStr;
  String draftNum;
  String token;

  UserInfo();

  UserInfo.modelFromJson(Map<String, dynamic> json){
    uId = json['uId'] as String;
    uNickName = json['nickName'] as String;
    uHeadUrl = json['headUrl'] as String;
    uSex = json['uSex'] == 1? true:false;
    uBirthDate = json['uBirthDate'] as String;
    uMobile = json['mobile'] as String;
    uAuthentication = json['uAuthentication'];
    openId = json['openId'] as String;
    unionId = json['unionId'] as String;
    uSignature = json['uSignature'] as String;
    createTime = json['createTime'] as String;
    subscribeNum = json['subscribeNum'] as int;
    beSubscribeCount = json['beSubscribeCount'] as int;
    mediaNum = json['mediaNum'] as int;
    isSubscribe = json['isSubscribe'] as String;
    joinBlacklist = json['joinBlacklist'] as String;
    favoritesNum = json['favoritesNum'] as String;
    groupNum = json['groupNum'] as String;
    activityNum = json['activityNum'] as String;
    mediaNumStr = json['mediaNumStr'] as String;
    draftNum = json['draftNum'] as String;
    token = json['token'] as String;
  }

  Map<String, dynamic> toJson() {

    var val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }
    writeNotNull('uId', uId);
    writeNotNull('nickName', uNickName);
    writeNotNull('headUrl', uHeadUrl);
    writeNotNull('uSex', uSex);
    writeNotNull('uBirthDate', uBirthDate);
    writeNotNull('mobile', uMobile);
    writeNotNull('uAuthentication', uAuthentication);
    writeNotNull('openId', openId);
    writeNotNull('unionId', unionId);
    writeNotNull('uSignature', uSignature);
    writeNotNull('createTime', createTime);
    writeNotNull('subscribeNum', subscribeNum);
    writeNotNull('beSubscribeCount', beSubscribeCount);
    writeNotNull('mediaNum', mediaNum);
    writeNotNull('isSubscribe', isSubscribe);
    writeNotNull('joinBlacklist', joinBlacklist);
    writeNotNull('favoritesNum', favoritesNum);
    writeNotNull('groupNum', groupNum);
    writeNotNull('activityNum', activityNum);
    writeNotNull('mediaNumStr', mediaNumStr);
    writeNotNull('draftNum', draftNum);
    writeNotNull('token', token);

    return val;
  }
}


