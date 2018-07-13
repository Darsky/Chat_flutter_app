import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:chat_flutter_app/home/view/home_buttons.dart';
import 'package:chat_flutter_app/home/model/home_article.dart';
import 'package:chat_flutter_app/public/use_info.dart';
import 'package:chat_flutter_app/RequestHelper.dart';


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

  Container UserInfoRow(Article article) {
    return new Container(
      padding: const EdgeInsets.all(13.0),
      child: Row(
        children: <Widget>[
          new CircleAvatar(
            maxRadius: 20.0,
            backgroundImage: new NetworkImage(article.user.uHeadUrl),
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
      height: 40.0,
      padding: const EdgeInsets.all(13.0),
      alignment: Alignment.centerLeft,
      child: new Text(
        content,
        style: new TextStyle(fontSize: 16.0, color: Colors.black45),
      ),
    );
  }

  Container likeAndCommentRow(Article article) {
    return new Container(
      padding: const EdgeInsets.fromLTRB(0.0, 5.0, 13.0, 5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new FlatButton(onPressed: null,
              child: new HomeLikeWidget(
                isLiked: article.isFavorites > 0?true:false, likeCount: article.mFavoritesNum,)),
          new Icon(Icons.comment, color: Colors.grey[400],),
          new Container(
            margin: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            child: new Text(article.mCommentNum.toString()),
          ),
        ],
      ),
    );
  }
  Widget TimelineCard(Article article) {

    return Card(
      margin: const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 5.0),
      child: new SizedBox(
        child: Column(
          children: <Widget>[
            UserInfoRow(article),
            new Container(
              padding: const EdgeInsets.all(13.0),
              height: 120.0,
              child: new Image.network(article.coverUrl == null?'':article.coverUrl),
            ),
            contentRow(article.mDescribe),
            likeAndCommentRow(article),
          ],
        ),
      ),
    );
  }

  Future<List<Article>> loadDataFromService() async {
    Random random = new Random();
    int dataCount = random.nextInt(10);
    ResponeObject asyncRequest = await RequestHelper.asyncRequest(true, 'recommendation/index', null,true);
    if (asyncRequest.isSuccess) {
      List<Article> resultArray = new List();
      Map<String, dynamic> dataDic = asyncRequest.content['data'];
      List<dynamic> dataArray = dataDic['hotContent'];
      print('本次数据 ${dataArray.length}');
      for (int i = 0; i < dataArray.length; i++) {
        resultArray.add(new Article.modelFronJson(dataArray[i]));
      }
      if (resultArray.length >= 10){
        _canLoadMore = true;
      }
      else{
        _canLoadMore = false;
      }
      return resultArray;
    }
    else {
      return null;
    }
  }

  Future<Null> loadData() async {
    if (_canLoadMore){
      _pageIndex ++;
      loadDataFromService();
      setState(() {

      });
    }
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
                return Text('Waitting');
              case ConnectionState.done:{
                if (snapshot.data != null){
                  if (_pageIndex == 1){
                    _dataArray.clear();
                  }
                  _dataArray.addAll(snapshot.data);
                }
                return new ListView.builder(
                    itemCount: _dataArray.length > 0 ? _dataArray
                        .length : 0,
                    itemBuilder: (context, i) {
                      return TimelineCard(_dataArray[i]);
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
        onRefresh: loadData,
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
          body: listTaleView,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}