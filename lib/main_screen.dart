import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:videodemo/list_data.dart';
import 'package:videodemo/video_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  ScrollController _scrollController = ScrollController();

  List<ListData> _listData;

  _getData() async {
    _listData = List<ListData>();
    String loadData = await rootBundle.loadString('assets/data.json');
    final jsonResponse = json.decode(loadData);
    print(jsonResponse['data'].length);
    for(int i = 0; i < jsonResponse['data'].length; i++) {
      _listData.add(ListData(
          jsonResponse['data'][i]['title'],
          jsonResponse['data'][i]['video'],
          jsonResponse['data'][i]['thumbnail'],
          jsonResponse['data'][i]['description']
      ));
    }

    setState(() {});
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.black,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Builder(builder: (BuildContext context) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: _listData == null ? 0 : _listData.length,
            itemBuilder: (BuildContext context, int index) {
              return OpenContainer(
                openColor: Colors.black,
                closedColor: Colors.black,
                openElevation: 0.0,
                closedElevation: 0.0,
                transitionType: ContainerTransitionType.fade,
                openBuilder: (BuildContext context, VoidCallback _) => VideoScreen(listData: _listData[index]),
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return InkWell(
                    onTap: () => openContainer(),
                    child: Stack(
                      children: <Widget>[
                        Image.asset('assets/${_listData[index].thumbnail}'),
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            gradient: LinearGradient(
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.center,
                              colors: const [
                                Color.fromARGB(51, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0.0, left: 16.0,
                          child: Text(
                            _listData[index].title,
                            style: TextStyle(
                                fontFamily: 'D-DIN',
                                color: Colors.white,
                                fontSize: 72,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -6.0,
                                shadows: [
                                  Shadow(
                                    color: Color.fromARGB(128, 0, 0, 0),
                                    offset: const Offset(0, 2.0),
                                    blurRadius: 0.0,
                                  )
                                ]
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}