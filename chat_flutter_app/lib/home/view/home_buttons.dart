import 'package:flutter/material.dart';

class HomeLikeWidget extends StatefulWidget{
  HomeLikeWidget({
    this.likeCount,
    this.isLiked,
  });
  bool isLiked = false;
  int  likeCount = 0;
  @override
  createState() => new _HomeLikeWidgetState();
}

class _HomeLikeWidgetState extends State<HomeLikeWidget>
{
  void _addLikeCount(){
    setState(() {
      if (!widget.isLiked){
        widget.isLiked = true;
        widget.likeCount++;
      }
    });
  }

  void _deleteLikeCount(){
    setState(() {
      if (widget.isLiked){
        widget.isLiked = false;
        widget.likeCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: new Row(
        children: <Widget>[
          new Icon( widget.isLiked? Icons.favorite:Icons.favorite_border, color: Colors.redAccent,),
          new Container(
            width: 26.0,
            padding: const EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 0.0),
            child: new Text(
                '${widget.likeCount}',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}


