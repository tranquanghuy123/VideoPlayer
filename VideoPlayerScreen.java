import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
    );

    _initializeVideoPlayer = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mô phỏng'),
        ),
        body: Column(
          children: [
            Container(
              height: 250,
              width: widthScreen,
              color: Colors.black,
              child: Stack(
                children: [
                  ///Clip
                  Container(
                    width: widthScreen,
                    height: heightScreen,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.blueGrey[900],
                            )),
                        Expanded(
                          flex: 7,
                          child: FutureBuilder(
                            future: _initializeVideoPlayer,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.blueGrey[900],
                            )),
                      ],
                    ),
                  ),

                  ///start, pause, repeat, space
                  Positioned(
                    right: 0,
                    top: 150,
                    child: Container(
                      height: 45,
                      width: widthScreen,
                      //color: Colors.redAccent,
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            //color: Colors.purpleAccent,

                            /// start, pause, renew
                            child: Row(
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          // play video
                                          _controller.play();
                                        });
                                      },
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 18,
                                      )),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          // Pause the video
                                          _controller.pause();
                                        });
                                      },
                                      child: const Icon(
                                        Icons.pause,
                                        color: Colors.white,
                                        size: 18,
                                      )),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: InkWell(
                                      onTap: () async {
                                        await _controller.seekTo(Duration.zero);
                                        setState(() {
                                          _controller.play();
                                        });
                                      },
                                      child: const Icon(
                                        Icons.sync,
                                        color: Colors.white,
                                        size: 18,
                                      )),
                                ),
                              ],
                            ),
                          ),

                          ///Space
                          TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.cyan,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(100, 20),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                              child: const Text(
                                'SPACE',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                              )),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    right: 0,
                    top: 200,
                    child: Container(
                      width: widthScreen,
                      height: 30,
                      child: SmoothVideoProgress(
                        controller: _controller,
                        builder: (context, position, duration, child) => Slider(
                          onChangeStart: (_) => _controller.pause(),
                          onChangeEnd: (_) => _controller.play(),
                          onChanged: (value) => _controller
                              .seekTo(Duration(milliseconds: value.toInt())),
                          value: position.inMilliseconds.toDouble(),
                          min: 0,
                          max: duration.inMilliseconds.toDouble(),
                        ),
                      ),
                    ),
                  ) // VideoProgressIndicator(//     controller: _controller, allowScrubbing: true)
                ],
              ),
            ),
          ],
        ));
  }
}
