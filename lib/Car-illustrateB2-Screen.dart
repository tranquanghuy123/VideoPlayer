import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';

class CarIllustrateB2Screen extends StatefulWidget {
  const CarIllustrateB2Screen({super.key});

  @override
  State<CarIllustrateB2Screen> createState() => _CarIllustrateB2ScreenState();
}

class _CarIllustrateB2ScreenState extends State<CarIllustrateB2Screen> {
  late VideoPlayerController _controller;

  bool isFullScreen = false;
  bool isSave = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
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
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    final isMuted = _controller.value.volume == 0;

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
                          child: VideoPlayer(_controller),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.blueGrey[900],
                            )),
                      ],
                    ),
                  ),

                  Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        height: 45,
                        width: widthScreen,
                        //color: Colors.redAccent,
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                  });
                                },
                                child: const Icon(
                                  Icons.arrow_back_outlined,
                                  color: Colors.white,
                                  size: 35,
                                )),
                            const SizedBox(width: 10),
                            const Text('Giao thông trên đường phố', style: TextStyle(
                              fontSize: 18, color: Colors.white)),

                            const SizedBox(width: 20),

                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                width: 30,
                                //color: Colors.green,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      child: const Icon(
                                        Icons.keyboard_arrow_left_rounded,
                                        color: Colors.cyan,
                                        size: 25,
                                      ),
                                    ),
                                    Container(
                                      width: 10,
                                      child: const Icon(
                                        Icons.keyboard_arrow_left_rounded,
                                        color: Colors.cyan,
                                        size: 25,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            const Text('Tình huống 21/120', style: TextStyle(
                                fontSize: 18, color: Colors.white)),

                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                width: 30,
                                //color: Colors.green,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      child: const Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        color: Colors.cyan,
                                        size: 25,
                                      ),
                                    ),
                                    Container(
                                      width: 10,
                                      child: const Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        color: Colors.cyan,
                                        size: 25,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            InkWell(
                                onTap: () {
                                  setState(() {
                                  });
                                },
                                child: Icon(
                                  isSave ? Icons.turned_in : Icons.turned_in_not,
                                  color: Colors.white,
                                  size: 30,
                                )
                            ),

                            const SizedBox(width: 8),
                              
                              InkWell(
                                  onTap: () {
                                    _controller.setVolume(isMuted ? 1 : 0);
                                    setState(() {});
                                  },
                                  child: Icon( isMuted ? Icons.volume_off : Icons.volume_up,
                                    color: Colors.cyan, size: 30,
                                  )),

                            SizedBox(width: 90),

                            InkWell(
                                onTap: () {
                                  setState(() {
                                  });
                                },
                                child: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: 30,
                                )),

                          ],
                        ),
                      )),

                  Positioned(
                    right: 50,
                    top: 125,
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: const BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              if(isFullScreen)
                              {
                                isFullScreen = false;
                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.portraitUp,
                                  DeviceOrientation.portraitDown,
                                ]);
                              }
                              else{
                                isFullScreen = true;
                                SystemChrome.setPreferredOrientations([
                                  DeviceOrientation.landscapeLeft,
                                  DeviceOrientation.landscapeRight,
                                ]);
                              }
                            });
                          },
                          child: Icon(isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                            color: Colors.white,
                            size: 18,
                          )),
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
