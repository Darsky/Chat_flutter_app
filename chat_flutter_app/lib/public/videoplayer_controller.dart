import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class ZWVideoPlayerController extends StatefulWidget {
  String videoUrl;
  ZWVideoPlayerController({this.videoUrl});

  @override
  createState() => new _ZWVideoPlayerControllerState();
}

class _ZWVideoPlayerControllerState extends State<ZWVideoPlayerController> {
  VideoPlayerController _controller;
  bool _isPlaying = false;
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoUrl,
    )
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('观看视频'),
      ),
      body: Center(
        child: _controller.value.initialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _controller.value.isPlaying
            ? _controller.pause
            : _controller.play,
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}