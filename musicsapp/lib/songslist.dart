import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/loginpage.dart';
import 'package:musicapp/musicpage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class Songslist extends StatefulWidget {
  const Songslist({super.key});

  @override
  State<Songslist> createState() => _SongslistState();
}

class _SongslistState extends State<Songslist>
    with SingleTickerProviderStateMixin {
  bool play = false;
  late TabController _tabController;
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<File> _audioFiles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _requestPermissions();
  }

  void dispose() {
    // Dispose of the TabController to avoid memory leaks
    _tabController.dispose();
    super.dispose();
  }

  void _requestPermissions() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      _loadAudioFiles();
    } else {
      // Handle permission denial
      _loadAudioFiles();
      print('Permission denied');
    }
  }

  Future<void> _loadAudioFiles() async {
    final directory = await getExternalStorageDirectory();
    if (directory == null) {
      print("Failed to get external directory");
      return;
    }
    print("AUDIO FILES======================");
    print(directory);

    // Assuming that music files are in the Music folder, you can change this path as per your needs.
    try {
      final musicDirectory = Directory('${directory.path}');
      // final musicDirectory = Directory('/storage/emulated/0/Music');
      if (await musicDirectory.exists()) {
        final audioFiles = musicDirectory
            .listSync()
            .where((file) =>
                file is File &&
                (file.path.endsWith('.mp3') || file.path.endsWith('.wav')))
            .map((file) => file as File)
            .toList();

        setState(() {
          _audioFiles = audioFiles;
        });
      }
      print("AUDIO FILES======================");
      print(_audioFiles);
    } catch (e) {
      print("EXCEPTION");
      print(e);
    }
  }

  void _playAudio(String filePath) async {
    try {
      await _audioPlayer.setFilePath(filePath);
      _audioPlayer.play();
    } on PlayerException catch (e) {
      print("Error loading file: $e");
    }
  }

  void _pauseAudio(String filePath) async {
    try {
      await _audioPlayer.setFilePath(filePath);
      _audioPlayer.stop();
    } on PlayerException catch (e) {
      print("Error loading file: $e");
    }
  }

  void _loop(String filePath) async {
    try {
      await _audioPlayer.setFilePath(filePath);
      _audioPlayer.setVolume(100);
    } on PlayerException catch (e) {
      print("Error loading file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, const Color.fromARGB(255, 87, 86, 86)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, top: 40),
              child: Text(
                "Hai Aleena.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(
                            colors: [
                              Colors.black,
                              const Color.fromARGB(255, 160, 159, 159),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)),
                    child: Center(
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25,
                          )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: [
                          const Color.fromARGB(255, 37, 37, 37),
                          const Color.fromARGB(255, 112, 112, 112)
                        ])),
                    height: 55,
                    width: 300,
                    child: Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          child: Expanded(
                              child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: " Search....",
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )),
                        ),
                        Container(
                            // margin: EdgeInsets.only(),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color:
                                      const Color.fromARGB(255, 243, 242, 242),
                                  // size: 20,
                                )))
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: TabBar(
                  labelColor: const Color.fromARGB(255, 241, 238, 238),
                  unselectedLabelColor: Colors.white,
                  dividerColor: Colors.transparent,
                  indicatorColor: const Color.fromARGB(255, 175, 172, 172),
                  controller: _tabController,
                  tabs: [
                    Tab(
                      text: "All Songs",
                    ),
                    Tab(
                      text: "Artist",
                    ),
                    Tab(
                      text: "Albums",
                    ),
                    Tab(
                      text: "Favourite",
                    )
                  ]),
            ),
            Expanded(
                child: TabBarView(controller: _tabController, children: [
              Container(
                  child: _audioFiles.isEmpty
                      ? Center(child: Container())
                      : ListView.builder(
                          itemCount: _audioFiles.length,
                          itemBuilder: (context, index) {
                            final audioFile = _audioFiles[index];
                            return ListTile(
                                onLongPress: () {
                                  showBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(25)),
                                            color: const Color.fromARGB(
                                                255, 44, 43, 43),
                                          ),
                                          height: 440,
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Container(
                                                // margin: EdgeInsets.only(left: 100),
                                                alignment:
                                                    AlignmentDirectional.topEnd,
                                                child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Songslist()));
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel_outlined,
                                                      color: Colors.grey,
                                                    )),
                                              ),
                                              Container(
                                                // padding: EdgeInsets.only(top: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: const Color.fromARGB(
                                                      255, 44, 43, 43),
                                                ),
                                                // height: 400,
                                                child: Text(
                                                  "Shap of You",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  "Ed Sheeran",
                                                  style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 216, 215, 215),
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 1,
                                                width: 370,
                                                color: Colors.grey,
                                                // child: ,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              // Container(
                                              //   child: Row(
                                              //     children: [
                                              //       Container(
                                              //         child: IconButton(onPressed: (){},
                                              //          icon: Icon(Icons.favorite_outline,color: Colors.grey,)),
                                              //       ),
                                              //       Container(
                                              //         padding: EdgeInsets.only(left: 10),
                                              //         child: Text("Favorite",
                                              //         style: TextStyle(fontSize: 16, color: Colors.white),),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),
                                              Row(
                                                children: [
                                                  Container(
                                                    child: IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons
                                                              .add_circle_outline_outlined,
                                                          color: Colors.grey,
                                                        )),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      "Add to playlist",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    child: IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons
                                                              .highlight_off_rounded,
                                                          color: Colors.grey,
                                                        )),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      "Hide this song",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    child: IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.album_rounded,
                                                          color: Colors.grey,
                                                        )),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      "Go to album",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    child: IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.person,
                                                          color: Colors.grey,
                                                        )),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      "Go to artist",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    child: IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.share_outlined,
                                                          color: Colors.grey,
                                                        )),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      "Share",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    child: IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons
                                                              .diamond_outlined,
                                                          color: Colors.grey,
                                                        )),
                                                  ),
                                                  Container(
                                                    // padding: EdgeInsets.only(left: 10),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child: TextButton(
                                                            onPressed: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  "addfreepage");
                                                            },
                                                            child: Text(
                                                              "Listen to music ad-free",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        )
                                                        // Text("Listen to music ad-free",style: TextStyle(fontSize: 16, color: Colors.white),),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ));
                                    },
                                  );
                                },
                                title: Text(
                                  audioFile.uri.pathSegments.last,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  _playAudio(audioFile.path);
                                  Navigator.pushNamed(context, "musicapp");
                                },
                                trailing: IconButton(
                                    onPressed: () {
                                      _pauseAudio(audioFile.path);
                                    },
                                    icon: Icon(
                                      Icons.abc,
                                      color: Colors.white,
                                    ))

                                // title: Container(
                                //   child: Container(
                                //       // height: 50,
                                //       color: Colors.transparent,
                                //       child: Row(
                                //         children: [
                                //           Container(
                                //             margin: EdgeInsets.only(left: 10),
                                //             height: 70,
                                //             width: 70,
                                //             decoration: BoxDecoration(
                                //                 borderRadius:
                                //                     BorderRadius.circular(15),
                                //                 color: Colors.transparent),
                                //             child: ClipRRect(
                                //               borderRadius:
                                //                   BorderRadius.circular(15),
                                //               child: Image.asset(
                                //                 "./images/shapofyou.jpg",
                                //                 fit: BoxFit.cover,
                                //               ),
                                //             ),
                                //           ),
                                //           Container(
                                //             child: Column(
                                //               children: [
                                //                 Container(
                                //                   padding: EdgeInsets.only(
                                //                       top: 4, left: 15),
                                //                   child: Text(
                                //                     "Shape of You",
                                //                     style: TextStyle(
                                //                         color: Colors.white,
                                //                         fontSize: 16),
                                //                   ),
                                //                 ),
                                //                 Container(
                                //                   child: Text("Ed Sheeran",
                                //                       style: TextStyle(
                                //                           fontSize: 15,
                                //                           color: const Color
                                //                               .fromARGB(255, 156,
                                //                               156, 156))),
                                //                 )
                                //               ],
                                //             ),
                                //           ),
                                //           Spacer(),
                                //           Container(
                                //             child: IconButton(
                                //                 onPressed: () {
                                //                   setState(() {
                                //                     play = !play;
                                //                   });
                                //                 },
                                //                 icon: play
                                //                     ? Icon(
                                //                         Icons.pause,
                                //                         size: 35,
                                //                         color: Colors.white,
                                //                       )
                                //                     : Icon(
                                //                         Icons.play_arrow,
                                //                         color: Colors.white,
                                //                         size: 35,
                                //                       )),
                                //           )
                                //         ],
                                //       )),
                                // ),?
                                );
                          })),
              Container(
                child: Center(
                  child: Text("no songs"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("no songs"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("no songs"),
                ),
              )
            ]))
          ],
        ),
      ),
    );
  }
}
