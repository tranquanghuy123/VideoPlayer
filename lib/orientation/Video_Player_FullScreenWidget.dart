import 'dart:async';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:playandpausevideo/Basic_Overlay_Widget.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class VideoPlayerFullScreenWidget extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoPlayerFullScreenWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _VideoPlayerFullScreenWidgetState createState() => _VideoPlayerFullScreenWidgetState();
}

class _VideoPlayerFullScreenWidgetState extends State<VideoPlayerFullScreenWidget> {
  Orientation? target;
  String markedTime = '';

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
            child: BasicOverlayWidget(
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
              markTime: (){
                setState(() {
                  markedTime = formatDuration(widget.controller.value.position);
                });
                print('Marked time: ${widget.controller.value.position}');
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