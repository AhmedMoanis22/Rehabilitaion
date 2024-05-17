import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FlickVideoScreen extends StatefulWidget {
  final String videoAsset;

  FlickVideoScreen(this.videoAsset);

  @override
  _FlickVideoScreenState createState() => _FlickVideoScreenState();
}

class _FlickVideoScreenState extends State<FlickVideoScreen> {

  late FlickManager _flickManager;

  @override
  void initState() {
    super.initState();
    _flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.asset(widget.videoAsset),
    );
  }

  @override
  void dispose() {
    _flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
          child: FlickVideoPlayer(
            flickManager: _flickManager,)
      ),
    );
  }
}