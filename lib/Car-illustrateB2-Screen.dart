
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playandpausevideo/Video_Player_Widget.dart';
import 'package:playandpausevideo/orientation/FullScreen_Page.dart';
import 'package:playandpausevideo/orientation/Video_Player_FullScreenWidget.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';
import 'package:video_player/video_player.dart';

import 'Basic_Overlay_Widget.dart';

class CarIllustrateB2Screen extends StatefulWidget {
  const CarIllustrateB2Screen({super.key});

  @override
  State<CarIllustrateB2Screen> createState() => _CarIllustrateB2ScreenState();
}

class _CarIllustrateB2ScreenState extends State<CarIllustrateB2Screen> {
  late VideoPlayerController controller;

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
          toolbarHeight: 0,
        ),
        body: VideoPlayerFullScreenWidget(controller: controller)
    );
  }
}