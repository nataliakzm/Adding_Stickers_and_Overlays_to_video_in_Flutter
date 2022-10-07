import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Import video_player package to integrate a video asset
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoApp());

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/bee.mp4')

      /// Specify the path to your video asset here
      ..initialize().then((_) {
        /// Ensure the first frame is shown after the video is initialized,
        /// even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                title: Text('How to add Stickers and Overlays'),
                backgroundColor: Color(0xff0360da)),
            body: Center(
                child: _controller.value.isInitialized

                    /// First, we specify the AspectRatio of a video frame
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,

                        /// Then, we initialize a Stack widget
                        child: Stack(children: [
                          VideoPlayer(_controller),

                          /// Don't forget to align the position of the Сontainer
                          Positioned(
                              bottom: 5,
                              left: 10,
                              child: Container(
                                  width: 80,
                                  height: 40,

                                  /// Uncomment the following line to check the position/size of the Container
                                  //color: Color(0xff0360da),
                                  child: Align(
                                      alignment: Alignment.center,

                                      /// Integrate Image overlay into a video
                                      child:
                                          Image.asset('assets/sticker.png')))),

                          // Repeat the same structure for instering a textual watermark
                          Positioned(
                              top: 5,
                              right: 10,
                              child: Container(
                                  width: 80,
                                  height: 40,
                                  child: Align(
                                      alignment: Alignment.center,

                                      /// Put some text overlay into a video
                                      child: Text("IMG.LY",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))))),
                        ]))

                    /// If there is no video, a blank page will be return
                    : Container()),
            floatingActionButton: FloatingActionButton.extended(
                backgroundColor: const Color(0xff0360da),
                foregroundColor: Colors.white,
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                icon: Icon(_controller.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow),
                label: Text('Play for IMG.LY'))));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
