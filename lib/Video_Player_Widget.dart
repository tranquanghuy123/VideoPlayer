import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'Basic_Overlay_Widget.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      controller != null && controller.value.isInitialized
          ? Container(child: buildVideo())
          : Container(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );

  Widget buildVideo() => Stack(
    children: <Widget>[
      buildVideoPlayer(),
      Positioned.fill(child: BasicOverlayWidget(controller: controller, onClickedFullScreen: () {  }, markTime: () {  },)),
    ],
  );

  Widget buildVideoPlayer() => AspectRatio(
    aspectRatio: controller.value.aspectRatio,
    child: VideoPlayer(controller),
  );
}
