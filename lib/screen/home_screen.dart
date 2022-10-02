import 'package:cf_tube/component/custom_youtube_player.dart';
import 'package:cf_tube/model/video_model.dart';
import 'package:cf_tube/repository/youtube_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '코팩튜브',
        ),
        backgroundColor: Colors.black,
      ),
      body:FutureBuilder<List<VideoModel>>(
        future: YoutubeRepository.getVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {  // 에러가 있을 경우 에러 화면에 표시하기
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (!snapshot.hasData) {  // 로딩 중일 때 로딩위젯 보여주기
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator(
            onRefresh: ()async{

            },
            child: ListView(  // List<VideoModel>을 CustomYoutubePlayer로 매핑
              children: snapshot.data!
                  .map((e) => CustomYoutubePlayer(videoModel: e))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
