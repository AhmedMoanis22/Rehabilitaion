import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}






class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {

  late VideoPlayerController _controller;

 @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
       widget.videoUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        _controller.setVolume(1);
        setState(() {});
      });
  }




 @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }





  
  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
              ? Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                      aspectRatio: 16/10,
                      child: VideoPlayer(_controller),
                    ),
                    IconButton(onPressed: () {


                       setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
                      
                    }, icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,color: Colors.white,))
                ],
              )
              : const AspectRatio
              (aspectRatio: 16/10,
                
                child:  Center(child: CircularProgressIndicator(color: Colors.white,)));
  }
}