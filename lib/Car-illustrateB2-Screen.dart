import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:playandpausevideo/Chewie_Video_Player.dart';

class CarIllustrateB2Screen extends StatefulWidget {
  const CarIllustrateB2Screen({super.key});

  @override
  State<CarIllustrateB2Screen> createState() => _CarIllustrateB2ScreenState();
}

class _CarIllustrateB2ScreenState extends State<CarIllustrateB2Screen> {
  late VideoPlayerController controller;

  bool isSave = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(
      Uri.parse('https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
    )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller.dispose();
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
                          child: ChewieVideoWidget(controller),
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
                        color: Colors.redAccent,
                        padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                  // Positioned(
                  //   right: 0,
                  //   top: 200,
                  //   child: Container(
                  //     width: widthScreen,
                  //     height: 30,
                  //     child: SmoothVideoProgress(
                  //       controller: controller,
                  //       builder: (context, position, duration, child) => Slider(
                  //         onChangeStart: (_) => controller.pause(),
                  //         onChangeEnd: (_) => controller.play(),
                  //         onChanged: (value) => controller
                  //             .seekTo(Duration(milliseconds: value.toInt())),
                  //         value: position.inMilliseconds.toDouble(),
                  //         min: 0,
                  //         max: duration.inMilliseconds.toDouble(),
                  //       ),
                  //     ),
                  //   ),
                  // ),


                ],
              ),
            ),
          ],
        ));

  }
}
