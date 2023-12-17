import 'package:flutter/material.dart';

import 'Video-Model.dart';

class VideoChapterModel {
  final String chapterTitle;
  final int id;
  final List<VideoModel> tinhHuongs;

  VideoChapterModel({required this.chapterTitle, required this.id, required this.tinhHuongs});
}