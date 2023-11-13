import 'package:flutter/material.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatefulWidget {
  final VideoPlayerController controller;
  //final VoidCallback onClickedFullScreen;

  const BasicOverlayWidget({
    Key? key,
    required this.controller,
    //required this.onClickedFullScreen,
  }) : super(key: key);

  @override
  State<BasicOverlayWidget> createState() => _BasicOverlayWidgetState();
}

class _BasicOverlayWidgetState extends State<BasicOverlayWidget> {
  bool isVisible = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String getPosition() {
    final duration = Duration(
        milliseconds: widget.controller.value.position.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context){
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isVisible = true;
          Future.delayed(const Duration(seconds: 3), () {
            setState(() {
              isVisible = false;
            });
          });
        });
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: buildPlay(),
          ),
          Positioned(
            right: 0,
            top: 200,
            child: Container(
              width: widthScreen,
              height: 40,
              //color: Colors.redAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getPosition(), style: TextStyle(color: Colors.white),),
                  InkWell(
                      onTap: () {
                        setState(() {
                        });
                      },
                      child: const Icon(
                        Icons.room,
                        color: Colors.white,
                        size: 25,
                      )),
                  InkWell(
                      onTap: () {
                        setState(() {
                        });
                      },
                      child: const Icon(
                        Icons.sync,
                        color: Colors.white,
                        size: 25,
                      )),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildIndicator()
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() => // /// Thanh thoi gian
      Container(
        margin: const EdgeInsets.all(8).copyWith(right: 0),
        height: 16,
        child: SmoothVideoProgress(
          controller: widget.controller,
          builder: (context, position, duration, child) => Slider(
            onChangeStart: (_) => widget.controller.pause(),
            onChangeEnd: (_) => widget.controller.play(),
            onChanged: (value) =>
                widget.controller.seekTo(Duration(milliseconds: value.toInt())),
            value: position.inMilliseconds.toDouble(),
            min: 0,
            max: duration.inMilliseconds.toDouble(),
          ),
        ),
      );

  Widget buildPlay() =>
      isVisible ? (widget.controller.value.isPlaying ? Container() : ElevatedButton(
        onPressed: () {
          setState(() {
            widget.controller.value.isPlaying
                ? widget.controller.pause()
                : widget.controller.play();
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.black45,
          shape: CircleBorder(),
          padding: EdgeInsets.all(15),
        ),
        child: Icon(
            widget.controller.value.isPlaying
                ? Icons.pause
                : Icons.play_arrow,
            color: Colors.white,
            size: 40),
      )) : Container();
}
