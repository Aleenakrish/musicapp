import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/provider/changenotifier.dart';
import 'package:musicapp/songslist.dart';
import 'package:provider/provider.dart';

class Musicpage extends StatefulWidget {
  const Musicpage({super.key});

  @override
  State<Musicpage> createState() => _ListenmusicState();
}

class _ListenmusicState extends State<Musicpage>
    with SingleTickerProviderStateMixin {
  final AudioPlayer player = AudioPlayer();

  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  List<File> musicFiles = [];

  // List Favorite = [];

  final _favorite = Hive.box("mybox");
// ===========================================================================================================
  double he = 0;
  String? _music;
  int currentIndex = 0;
  late AnimationController _controller;
  bool icon = false;
  bool favorite = false;
  bool _isrotation = true;
  bool Shuffle = false;
  bool repeat = false;
  bool _ismuted = false;
  bool arrow = false;
// ===========================================================================================================
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    play();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    player.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    });

    player.durationStream.listen((duration) {
      setState(() {
        _totalDuration = duration ?? Duration.zero;
      });
    });
  }

  // =============================================================================================================

  Future<void> playMusic(String filePath) async {
    try {
      await player.setFilePath(filePath);
      await player.play();
    } catch (e) {
      print("Error Playing audio:$e");
    }
  }

  ////////////////////////////////////////////////////////////////repeate///////////////////////////
  void _toggleRepeat() {
    setState(() {
      repeat = !repeat;
    });

    if (repeat) {
      // Loop the song
      player.setLoopMode(LoopMode.one);
    } else {
      // Stop the loop (it will play once)
      player.setLoopMode(LoopMode.off);
    }
  }

  ///////////////////////////////////////////////playnextprev///////////////////////////////////////////////////

  // Future<void> playNext() async {
  //   setState(() {
  //     currentIndex = (currentIndex + 1) % musicFiles.length;
  //   });
  //   playMusic(musicFiles[currentIndex].path);
  // }

  // Future<void> playPrevious() async {
  //   setState(() {
  //     currentIndex = (currentIndex - 1 + musicFiles.length) % musicFiles.length;
  //   });
  //   playMusic(musicFiles[currentIndex].path);
  // }

  String? _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    return "$minutes:$seconds";
  }

  ////////////////////////////////////////////////////////////////////////////////////////

  /////////////////////////////////////////////////play
  ///

  void play() {
    var Play = Provider.of<providerr>(context, listen: false);
    Play.duration();
    print(Play);
    print("=========================================");
  }

  @override
  Widget build(BuildContext context) {
    _music = ModalRoute.of(context)!.settings.arguments as String;
    return Consumer<providerr>(
        builder: (context, music, child) => Scaffold(
              extendBodyBehindAppBar: true,
              body: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black,
                  const Color.fromARGB(255, 87, 86, 86)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: ListView(children: [
                  Container(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Songslist()));
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            )),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 70, top: 10),
                              child: Center(
                                child: Text(
                                  "NOW PLAYING",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: const Color.fromARGB(
                                          255, 209, 208, 208)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 60),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.more_vert_outlined,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Stack(
                        children: [
                          Container(
                              // margin: EdgeInsets.only(left: 100, right: 100),
                              height: 250,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(150),
                                  color: const Color.fromARGB(255, 32, 32, 32),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 3, color: Colors.white)
                                  ]),
                              alignment: Alignment.center,
                              child: AnimatedRotation(
                                turns: !_isrotation ? 100 : 0,
                                duration: Duration(seconds: 300),
                                child: Container(
                                  height: 230,
                                  width: 230,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(150),
                                      // color: Colors.amber
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black,
                                          const Color.fromARGB(
                                              255, 160, 159, 159),
                                        ],
                                        // begin: Alignment.topLeft,
                                        // end: Alignment.bottomRight
                                      )),
                                  alignment: Alignment.center,
                                ),
                              )),
                          Positioned(
                            top: 20,
                            left: 21,
                            child: Container(
                                height: 210,
                                width: 210,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(150),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1, color: Colors.white)
                                    ]),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(150),
                                  child: Image.asset(
                                    "./images/log.jpeg",
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                // padding: EdgeInsets.only(left: 100),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 200,
                                  child: Text(
                                    _music!.split("/").last.split("-").first,
                                    // _audiofiles[currentIndex].uri.pathSegments.last,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 280,
                                child: Text(
                                  _music!
                                      .split("/")
                                      .last
                                      .split("-")
                                      .last
                                      .substring(
                                          0,
                                          _music!
                                                  .split("/")
                                                  .last
                                                  .split("-")
                                                  .last
                                                  .length -
                                              4),
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 50),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    music.muted = !music.muted;
                                  });
                                  music.player
                                      .setVolume(music.muted ? 0.0 : 1.0);
                                },
                                icon: Icon(
                                  music.muted ? Icons.mic_off : Icons.mic_none,
                                  color: Colors.white,
                                  size: 30,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 50, right: 10),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  favorite = !favorite;
                                  List ls = [];
                                  _favorite.get("key");
                                  if (_favorite.get("key") != null) {
                                    ls = _favorite.get("key");
                                    ls.add(music.name);
                                    _favorite.put("key", ls);
                                  } else {
                                    ls.add(music.name);
                                    _favorite.put("key", ls);
                                  }
                                  print(ls);
                                  print(
                                      "==============================================");
                                });
                              },
                              icon: Icon(
                                favorite
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: favorite ? Colors.red : Colors.white,
                                size: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            overlayShape: SliderComponentShape.noOverlay),
                        child: Container(
                          width: 350,
                          // height: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Slider(
                              activeColor:
                                  const Color.fromARGB(255, 206, 202, 202),
                              inactiveColor: Colors.white,
                              thumbColor: Colors.grey,
                              min: 0.0,
                              max: music.totalDuration.inSeconds.toDouble(),
                              value: music.currentPosition.inSeconds
                                  .toDouble()
                                  .clamp(0.0,
                                      music.totalDuration.inSeconds.toDouble()),
                              onChanged: (value) {
                                final newPosition =
                                    Duration(seconds: value.round());
                                music.player.seek(newPosition);
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${_formatDuration(music.currentPosition)}",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${_formatDuration(music.totalDuration)}",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),

                      ///////////////////////////////////////////////////////////////////////////////////////////////////////////////pauseplay//////////////////////////
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 3),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    music.Shuffle = !music.Shuffle;
                                  });
                                },
                                icon: music.Shuffle
                                    ? Icon(
                                        Icons.shuffle,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.shuffle,
                                        color: Colors.white,
                                        size: 27,
                                      ),
                              )),
                          // Text(musicFiles[currentIndex].path.split("/").last),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: IconButton(
                              onPressed: () {
                               music.playPrevious();
                              },
                              icon: Icon(
                                Icons.skip_previous,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                              alignment: Alignment.center,
                              onPressed: () {
                                setState(() {
                                  _isrotation = !_isrotation;
                                  music.Icon = !music.Icon;

                                  music.Icon
                                      ? _controller.forward()
                                      : _controller.reverse();
                                  music.Icon
                                      ? music.player.pause()
                                      : music.player.play();
                                });
                              },
                              icon:
                                  // Icon(
                                  //   Icons.play_arrow,
                                  //   size: 60,
                                  // ),
                                  AnimatedIcon(
                                      icon: AnimatedIcons.pause_play,
                                      size: 60,
                                      color: Colors.white,
                                      progress: _controller)),
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            onPressed: () {
                              music.playNext();
                            },
                            // playNextSong,
                            icon: Icon(
                              Icons.skip_next,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    music.repeat = !music.repeat;
                                    repeat
                                        ? music.player.setLoopMode(LoopMode.one)
                                        : music.player
                                            .setLoopMode(LoopMode.off);
                                  });
                                },
                                icon: music.repeat
                                    ? Icon(
                                        Icons.repeat,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.repeat_outlined,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                              ))
                          ////////////////////////////////////////////////////////////////////////////////////
                        ],
                      ),
                    ],
                  ),
                  AnimatedContainer(
                    padding: EdgeInsets.only(top: 20),
                    height: he,
                    width: double.infinity,
                    color: Colors.transparent,
                    duration: Duration(seconds: 3),
                    child: Center(
                      child: Text(
                        "No Lyrics",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    child: he == 0
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                he = 200;
                              });
                              arrow = !arrow;
                            },
                            icon: arrow
                                ? Icon(
                                    Icons.keyboard_arrow_up_outlined,
                                    color: Colors.white,
                                    size: 40,
                                  )
                                : Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 40,
                                  ))
                        : he == 200
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    he = 0;
                                  });
                                  arrow = !arrow;
                                },
                                icon: arrow
                                    ? Icon(
                                        Icons.keyboard_arrow_up_outlined,
                                        color: Colors.white,
                                        size: 40,
                                      )
                                    : Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                        size: 40,
                                      ))
                            : Icon(Icons.ac_unit_rounded),
                  ),
                ]),
              ),
            ));
  }
}
