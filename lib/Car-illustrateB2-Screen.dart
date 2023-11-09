import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class CarIllustrateB2Screen extends StatefulWidget {
  const CarIllustrateB2Screen({super.key});

  @override
  State<CarIllustrateB2Screen> createState() => _CarIllustrateB2ScreenState();
}

class _CarIllustrateB2ScreenState extends State<CarIllustrateB2Screen> {
  late VideoPlayerController controller;
  bool isVisible = false;

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
        body: Container(
          height: 250,
          width: widthScreen,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  isVisible = !isVisible;
                });
              },
              child: Stack(
                children: [
                  VideoPlayer(controller),
                  if(isVisible)
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        color: Colors.cyan,
                        height: 50,
                        width: 50,
                        child: Center(
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                                controller.value.isPlaying ? controller.pause() : controller.play();
                              });
                            },
                            icon: Icon(controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,size: 30),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            )
          ),
    );
  }
}