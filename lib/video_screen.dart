import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:videodemo/list_data.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({this.listData, Key key}) : super(key: key);

  final ListData listData;

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  ScrollController _scrollController = ScrollController();
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.asset('assets/${widget.listData.video}')
      ..initialize().then((_) {
        _videoPlayerController.play();
        _videoPlayerController.setLooping(true);
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _globalKey,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: Text(
                  'title : ${widget.listData.title}',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'D-DIN',
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: Text(
                  '${widget.listData.description}',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'D-DIN',
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Text(
                    '< Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'D-DIN',
                      fontSize: 20.0,
                      decoration: TextDecoration.underline
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}