import 'package:flutter/material.dart';

class HomeController extends StatelessWidget
{


  @override
  Widget build(BuildContext context) {

    Container UserInfoRow(){
      return new Container(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          children: <Widget>[
            new CircleAvatar(
              maxRadius: 20.0,
              backgroundImage: new AssetImage('images/homeHeader.png'),
            ),

            new Expanded(child: new Container(
              padding: const EdgeInsets.only(left: 10.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text('User Name', style: new TextStyle(fontSize: 14.0,color: Colors.black45)),
                  ),
                  new Text('From Group', style: new TextStyle(fontSize: 11.0,color: Colors.grey),)
                ],
              ),
            )),
            new Text('2018-06-30'),
          ],
        ),
      );
    }

    Container contentRow(){
      return new Container(
        height: 40.0,
        padding: const EdgeInsets.all(13.0),
        alignment: Alignment.centerLeft,
        child: new Text(
          '计划旅行之前想到的话',
          style: new TextStyle(fontSize: 16.0,color: Colors.black45),
        ),
      );
    }

    Container likeAndCommentRow()
    {
      return new Container(
        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 13.0, 5.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Icon(Icons.favorite_border, color: Colors.redAccent,),
            new Container(
              margin: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
              child: new Text('5'),
            ),
            new Icon(Icons.comment,color: Colors.grey[400],),
            new Container(
              margin: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
              child: new Text('20'),
            ),
          ],
        ),
      );
    }

    Widget TimelineCard = new Card(
      margin: const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 5.0),
      child: new SizedBox(
        child: Column(
          children: <Widget>[
            UserInfoRow(),
            new Container(
              padding: const EdgeInsets.all(13.0),
              child: new Image.asset(
                  'images/picture_demo.png'),
            ),
            contentRow(),
            likeAndCommentRow(),
          ],
        ),
      ),
    );
    return new MaterialApp(
      title: '首页',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('朋友圈'),
        ),
        body: new ListView.builder(
          itemCount: 10,
            itemBuilder: (context, i)
            {
              return TimelineCard;
            }
        )
      ),
    );
  }
}
