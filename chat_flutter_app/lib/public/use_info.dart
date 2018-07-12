import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class UserInfoManager {
  UserInfo userInfo;
  bool isLogin;

  static final Map<String, UserInfoManager> _cache = <String, UserInfoManager>{};

  factory UserInfoManager(){
    if (_cache.containsKey('userInfo')){
      return _cache['userInfo'];
    }
    else {
      final UserInfoManager userInfoManager = new UserInfoManager._internal();
      _cache['userInfo'] = userInfoManager;
      return userInfoManager;
    }
  }

  void updateUserInfo(UserInfo userInfo) async{
    String dir = (await getApplicationDocumentsDirectory()).path;
    File userInfoFile = File('$dir/userInfo');
    await userInfoFile.writeAsString(jsonEncode(userInfo));
  }

  void loadUserInfo() async {

    String dir = (await getApplicationDocumentsDirectory()).path;
    UserInfo tempUserInfo;
    try {
      File userInfoFile = File('$dir/userInfo');
      String userInfoString = await userInfoFile.readAsString();
      tempUserInfo = json.decode(userInfoString);
    } catch (exception) {
      print('获取用户文件失败');
      isLogin = false;
    } finally {
      if (tempUserInfo != null){
        isLogin = true;
        userInfo = tempUserInfo;
      }
      else {
        isLogin = false;
      }
    }
  }

  UserInfoManager._internal() {
    loadUserInfo();
  }
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
}