import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/songslist.dart';
import 'package:path_provider/path_provider.dart';

class Musicpage extends StatefulWidget {
  const Musicpage({super.key});

  @override
  State<Musicpage> createState() => _MusicpageState();
}

class _MusicpageState extends State<Musicpage>
    with SingleTickerProviderStateMixin {
  final AudioPlayer audioPlayer = AudioPlayer();
  List<File> musicFiles = [];

  int currentIndex = 0;

  bool _ismuted = false;

  String? _music;
  late AnimationController _controller;

  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  double he = 0;
  bool repeat = false;
  bool shuffle = false;
  bool _isrotation = false;
  bool favorite = false;
  bool pause = false;
  bool arrow = false;

  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      _ismuted = !_ismuted;
      audioPlayer.setVolume(_ismuted ? 0.0 : 1.0); // Mute or unmute
    });
  }

  Future<void> _loadAudioFiles() async {
    final directory = await getExternalStorageDirectory();
    if (directory == null) {
      print("Failed to get external directory");
      return;
    }
    print("AUDIO FILES======================");
    print(directory);

    try {
      // final musicDirectory = Directory('${directory.path}');
      final musicDirectory = Directory('/storage/emulated/0/Music');
      if (await musicDirectory.exists()) {
        final audioFiles = musicDirectory
            .listSync()
            .where((file) =>
                file is File &&
                (file.path.endsWith('.mp3') || file.path.endsWith('.m4a')))
            .map((file) => file as File)
            .toList();

        setState(() {
          musicFiles = audioFiles;
        });
      }
      print("AUDIO FILES======================");
      print(musicFiles);
    } catch (e) {
      print("EXCEPTION");
      print(e);
    }
  }

  Future<void> playMusic(String filePath) async {
    try {
      await audioPlayer.setFilePath(filePath);
      await audioPlayer.play();
    } catch (e) {
      print("Error Playing audio:$e");
    }
  }

  Future<void> pausmusic(String filePath) async {
    try {
      await audioPlayer.setFilePath(filePath);
      await audioPlayer.play();
    } catch (e) {
      print("Error Playing audio:$e");
    }
  }

  // Future<void> playNext() async {
  //   setState(() {
  //     currentIndex = (currentIndex + 1) % musicFiles.length;
  //   });
  // }

  // Future<void> playPrevious() async {
  //   setState(() {
  //     currentIndex = (currentIndex - 1 + musicFiles.length) % musicFiles.length;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    String name = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      // backgroundColor:
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, const Color.fromARGB(255, 87, 86, 86)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: ListView(
            children: [
              Column(
                children: [
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
                              margin: EdgeInsets.only(left: 90, top: 10),
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
                            margin: EdgeInsets.only(left: 80),
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
                  SizedBox(
                    height: 60,
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
                                BoxShadow(blurRadius: 3, color: Colors.white)
                              ]),
                          alignment: Alignment.center,
                          child: AnimatedRotation(
                            turns: _isrotation ? 100 : -00,
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
                                      const Color.fromARGB(255, 160, 159, 159),
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
                                  BoxShadow(blurRadius: 1, color: Colors.white)
                                ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              child: Image.asset(
                                "./images/shapofyou.jpg",
                                fit: BoxFit.cover,
                              ),
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    // padding: EdgeInsets.only(left: 20),
                    width: 200,
                    child: Center(
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 20, top: 50),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _toggleMute();
                                });
                              },
                              icon: Icon(
                                Icons.mic_off_outlined,
                                color: const Color.fromARGB(255, 235, 233, 233),
                                size: 30,
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.only(top: 50, right: 20),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    favorite = !favorite;
                                  });
                                },
                                icon: favorite
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 30,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                        size: 30,
                                      ))),
                      ])
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                height: 3,
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),

                // child: ,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 40, top: 7),
                    child: Text(
                      "0:00",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 40, top: 7),
                    child: Text(
                      "4:00",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            shuffle = !shuffle;
                          });
                        },
                        icon: shuffle
                            ? Icon(
                                Icons.shuffle,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.shuffle,
                                color: Colors.white,
                                size: 25,
                              ),
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: IconButton(
                        onPressed: () {
                          // playPrevious();
                        },
                        icon: Icon(
                          Icons.skip_previous,
                          size: 50,
                          color: Colors.white,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: IconButton(
                          onPressed: () {
                            _toggleMute();
                            // _playAudio();
                            setState(() {
                              pause = !pause;
                              _isrotation = !_isrotation;
                            });
                          },
                          icon: pause
                              ? Icon(
                                  Icons.pause,
                                  size: 70,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.play_circle,
                                  color: Colors.white,
                                  size: 70,
                                ))),
                  Container(
                      margin: EdgeInsets.only(left: 5, right: 10),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            // playNext();
                          });
                        },
                        icon: Icon(
                          Icons.skip_next,
                          size: 50,
                          color: Colors.white,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            repeat = !repeat;
                          });
                        },
                        icon: repeat
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

              // showbottomsheet
            ],
          )),
    );
  }
}
