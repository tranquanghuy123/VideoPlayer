import 'dart:async';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:playandpausevideo/Basic_Overlay_Widget.dart';
import 'package:playandpausevideo/Video-Chapter-Model.dart';
import 'package:playandpausevideo/Video-Model.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

import '../Basic_Overlay_Widget2.dart';

class VideoPlayerFullScreenWidget extends StatefulWidget {
  final VideoPlayerController controller;

  final VideoChapterModel chapter;

  final VideoModel video;


  const VideoPlayerFullScreenWidget({
    Key? key,
    required this.controller, required this.chapter, required this.video,
  }) : super(key: key);

  @override
  _VideoPlayerFullScreenWidgetState createState() => _VideoPlayerFullScreenWidgetState();
}

class _VideoPlayerFullScreenWidgetState extends State<VideoPlayerFullScreenWidget> {
  Orientation? target;
  String markedTime = '';
  bool isShowMarkIcon = false;

  @override
  void initState() {
    super.initState();

    NativeDeviceOrientationCommunicator()
        .onOrientationChanged(useSensor: true)
        .listen((event) {
      final isPortrait = event == NativeDeviceOrientation.portraitUp;
      final isLandscape = event == NativeDeviceOrientation.landscapeLeft ||
          event == NativeDeviceOrientation.landscapeRight;
      final isTargetPortrait = target == Orientation.portrait;
      final isTargetLandscape = target == Orientation.landscape;

      if (isPortrait && isTargetPortrait || isLandscape && isTargetLandscape) {
        target = null;
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      }
    });
  }

  void setOrientation(bool isPortrait) {
    if (isPortrait) {
      Wakelock.disable();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    } else {
      Wakelock.enable();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  String getCurrentTime(Duration duration) {
    final duration = Duration(
        milliseconds: widget.controller.value.position.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context) =>
      widget.controller != null && widget.controller.value.isInitialized
          ? Container(child: buildVideo())
          : Center(child: CircularProgressIndicator());

  Widget buildVideo() => OrientationBuilder(
    builder: (context, orientation) {
      final isPortrait = orientation == Orientation.portrait;
      setOrientation(isPortrait);

      return Stack(
        fit: isPortrait ? StackFit.loose : StackFit.expand,
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(
            child: BasicOverlayWidget2(
              chapter: widget.chapter,
              video: widget.video,
              controller: widget.controller,
              onClickedFullScreen: () {
                target = isPortrait
                    ? Orientation.landscape
                    : Orientation.portrait;

                if (isPortrait) {
                  AutoOrientation.landscapeRightMode();
                } else {
                  AutoOrientation.portraitUpMode();
                }
              },
            ),
          ),
        ],
      );
    },
  );



  Widget buildVideoPlayer() {
    final video = AspectRatio(
      aspectRatio: widget.controller.value.aspectRatio,
      child: VideoPlayer(widget.controller),
    );

    return buildFullScreen(child: video);
  }

  Widget buildFullScreen({
    required Widget child,
  }) {
    final size = widget.controller.value.size;
    final width = size?.width ?? 0;
    final height = size?.height ?? 0;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}