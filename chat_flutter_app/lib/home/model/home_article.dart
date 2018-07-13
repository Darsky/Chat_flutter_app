import 'package:chat_flutter_app/public/media_model.dart';

class Article {
  int mId;
  String mCode;
  int uId;
  int gId;
  String mType;
  String mDescribe;
  int mFavoritesNum;
  int mCommentNum;
  String createTime;
  List<MediaModel> media;
  UserModel user;
  String gName;
  int isFavorites;

  String coverUrl;

  Article();

  Article.modelFronJson(Map<String, dynamic> json){
    mId = json['mId'] as int;
    mCode = json['mCode'] as String;
    uId = json['uId'] as int;
    gId = json['gId'] as int;
    mType = json['mType'] as String;
    mDescribe = json['mDescribe'] as String;
    mFavoritesNum = json['mFavoritesNum'] as int;
    mCommentNum  = json['mCommentNum'] as int;
    createTime = json['createTime'] as String;
    media = [];

    if (json['media'] != null) {
      List<dynamic> mediaList = json['media'];
      for (int x = 0; x<mediaList.length;x++){
        media.add(new MediaModel.modelFromJson(mediaList[x]));
      }
      if (media.length > 0) {
        if (mType == 'video'){

          coverUrl = media[0].mdUrl + '?vframe/png/offset/1';
        }
        else {
          coverUrl = media[0].mdUrl;
        }
      }
    }
    if (json['user'] != null) {
      user = UserModel.modelFromJson(json['user']);
    }
    gName = json['gName'] as String;
    isFavorites = json['isFavorites'] as int;
  }
}

class UserModel {
  String uNickName;
  String uHeadUrl;

  UserModel();
  UserModel.modelFromJson(Map<String, dynamic> json) {
    uNickName = json['uNickName'] as String;
    uHeadUrl  = json['uHeadUrl'] as String;
  }
}