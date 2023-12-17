import 'package:flutter/material.dart';
import 'package:playandpausevideo/Car-illustrateB2-Screen.dart';
import 'Video-Chapter-Model.dart';
import 'Video-Model.dart';

class ListVideoChapterScreen extends StatefulWidget {
  VideoChapterModel? chapter;

  ListVideoChapterScreen({
    Key? key,
    this.chapter,
  }) : super(key: key);

  @override
  State<ListVideoChapterScreen> createState() => _ListVideoChapterScreenState();
}

class _ListVideoChapterScreenState extends State<ListVideoChapterScreen> {
   bool isLoading = true;
   List<VideoChapterModel>? data;

   final List<VideoChapterModel> listVideoChapter = [
     VideoChapterModel(id: 0, chapterTitle: 'Chương 1', tinhHuongs: [
       VideoModel(title: 'TH1', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH2', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH3', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH4', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH5', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH6', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
     ]),


     VideoChapterModel(id: 1, chapterTitle: 'Chương 2', tinhHuongs: [
       VideoModel(title: 'TH1', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH2', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH3', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH4', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH5', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH6', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
     ]),

     VideoChapterModel(id: 2, chapterTitle: 'Chương 3', tinhHuongs: [
       VideoModel(title: 'TH1', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH2', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH3', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH4', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH5', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH6', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
     ]),

     VideoChapterModel(id: 3, chapterTitle: 'Chương 4', tinhHuongs: [
       VideoModel(title: 'TH1', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH2', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH3', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH4', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH5', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH6', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
     ]),

     VideoChapterModel(id: 4, chapterTitle: 'Chương 5', tinhHuongs: [
       VideoModel(title: 'TH1', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH2', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH3', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH4', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH5', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH6', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
     ]),

     VideoChapterModel(id: 5, chapterTitle: 'Chương 6', tinhHuongs: [
       VideoModel(title: 'TH1', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH2', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH3', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH4', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH5', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
       VideoModel(title: 'TH6', url: 'https://weather365xyz.b-cdn.net/120thmp/video/720p/1.mp4'),
     ]),
   ];

  void initData(){
    data = getDataLocal();
    // get dataLocal
  }

  List<VideoChapterModel> getDataLocal() {
    return listVideoChapter;
  }

  @override
  void initState() {
    super.initState();

    /// Đây là biến khởi tạo dữ liệu
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: isLoading == false ? const Center(child: CircularProgressIndicator()) : buildListVideo(),
        ));
  }

  Widget buildListVideo(){
    if ( data != null){
      return ListView.builder(
          itemCount: data!.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CarIllustrateB2Screen(chapter: data![index], video: data![index].tinhHuongs[index] ))),
              title: Text(data![index].chapterTitle),
            );
          }
          );
    }
    else{
      return Text('không có dữ liệu');
    }
}


}
