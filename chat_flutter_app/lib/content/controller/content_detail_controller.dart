import 'package:flutter/material.dart';
import 'package:chat_flutter_app/content/model/content_detail_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'package:chat_flutter_app/RequestHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:chat_flutter_app/public/media_model.dart';
import 'package:chat_flutter_app/public/videoplayer_controller.dart';

class ContentDetailController extends StatefulWidget {

  int mId;

  ContentDetailController({this.mId});

  @override
  createState() => new _ContentDetailControllerState();
}

class _ContentDetailControllerState extends State<ContentDetailController> {

  ContentDetailModel _contentDetailModel;

  List<Widget> contextWidgetList = [];

  RefreshIndicator listTaleView;


  Future<Null> loadContentDetailDataFromService () async {
    var submitDic = {'mId':widget.mId};
    ResponeObject asyncRequest = await RequestHelper.asyncRequest(
        true, 'media/getMediaInfo', submitDic, true);
    if (asyncRequest.isSuccess) {
      setState(() {
        if (contextWidgetList.length > 0) {
          contextWidgetList.clear();
        }
        Map<String, dynamic> dataDic = asyncRequest.content['data'];
        ContentDetailModel contentDetailModel = ContentDetailModel.modelFronJson(dataDic);
        _contentDetailModel = contentDetailModel;
        contextWidgetList.add(UserInfoSection(contentDetailModel));
        contextWidgetList.add(mediaSection(contentDetailModel));
        contextWidgetList.add(contentAndMoreSection(contentDetailModel));
      });
      return Future.delayed(Duration(milliseconds: 100), () {

      });
    }
    else {
      showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return new CupertinoAlertDialog(
              title: new Text('温馨提示'),
              content: new Text(asyncRequest.content),
            );
          });
      if (contextWidgetList.length > 0) {
        contextWidgetList.clear();
      }
      contextWidgetList.add(new Text('网络加载错误'));
      return Future.delayed(Duration(milliseconds: 100), () {

      });
    }
  }

  Widget UserInfoSection (ContentDetailModel contentDetailModel) {
    List<Widget> widgets = [];
    widgets.add(new CircleAvatar(
      maxRadius: 20.0,
      backgroundColor: Colors.white,
      backgroundImage: new CachedNetworkImageProvider(contentDetailModel.user.uHeadUrl),
    ));

    widgets.add(new Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container (
          child: new Text(
            contentDetailModel.user.uNickName,
            maxLines: 1,
            style: TextStyle(fontSize: 15.0,color: Color(0xff3b3b3b)),
          ),
          padding: const EdgeInsets.only(left: 10.0),
          margin: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 8.0),
        ),
        new Container(
          padding: const EdgeInsets.only(left: 10.0),
          child: new Text(contentDetailModel.createTime,
            maxLines: 1,
            style: TextStyle(fontSize: 12.0,color: Color(0xff8d8d8d)),
          ),
        ),
      ],
    )));

    widgets.add(Container(
      width: 90.0,
      height: 38.0,
      child: new FlatButton(
        onPressed: null,
        child: Image.asset(contentDetailModel.isSubscribe > 0 ?'images/content_follow.png':'images/content_notfollow.png')),));

    return new Container(
      padding: const EdgeInsets.all(13.0),
      alignment: Alignment.center,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: widgets,
      ),
    );
  }


  Widget mediaSection (ContentDetailModel contentDetailModel) {
    List<Widget> mediaWidgets = [];
    if (contentDetailModel.mType == 'video' && contentDetailModel.media.length > 0) {
      MediaModel videoMediaModel = contentDetailModel.media[0];

      Stack videoWidget = new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container (
            child: new CachedNetworkImage(
              imageUrl: videoMediaModel.mdUrl == null?'':(videoMediaModel.mdUrl+'?vframe/png/offset/1'),
              fit: BoxFit.contain,
              placeholder: new Image.asset('images/img_loading@3x.png'),
              fadeInDuration: const Duration(seconds: 0),
              fadeOutDuration: const Duration(seconds: 0),
            ),
          ),
          Container (
            alignment: Alignment.center,
            width: 43.0,
            height: 43.0,
            child: Image.asset('images/img_videoplay.png'),
          ),
        ],
      );
      mediaWidgets.add(new GestureDetector(
        child: videoWidget,
        onTap: didVideoMediaTouch,
      ));
    }
    else if (contentDetailModel.mType == 'picture' && contentDetailModel.media.length > 0) {
      for (int i = 0 ; i<contentDetailModel.media.length; i++) {
        MediaModel imageMediaModel = contentDetailModel.media[i];
        Container imageWidget = Container(
          padding: const EdgeInsets.only(top: 5.0),
            child: new CachedNetworkImage(
                imageUrl: imageMediaModel.mdUrl == null?'':imageMediaModel.mdUrl,
                fit: BoxFit.contain,
                placeholder: new Image.asset('images/img_loading@3x.png'),
                fadeInDuration: const Duration(seconds: 0),
                fadeOutDuration: const Duration(seconds: 0),
            ));
        mediaWidgets.add(imageWidget);
      }
    }

    return Container (
      padding: const EdgeInsets.all(13.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: mediaWidgets,
      ),
    );
  }

  Widget contentAndMoreSection (ContentDetailModel contentDetailModel) {
    return Container (
      padding: const EdgeInsets.all(13.0),
      child: Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.topLeft,
            child: new Text(
              contentDetailModel.mDescribe,
              style: TextStyle(color: Color(0xff3e3e3e),fontSize: 14.0),
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new FlatButton(onPressed: null, child: new Text('收藏 ${contentDetailModel.mFavoritesNum}')),
              new FlatButton(onPressed: null, child: new Text('点赞 ${contentDetailModel.mLikeNum}')),
            ],
          )
        ],
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listTaleView = new RefreshIndicator(
        child: new FutureBuilder(
            future: loadContentDetailDataFromService(),
            builder: (BuildContext context,AsyncSnapshot<List<ContentDetailModel>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return new Text('没有任何数据');
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.done: {
                  return new ListView.builder(
                      itemCount: contextWidgetList.length > 0 ? contextWidgetList
                          .length : 0,
                      itemBuilder: (context, i) {
                        return contextWidgetList[i];
                      }
                  );
                }
                default :
                  if (snapshot.hasError) {
                    return Text('Error');
                  }
              }
            }
        ),
        onRefresh: loadContentDetailDataFromService);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold (
        appBar: new AppBar(
          title: new Text('动态详情'),),
        body: new Center(
          child: listTaleView,
        )
    );
  }

  void didVideoMediaTouch () {
    print('该看片啦!');
    if (_contentDetailModel.mType == 'video' && _contentDetailModel.media.length > 0) {
      MediaModel videoMediaModel = _contentDetailModel.media[0];
      ZWVideoPlayerController controller = new ZWVideoPlayerController(videoUrl: videoMediaModel.mdUrl,);
      Navigator.of(context,rootNavigator: true).push(
          new MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return controller;
            },
          )
      );
    }
    else {

    }
  }
}