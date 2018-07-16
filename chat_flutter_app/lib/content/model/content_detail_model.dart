import 'package:chat_flutter_app/public/media_model.dart';

class ContentDetailModel {
  String createTime;
  int gId;
  String gName;
  int isSubscribe;
  String mAddr;
  String mCode;
  int mCommentNum;
  String mDescribe;
  int mFavoritesNum;
  int mId;
  int mLikeNum;
  String mType;
  List<MediaModel> media;
  int uId;
  UserModel user;
  int isLike;
  int isFavorites;
  ContentDetailModel();
  ContentDetailModel.modelFronJson(Map<String, dynamic> json){
    createTime = json['createTime'] as String;
    gId = json['gId'] as int;
    gName = json['gName'] as String;
    isSubscribe = json['isSubscribe'] as int;
    mAddr = json['mAddr'] as String;
    mCode = json['mCode'] as String;
    mCommentNum = json['mCommentNum'] as int;
    mDescribe = json['mDescribe'] as String;
    mFavoritesNum = json['mFavoritesNum'] as int;
    mLikeNum = json['mLikeNum'] as int;
    mType = json['mType'] as String;
    media = [];
    if (json['media'] != null) {
      List<dynamic> mediaList = json['media'];
      for (int x = 0; x<mediaList.length;x++){
        media.add(new MediaModel.modelFromJson(mediaList[x]));
      }
    }
    uId = json['uId'] as int;
    if (json['user'] != null) {
      user = UserModel.modelFromJson(json['user']);
    }
    isLike = json['isLike'] as int;
    isFavorites = json['isFavorites'] as int;
  }
}

class UserModel {
  String uNickName;
  String uHeadUrl;
  String isSubscribe;


  UserModel();
  UserModel.modelFromJson(Map<String, dynamic> json) {
    uNickName = json['uNickName'] as String;
    uHeadUrl  = json['uHeadUrl'] as String;
    isSubscribe  = json['isSubscribe'] as String;
  }
}