import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playandpausevideo/Video-Model.dart';
import 'package:playandpausevideo/Video_Player_Widget.dart';
import 'package:playandpausevideo/orientation/Video_Player_FullScreenWidget.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';
import 'package:video_player/video_player.dart';
import 'Basic_Overlay_Widget.dart';
import 'Video-Chapter-Model.dart';

class CarIllustrateB2Screen extends StatefulWidget {
  final VideoChapterModel chapter;
  final VideoModel video;

  const CarIllustrateB2Screen(
      {super.key, required this.chapter, required this.video});

  @override
  State<CarIllustrateB2Screen> createState() => _CarIllustrateB2ScreenState();
}

class _CarIllustrateB2ScreenState extends State<CarIllustrateB2Screen> {
  late VideoPlayerController? controller;

  void initData() async {
    if (widget.chapter.tinhHuongs.isNotEmpty) {
      controller = VideoPlayerController.networkUrl(
          Uri.parse(widget.chapter.tinhHuongs.elementAt(0).url));
      await controller?.initialize();
      setState(() {});
      // get dataLocal
    }
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    } else {
      controller = null;
    }
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
        body: (controller != null && widget.chapter != null)
            ? VideoPlayerFullScreenWidget(
                controller: controller!,
                chapter: widget.chapter,
                video: widget.video,
              )
            : Text('không có dl'));
  }
}
