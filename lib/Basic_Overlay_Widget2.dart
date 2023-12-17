import 'package:flutter/material.dart';
import 'package:playandpausevideo/Car-illustrateB2-Screen.dart';
import 'package:playandpausevideo/Video-Chapter-Model.dart';
import 'package:playandpausevideo/orientation/Video_Player_FullScreenWidget.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';
import 'package:video_player/video_player.dart';
import 'Video-Model.dart';

class BasicOverlayWidget2 extends StatefulWidget {
  final VideoPlayerController controller;
  final VoidCallback onClickedFullScreen;

  final VideoChapterModel chapter;

  final VideoModel video;

  const BasicOverlayWidget2(
      {Key? key,
      required this.controller,
      required this.onClickedFullScreen,
      required this.chapter, required this.video})
      : super(key: key);

  @override
  State<BasicOverlayWidget2> createState() => _BasicOverlayWidget2State();
}

class _BasicOverlayWidget2State extends State<BasicOverlayWidget2> {
  bool isVisible = false;
  bool isTimeStampClick = true;
  double? position;
  String? title;

  void initData() {
    if (widget.chapter.tinhHuongs.isNotEmpty) {
      setState(() {
        title = widget.chapter.tinhHuongs.elementAt(0).title;
      });
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

    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child:
          Padding(padding: const EdgeInsets.all(10),
              child: Text(title ?? '',
                style: TextStyle(color: Colors.white),)),
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

                      //SizedBox(width: 120),

                      buildTimeStampMark(),

                      //SizedBox(width: 57),

                      Container(
                        //color: Colors.cyan,
                        height: 40,
                        width: 91,
                        child: Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      // play video
                                      widget.controller.play();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 18,
                                  )),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      // Pause the video
                                      widget.controller.pause();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.pause,
                                    color: Colors.white,
                                    size: 18,
                                  )),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              height: 25,
                              width: 25,
                              decoration: const BoxDecoration(
                                  color: Colors.black38,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: InkWell(
                                  onTap: () async {
                                    await widget.controller
                                        .seekTo(Duration.zero);
                                    setState(() {
                                      widget.controller.play();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.replay,
                                    color: Colors.white,
                                    size: 18,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: buildIndicator()),
                    InkWell(
                        onTap: widget.onClickedFullScreen,
                        child: const Icon(
                          Icons.sync,
                          color: Colors.white,
                          size: 25,
                        )),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ))
      ],
    );
  }

  Widget buildMenu() {
    return InkWell(
      child: const Icon(
        Icons.list,
        color: Colors.white,
        size: 25,
      ),
      onTap: () async {
        final result = await showModalBottomSheet<VideoModel>(
          context: context,
          isScrollControlled: true,
          constraints: const BoxConstraints(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
          ),
          builder: (BuildContext context) {
            if (widget.chapter != null && widget.chapter?.tinhHuongs != null) {
              return Container(
                height: 350,
                color: Colors.grey.shade900,
                child: Column(
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
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '1/120',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 300,
                      child: ListView.builder(
                        itemCount: widget.chapter?.tinhHuongs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              widget.chapter!.tinhHuongs[index].title,
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              // Navigate to the VideoPlayerScreen when a video is tapped
                              Navigator.pop(
                                context,
                                widget.chapter!.tinhHuongs[index],
                              );

                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Text('k có dl');
            }
          },
        );
        if (result != null) {
          print(result.title);
          print(result.url);
        }
        setState(() {
          title = result?.title;
        });
      },
    );
  }


  Widget buildIndicator() => // /// Thanh thoi gian
      Stack(
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
          position != null
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  left: MediaQuery.of(context).size.width * position!,
                  child: Container(
                    width: 1,
                    color: Colors.red,
                  ))
              : Container()
        ],
      );


  Widget buildTimeStampMark() {
    return Visibility(
      visible: isTimeStampClick,
      child: ElevatedButton(
        onPressed: () {
          final markTime =
              widget.controller.value.position.inMilliseconds.toString();
          final timeTotal =
              widget.controller.value.duration.inMilliseconds.toString();
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
