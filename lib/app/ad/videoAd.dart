/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         视频广告
*/
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoAd extends StatefulWidget {
  Map arguments;
  VideoAd({Key key, this.arguments}) : super(key: key);

  @override
  _VideoAdState createState() => _VideoAdState(arguments:this.arguments);
}

class _VideoAdState extends State<VideoAd> {
  Map arguments;
  VideoPlayerController _controller;

  _VideoAdState({this.arguments}) {
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      );
  }
}