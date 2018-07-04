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
      margin: const EdgeInsets.only(right: 5.0),
      width: 50.0,
      child: new Row(
        children: <Widget>[
          new  Icon( widget.isLiked? Icons.favorite:Icons.favorite_border, color: Colors.redAccent,),
          new Expanded(child: new Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
            child: new Text('${widget.likeCount}'),
          ),
          ),
        ],
      ),
    );
  }
}


