import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized && controller != null
        ? Container(alignment: Alignment.topCenter, child: buildVideo())
        : Container(
      height: 200,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildVideo() {
    return Center(
      child: buildVideoPlayer(),
    );
  }

  Widget buildVideoPlayer(){
    return buildFullScreen(
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      ),
    );
  }

  Widget buildFullScreen({
    required Widget child,
  }) {
    final size = controller.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
