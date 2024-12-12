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
  bool _ismuted = false;
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

  // void _playMusic() async {
  //   int result = await _audioFiles.play("storage/emulated/0/Music");
  //   if (result == 1) {
  //     // Success
  //     print('Music started');
  //   }
  // }

  // void _stopMusic() async {
  //   int result = ();
  //   if (result == 1) {
  //     // Success
  //     print('Music stopped');
  //   }
  // }

  // Function to mute or unmute the music
  void _toggleMute() {
    setState(() {
      _ismuted = !_ismuted;
      _audioPlayer.setVolume(_ismuted ? 0.0 : 3.0); // Mute or unmute
    });
  }

  void dispose() {
    // Dispose of the TabController to avoid memory leaks
    setState(() {
      _tabController.dispose();
      super.dispose();
    });
  }

  void _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    var storage = statuses[Permission.storage];
    var manageExternalStorage = statuses[Permission.manageExternalStorage];

    var status = await Permission.storage.request();
    if (status.isGranted || await Permission.manageExternalStorage.isGranted) {
      _loadAudioFiles();
    } else {
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
                child: Container(
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
                                              // Container(
                                              //   // padding: EdgeInsets.only(top: 5),
                                              //   decoration: BoxDecoration(
                                              //     borderRadius:
                                              //         BorderRadius.circular(25),
                                              //     color: const Color.fromARGB(
                                              //         255, 44, 43, 43),
                                              //   ),
                                              //   // height: 400,
                                              //   child: Text(
                                              //     "Shap of You",
                                              //     style: TextStyle(
                                              //         color: Colors.white,
                                              //         fontSize: 18,
                                              //         fontWeight:
                                              //             FontWeight.bold),
                                              //   ),
                                              // ),
                                              // Container(
                                              //   child: Text(
                                              //     "Ed Sheeran",
                                              //     style: TextStyle(
                                              //       color: const Color.fromARGB(
                                              //           255, 216, 215, 215),
                                              //       fontSize: 13,
                                              //     ),
                                              //   ),
                                              // ),
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
                                title: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(left: 5),
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.transparent),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                            "./images/log.jpeg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 200,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              audioFile.path
                                                  .split("/")
                                                  .last
                                                  .split("-")
                                                  .first,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              audioFile.path
                                                  .split("/")
                                                  .last
                                                  .split("-")
                                                  .last
                                                  .substring(
                                                      0,
                                                      audioFile.path
                                                              .split("/")
                                                              .last
                                                              .split("-")
                                                              .last
                                                              .length -
                                                          5),
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  _playAudio(audioFile.path);
                                  // Navigator.pushNamed(context, "musicapp",
                                  //     arguments: audioFile.path);
                                  Navigator.pushNamed(context, "musicapp",
                                      arguments: audioFile.path
                                          .split("/")
                                          .last
                                          .split("-")
                                          .first
                                          .toString());
                                },
                                trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _toggleMute();
                                        _pauseAudio(audioFile.path);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.more_vert_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                              );
                            })),
              ),
              Container(
                  child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: _audioFiles.length,
                      itemBuilder: (context, index) {
                        final file = _audioFiles[index];

                        return Container(
                            child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey,
                              ),
                              child: Icon(
                                Icons.person,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 220,
                              child: Text(
                                file.path
                                    .split("/")
                                    .last
                                    .split("-")
                                    .last
                                    .substring(
                                        0,
                                        file.path
                                                .split("/")
                                                .last
                                                .split("-")
                                                .last
                                                .length -
                                            4),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            )
                          ],
                        ));
                      })),
              Container(
                  child: ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      itemCount: _audioFiles.length,
                      itemBuilder: (context, index) {
                        final file = _audioFiles[index];
                        return GestureDetector(
                          onTap: () async {
                            await _audioPlayer.setFilePath(file.path);
                            _audioPlayer.play();
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            child: Row(
                              children: [
                                Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey),
                                    child: Icon(
                                      Icons.music_note,
                                      color: Colors.white,
                                      size: 25,
                                    )),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        file.path
                                            .split("/")
                                            .last
                                            .split("-")
                                            .first,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                    Container(
                                      width: 290,
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        file.path
                                            .split("/")
                                            .last
                                            .split("-")
                                            .last
                                            .substring(
                                                0,
                                                file.path
                                                        .split("/")
                                                        .last
                                                        .split("-")
                                                        .last
                                                        .length -
                                                    4),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
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
