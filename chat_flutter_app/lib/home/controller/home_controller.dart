import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:chat_flutter_app/home/view/home_buttons.dart';
import 'package:chat_flutter_app/home/model/home_article.dart';

class HomeController extends StatefulWidget
{
  @override
  createState() =>new _HomeControllerState();
}

class _HomeControllerState extends State<HomeController>{

  List<Article> _dataArray = new List();

  int   _pageIndex = 1;

  bool  _canLoadMore = true;
  @override
  Widget build(BuildContext context) {
    Container UserInfoRow(Article article) {
      return new Container(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          children: <Widget>[
            new CircleAvatar(
              maxRadius: 20.0,
              backgroundImage: new NetworkImage(article.headUrl),
            ),

            new Expanded(child: new Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(article.user, style: new TextStyle(
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
                  isLiked: article.isLike, likeCount: article.likeNum,)),
            new Icon(Icons.comment, color: Colors.grey[400],),
            new Container(
              margin: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
              child: new Text(article.commentNum.toString()),
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
                child: new Image.network(article.imgUrl == null?'':article.imgUrl),
              ),
              contentRow(article.title),
              likeAndCommentRow(article),
            ],
          ),
        ),
      );
    }

    Future<List<Article>> loadDataFromService() async {
      Random random = new Random();
      int dataCount = random.nextInt(10);
      List<Article> resultArray = new List();
      for (int i = 0; i < dataCount; i++) {
        Article artcle = new Article(
          headUrl: 'https://pic3.zhimg.com/50/v2-8943c20cecab028e19644cccf0f3a38b_s.jpg',
          user: '帅哥' + (i+1).toString(),
          groupName: '我的好友',
          time: '2018-07-04',
          isLike: false,
          likeNum: 0,
          commentNum: 0,
          title: '我是标题',
          imgUrl: 'https://pic4.zhimg.com/v2-a7493d69f0d8f849c6345f8f693454f3_200x112.jpg',
        );
        resultArray.add(artcle);
      }
      if (resultArray.length >= 10){
        _canLoadMore = true;
      }
      else{
        _canLoadMore = false;
      }
      return resultArray;
    }

    Future<Null> loadData() async {
      if (_canLoadMore){
        _pageIndex ++;
        loadDataFromService();
        setState(() {

        });
      }

    }


    return new MaterialApp(
      title: '首页',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('首页'),
          ),
          body: new RefreshIndicator(
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
          )
      ),
    );
  }
}