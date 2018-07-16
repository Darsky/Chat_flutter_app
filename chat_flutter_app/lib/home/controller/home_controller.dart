import 'package:flutter/material.dart';
import 'dart:async';
import 'package:chat_flutter_app/home/view/home_buttons.dart';
import 'package:chat_flutter_app/home/model/home_article.dart';
import 'package:chat_flutter_app/public/use_info.dart';
import 'package:chat_flutter_app/RequestHelper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:chat_flutter_app/content/controller/content_detail_controller.dart';


class HomeController extends StatefulWidget
{
  @override
  createState() =>new _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> with AutomaticKeepAliveClientMixin{

  List<Article> _dataArray = new List();

  int   _pageIndex = 1;

  bool  _canLoadMore = true;

  RefreshIndicator listTaleView;


  Future<Null> startLoadDataFromService () async {
    print('开始加载');
    _pageIndex = 1;
    _canLoadMore = true;
    ResponeObject asyncRequest = await RequestHelper.asyncRequest(
        true, 'recommendation/index', null, true);
    if (asyncRequest.isSuccess) {
      setState(() {
        List<Article> resultArray = new List();
        Map<String, dynamic> dataDic = asyncRequest.content['data'];
        List<dynamic> dataArray = dataDic['hotContent'];
        for (int i = 0; i < dataArray.length; i++) {
          resultArray.add(new Article.modelFronJson(dataArray[i]));
        }
        _dataArray = resultArray;
        if (resultArray.length >= 10) {
          _canLoadMore = true;
          _pageIndex ++;
        }
        else {
          _canLoadMore = false;
        }
      });
      return Future.delayed(Duration(milliseconds: 100), () {

      });
    }
    else
    {
      showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return new CupertinoAlertDialog(
              title: new Text('温馨提示'),
              content: new Text(asyncRequest.content),
            );
          });
      return Future.delayed(Duration(milliseconds: 100), () {

      });
    }
  }

  Future<Null> loadDataFromService() async {
    if (_canLoadMore == false) {
      return Future.delayed(Duration(milliseconds: 100), () {

      });
    }
    var submitDic = {'page':_pageIndex};
    ResponeObject asyncRequest = await RequestHelper.asyncRequest(
        true, 'recommendation/hotContent', submitDic, true);
    if (asyncRequest.isSuccess) {
      setState(() {
        List<Article> resultArray = new List();
        List<dynamic> dataArray = asyncRequest.content['data'];
        for (int i = 0; i < dataArray.length; i++) {
          resultArray.add(new Article.modelFronJson(dataArray[i]));
        }
        _dataArray.addAll(resultArray);
        if (resultArray.length >= 10) {
          _canLoadMore = true;
          _pageIndex ++;
        }
        else {
          _canLoadMore = false;
        }
      });
      return Future.delayed(Duration(milliseconds: 100), () {

      });
    }
    else
    {
      showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return new CupertinoAlertDialog(
              title: new Text('温馨提示'),
              content: new Text(asyncRequest.content),
            );
          });
      return Future.delayed(Duration(milliseconds: 100), () {

      });
    }
  }


  Future<Null> likeOrCancelLike (Article article) async {
    UserInfo userInfo = await UserInfoManager().loadUserInfo();
    if (userInfo == null) {
      showDialog(context: context,builder: (BuildContext context){
        return new AlertDialog(
          title: new Text('温馨提示'),
          content: new Text('您还未登录，请登录后操作'),
        );
      });
    }
    else if (article.isFavorites > 0) {
      var submitDic = {
        'mId':'${article.mId}',
        'mfType':'media'
      };
      ResponeObject asyncRequest = await RequestHelper.asyncRequest(false, 'mediaFavorites/cancel', submitDic, true);
      if (asyncRequest.isSuccess) {
        showDialog(context: context,
            builder: (BuildContext context){
              return new AlertDialog(
                title: new Text('温馨提示'),
                content: new Text('操作成功'),
              );
            });
        setState(() {
          article.isFavorites = 0;
          article.mFavoritesNum --;
        });
      }
      else {
        showDialog(context: context,
            builder: (BuildContext context){
              return new AlertDialog(
                title: new Text('温馨提示'),
                content: new Text('${asyncRequest.content}'),
              );
            });
      }
    }
    else {
      var submitDic = {
        'mId':'${article.mId}',
        'mfType':'media'
      };
      ResponeObject asyncRequest = await RequestHelper.asyncRequest(false, 'mediaFavorites/create', submitDic, true);
      if (asyncRequest.isSuccess) {
        showDialog(context: context,
            builder: (BuildContext context){
              return new AlertDialog(
                title: new Text('温馨提示'),
                content: new Text('收藏成功'),
              );
            });
        setState(() {
          article.isFavorites = 1;
          article.mFavoritesNum ++;
        });
        return Future.delayed(Duration(milliseconds: 100), () {

        });
      }
      else {
        showDialog(context: context,
            builder: (BuildContext context){
              return new AlertDialog(
                title: new Text('温馨提示'),
                content: new Text('${asyncRequest.content}'),
              );
            });
        return Future.delayed(Duration(milliseconds: 100), () {

        });
      }
    }
  }

  void didSelectContentAtIndex (int index) {
    Article article = _dataArray[index];
    ContentDetailController controller = new ContentDetailController(mId: article.mId);
    Navigator.of(context,rootNavigator: true).push(
      new MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return controller;
        },
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (listTaleView == null) {
      listTaleView = new RefreshIndicator(
        child: new FutureBuilder(
          future: loadDataFromService(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Article>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('none');
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:{
                return new ListView.builder(
                    itemCount: _dataArray.length > 0 ? _dataArray
                        .length : 0,
                    itemBuilder: (context, i) {
                      Article article = _dataArray[i];
                      return TimelineCard(
                        article: article,
                        didSelectItem: () => didSelectContentAtIndex(i),
                        didTouchOnComment: null,
                      );
                    }
                );
              }
              default :
                if (snapshot.hasError) {
                  return Text('Error');
                }
            }
          },
        ),
        onRefresh: startLoadDataFromService,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '首页',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('首页'),
          ),
          body: Center(
            child: listTaleView,
          ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class TimelineCard extends StatefulWidget {
  Article article;
  VoidCallback didSelectItem;
  VoidCallback didTouchOnComment;
  TimelineCard({this.article,this.didSelectItem,this.didTouchOnComment});
  @override
  createState() => new _TimelineCardState();
}

class _TimelineCardState extends State<TimelineCard> {

  Future<Null> didTouchOnLikeButton (Article article) async {
    UserInfo userInfo = await UserInfoManager().loadUserInfo();
    if (userInfo == null) {
      showDialog(context: context,builder: (BuildContext context){
        return new AlertDialog(
          title: new Text('温馨提示'),
          content: new Text('您还未登录，请登录后操作'),
        );
      });
    }
    else if (article.isFavorites > 0) {
      var submitDic = {
        'mId':'${article.mId}',
        'mfType':'media'
      };
      ResponeObject asyncRequest = await RequestHelper.asyncRequest(false, 'mediaFavorites/cancel', submitDic, true);
      if (asyncRequest.isSuccess) {
        showDialog(context: context,
            builder: (BuildContext context){
              return new AlertDialog(
                title: new Text('温馨提示'),
                content: new Text('操作成功'),
              );
            });
        setState(() {
          article.isFavorites = 0;
          article.mFavoritesNum --;
        });
      }
      else {
        showDialog(context: context,
            builder: (BuildContext context){
              return new AlertDialog(
                title: new Text('温馨提示'),
                content: new Text('${asyncRequest.content}'),
              );
            });
      }
    }
    else {
      var submitDic = {
        'mId':'${article.mId}',
        'mfType':'media'
      };
      ResponeObject asyncRequest = await RequestHelper.asyncRequest(false, 'mediaFavorites/create', submitDic, true);
      if (asyncRequest.isSuccess) {
        showDialog(context: context,
            builder: (BuildContext context){
              return new AlertDialog(
                title: new Text('温馨提示'),
                content: new Text('收藏成功'),
              );
            });
        setState(() {
          article.isFavorites = 1;
          article.mFavoritesNum ++;
        });

      }
      else {
        showDialog(context: context,
            builder: (BuildContext context){
              return new AlertDialog(
                title: new Text('温馨提示'),
                content: new Text('${asyncRequest.content}'),
              );
            });

      }
    }
  }

  Container UserInfoRow(Article article) {
    return new Container(
      padding: const EdgeInsets.all(13.0),
      child: Row(
        children: <Widget>[
          new CircleAvatar(
            maxRadius: 20.0,
            backgroundColor: Colors.white,
            backgroundImage: new CachedNetworkImageProvider(article.user.uHeadUrl),
          ),

          new Expanded(child: new Container(
            padding: const EdgeInsets.only(left: 10.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(article.user.uNickName, style: new TextStyle(
                      fontSize: 14.0, color: Colors.black45)),
                ),
                new Text('From Group',
                  style: new TextStyle(fontSize: 11.0, color: Colors.grey),)
              ],
            ),
          )),
          new Text('2018-06-30'),
        ],
      ),
    );
  }

  Container contentRow(String content) {
    return new Container(
      height: 50.0,
      padding: const EdgeInsets.all(13.0),
      alignment: Alignment.centerLeft,
      child: new Text(
        content,
        maxLines: 2,
        style: new TextStyle(fontSize: 16.0, color: Colors.black45),
      ),
    );
  }

  Container likeAndCommentRow(Article article) {
    return new Container(
      height: 60.0,
      margin: const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
      alignment: Alignment.centerRight,
      child: new ButtonBar(
        alignment: MainAxisAlignment.end,
        children: <Widget>[
          new FlatButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: () => didTouchOnLikeButton(widget.article),
              child: new HomeLikeWidget(
                isLiked: article.isFavorites > 0?true:false,
                likeCount: article.mFavoritesNum,)),
          new FlatButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: widget.didTouchOnComment,
              child: new HomeLikeWidget(
                isLiked: false,
                likeCount: article.mCommentNum,))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Card(
      margin: const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 5.0),
      child: new SizedBox(
        child: GestureDetector(
          onTap: widget.didSelectItem,
          child: Column(
            children: <Widget>[
              UserInfoRow(widget.article),
              new Container(
                padding: const EdgeInsets.all(13.0),
                height: 120.0,
                child: new CachedNetworkImage(
                  imageUrl: widget.article.coverUrl == null?'':widget.article.coverUrl,
                  fit: BoxFit.contain,
                  placeholder: new Image.asset('images/img_loading@3x.png'),
                  fadeInDuration: const Duration(seconds: 0),
                  fadeOutDuration: const Duration(seconds: 0),
                ),
              ),
              contentRow(widget.article.mDescribe),
              likeAndCommentRow(widget.article),
            ],
          ),
        ),
      ),
    );
  }
}