import 'package:flutter/material.dart';
import 'package:chat_flutter_app/content/model/content_detail_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'package:chat_flutter_app/RequestHelper.dart';
import 'package:flutter/cupertino.dart';

class ContentDetailController extends StatefulWidget {

  int mId;

  ContentDetailController({this.mId});

  @override
  createState() => new _ContentDetailControllerState();
}

class _ContentDetailControllerState extends State<ContentDetailController> {

  ContentDetailModel _contentDetailModel;

  List<Widget> contextWidgetList = [];

  Future<Null> loadContentDetailDataFromService () async {
    var submitDic = {'mId':widget.mId};
    ResponeObject asyncRequest = await RequestHelper.asyncRequest(
        true, 'media/getMediaInfo', submitDic, true);
    if (asyncRequest.isSuccess) {
      if (contextWidgetList.length > 0) {
        contextWidgetList.clear();
      }
      Map<String, dynamic> dataDic = asyncRequest.content['data'];
      ContentDetailModel contentDetailModel = ContentDetailModel.modelFronJson(dataDic);
      _contentDetailModel = contentDetailModel;

      setState(() {
        contextWidgetList.add(UserInfoSection(contentDetailModel));
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
      maxRadius: 40.0,
      backgroundColor: Colors.white,
      backgroundImage: new CachedNetworkImageProvider(contentDetailModel.user.uHeadUrl),
    ));

    widgets.add(new Expanded(child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          contentDetailModel.user.uNickName,
          maxLines: 1,
          style: TextStyle(fontSize: 15.0,color: Color(0xff3b3b3b)),
        ),
        new Text(contentDetailModel.createTime,
          maxLines: 1,
          style: TextStyle(fontSize: 12.0,color: Color(0xff8d8d8d)),
        )
      ],
    )));

    widgets.add(new FlatButton(
        onPressed: null,
        child: Image.asset(contentDetailModel.isSubscribe > 0 ?'images/content_follow.png':'images/content_notfollow.png')));

    return new Container(
      padding: const EdgeInsets.all(5.0),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            maxRadius: 40.0,
            backgroundColor: Colors.white,
            backgroundImage: new CachedNetworkImageProvider(contentDetailModel.user.uHeadUrl),
          ),
          new Expanded(child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          )),
        ],
      ),
    );
  }


  Widget mediaSection (ContentDetailModel contentDetailModel) {
    return Container (
      padding: const EdgeInsets.all(5.0),
    );
  }

  Widget contentAndMoreSection (ContentDetailModel contentDetailModel) {
    return Container (
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          new Text(
            contentDetailModel.mDescribe,
            style: TextStyle(color: Color(0xff3e3e3e),fontSize: 14.0),
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold (
        appBar: new AppBar(
          title: new Text('动态详情'),),
        body: new Center(
          child: new RefreshIndicator(
              child: new FutureBuilder(
                  future: null,
                  builder: (BuildContext context,AsyncSnapshot<Null> snapshot) {
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
              onRefresh: loadContentDetailDataFromService),
        )
    );
  }
}