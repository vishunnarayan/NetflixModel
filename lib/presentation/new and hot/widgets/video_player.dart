import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerTrial extends StatefulWidget {
  const VideoPlayerTrial(VideoPlayerController controller, {Key? key})
      : super(key: key);

  @override
  State<VideoPlayerTrial> createState() => _VideoPlayerTrialState();
}

class _VideoPlayerTrialState extends State<VideoPlayerTrial> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network('https://youtu.be/5g02v1oz5Y0')
      ..initialize().then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Name',
      home: Scaffold(
          body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      )),
    );
  }
}
