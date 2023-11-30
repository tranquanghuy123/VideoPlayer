import 'package:flutter/material.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatefulWidget {
  final VideoPlayerController controller;
  final VoidCallback onClickedFullScreen;
  final VoidCallback buttonClick;

  const BasicOverlayWidget({
    Key? key,
    required this.controller,
    required this.onClickedFullScreen,
    required this.buttonClick,
  }) : super(key: key);

  @override
  State<BasicOverlayWidget> createState() => _BasicOverlayWidgetState();
}

class _BasicOverlayWidgetState extends State<BasicOverlayWidget> {
  bool isVisible = false;
  bool isTimeStampClick = true;
  double? position;


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
  Widget build(BuildContext context) {
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
          Align(
            alignment: Alignment.topRight,
            child:
                Padding(padding: const EdgeInsets.all(10), child: buildMenu()),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: widthScreen,
                    height: 40,
                    //color: Colors.redAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getPosition(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        buildTimeStampMark(),
                        // Container(
                        //   height: 40,
                        //   width: 40,
                        //   decoration: BoxDecoration(
                        //       color: Colors.deepPurple.shade200,
                        //       borderRadius:
                        //       BorderRadius.all(Radius.circular(30))),
                        //   child: InkWell(
                        //       onTap: widget.markTime,
                        //       child: const Icon(
                        //         Icons.flag,
                        //         color: Colors.black,
                        //         size: 35,
                        //       )),
                        // ),
                        InkWell(
                            onTap: widget.onClickedFullScreen,
                            child: const Icon(
                              Icons.sync,
                              color: Colors.white,
                              size: 25,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildIndicator()
                ],
              ))
        ],
      ),
    );
  }

  Widget buildMenu() {
    return InkWell(
      child: const Icon(
        Icons.list,
        color: Colors.white,
        size: 25,
      ),
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          constraints: const BoxConstraints(
              maxWidth: double.infinity, maxHeight: double.infinity),
          builder: (BuildContext context) {
            return Container(
              height: 350,
              color: Colors.grey.shade900,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: double.maxFinite,
                    color: Colors.black54,
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: 25,
                            )),
                        const SizedBox(width: 8),
                        const Text('1/120',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        const SizedBox(width: 8),
                        InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 25,
                            )),
                      ],
                    ),
                  ),
                  const ListTile(
                    leading: Text('TH1.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700)),
                    title: Text('Người đi bộ băng qua đường',
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildIndicator() => // /// Thanh thoi gian
      Padding(
        padding: const EdgeInsets.all(8).copyWith(right: 0),
        child: Stack(
          children: [
            SizedBox(
              height: 13,
              child: SmoothVideoProgress(
                controller: widget.controller,
                builder: (context, position, duration, child) => Slider(
                  onChangeStart: (_) => widget.controller.pause(),
                  onChangeEnd: (_) => widget.controller.play(),
                  onChanged: (value) => widget.controller
                      .seekTo(Duration(milliseconds: value.toInt())),
                  value: position.inMilliseconds.toDouble(),
                  min: 0,
                  max: duration.inMilliseconds.toDouble(),
                ),
              ),
            ),
            position != null ? Positioned(
                top: 0,
                bottom: 0,
                left: MediaQuery.of(context).size.width * position!,
                child: Container(
                  width: 1,
                 color: Colors.red,
            )) : Container()
          ],
        ),
      );

  Widget buildPlay() => isVisible
      ? (ElevatedButton(
          onPressed: () {
            setState(() {
              widget.controller.value.isPlaying
                  ? widget.controller.pause()
                  : widget.controller.play();
            });
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.black45,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(15),
          ),
          child: Icon(
              widget.controller.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.white,
              size: 40),
        ))
      : Container();

  Widget buildTimeStampMark() {
    return Visibility(
      visible: isTimeStampClick,
      child: ElevatedButton(
        onPressed: () {
          final markTime = widget.controller.value.position.inMilliseconds.toString();
          final timeTotal = widget.controller.value.duration.inMilliseconds.toString();
          print('markTime: $markTime - timeTotal: $timeTotal');
          setState(() {
            isTimeStampClick = false;
            position = double.parse(markTime) / double.parse(timeTotal);
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.deepPurple.shade200,
          shape: const CircleBorder(),
        ),
        child: const Icon(
          Icons.flag,
          color: Colors.black,
          size: 35,
        ),
      ),
    );
  }
}
