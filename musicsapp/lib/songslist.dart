import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/loginpage.dart';
import 'package:musicapp/musicpage.dart';
import 'package:musicapp/provider/changenotifier.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
// import 'package:hive_flutter/hive_flutter.dart';

class Songslist extends StatefulWidget {
  const Songslist({super.key});

  @override
  State<Songslist> createState() => _SongslistState();
}

class _SongslistState extends State<Songslist>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController search = TextEditingController();
  List<File> _audiofiles = [];
  final AudioPlayer audioPlayer = AudioPlayer();

  final AudioPlayer player = AudioPlayer();

  bool icon = false;
  late AnimationController controller;

  final _favorite = Hive.box("mybox");
  List favorit = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    data();
    // requestPermission().then((_) => loadMusicFiles());
    favortes();
    playNext();
  }

  Future<void> loadMusicFiles() async {
    _audiofiles = await getMusicFile();
    setState(() {});
    data();
  }

  void data() {
    var data = Provider.of<providerr>(context, listen: false);
    data.loadMusicFiles();
  }

  Future<void> requestPermission() async {
    if (await Permission.storage.request().isGranted ||
        await Permission.manageExternalStorage.request().isGranted) {
      print("permmission granted");
    } else {
      print("permission denied");
    }
  }

  Future<List<File>> getMusicFile() async {
    final directory = await getExternalStorageDirectory();
    // final musicDirectory = Directory('${directory.path}');
    final musicDirectory = Directory('/storage/emulated/0/Music');
    if (musicDirectory.existsSync()) {
      return musicDirectory
          .listSync()
          .where((file) => file.path.endsWith(".m4a"))
          .map((file) => File(file.path))
          .toList();
    } else {
      return [];
    }
  }

  final Player = AudioPlayer();
  Future<void> playMusic(String filePath) async {
    try {
      await Player.play();
    } catch (e) {
      print("Error Playing audio:$e");
    }
  }

  void favortes() {
    if (_favorite.get("key") != null) {
      favorit = _favorite.get("key");
    }
    print("===================================");
  }

  void playNext() {
    Provider.of<providerr>(context, listen: false).automaticNext();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }


  ///////////////callbackfunction///////////argument pass cheyyan vendi

  

  @override
  Widget build(BuildContext context) {
    return Consumer<providerr>(
        builder: (context, Music, child) => Scaffold(
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black,
                  const Color.fromARGB(255, 87, 86, 86)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
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
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.cancel_outlined,
                                          color: const Color.fromARGB(
                                              255, 243, 242, 242),
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
                          indicatorColor:
                              const Color.fromARGB(255, 175, 172, 172),
                          controller: _tabController,
                          tabs: [
                            Tab(
                              text: "All Songs",
                            ),
                            Tab(
                              text: "Albums",
                            ),
                            // Tab(
                            //   text: "Artist",
                            // ),
                            Tab(
                              text: "Favourite",
                            )
                          ]),
                    ),
                    Expanded(
                      child: TabBarView(controller: _tabController, children: [
                        Container(
                            child: Music.audiofiles.isEmpty
                                ? Center(
                                    child: Text(
                                      "No music ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        padding: EdgeInsets.only(top: 10),
                                        itemCount: Music.audiofiles.length,
                                        itemBuilder: (context, index) {
                                          final file = Music.audiofiles[index];
                                          return ListTile(
                                            onLongPress: () {
                                              showBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        25)),
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 44, 43, 43),
                                                      ),
                                                      height: 400,
                                                      width: double.infinity,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            // margin: EdgeInsets.only(left: 100),
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .topEnd,
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  Navigator.pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Songslist()));
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .cancel_outlined,
                                                                  color: Colors
                                                                      .grey,
                                                                )),
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
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .add_circle_outline_outlined,
                                                                          color:
                                                                              Colors.grey,
                                                                        )),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  "Add to playlist",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .highlight_off_rounded,
                                                                          color:
                                                                              Colors.grey,
                                                                        )),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  "Hide this song",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .album_rounded,
                                                                          color:
                                                                              Colors.grey,
                                                                        )),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  "Go to album",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .person,
                                                                          color:
                                                                              Colors.grey,
                                                                        )),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  "Go to artist",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .share_outlined,
                                                                          color:
                                                                              Colors.grey,
                                                                        )),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  "Share",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .diamond_outlined,
                                                                          color:
                                                                              Colors.grey,
                                                                        )),
                                                              ),
                                                              Container(
                                                                // padding: EdgeInsets.only(left: 10),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pushNamed(
                                                                              context,
                                                                              "addfreepage");
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Listen to music ad-free",
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              color: Colors.white),
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

                                            //////////////////////////////ontap////////////////

                                            onTap: () {
                                              Music.playMusic(file.path);
                                              // audioPlayer
                                              //     .setFilePath(file.path);

                                              Music.currentsongIndex = index;
                                              Music.isPlay = true;

                                              Navigator.pushNamed(
                                                  context, "musicapp",
                                                  arguments: file.path);
                                              Music.name = file.path;
                                            },
                                            title: Container(
                                                // margin: EdgeInsets.only(top: 5),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 70,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // margin: EdgeInsets.only(left: 5),
                                                      height: 70,
                                                      width: 70,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: Colors
                                                              .transparent),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Image.asset(
                                                          "./images/log.jpeg",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          child: Text(
                                                            file.path
                                                                .split("/")
                                                                .last
                                                                .split("-")
                                                                .first,
                                                            style: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 250,
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
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            // ),
                                          );
                                        }),
                                  )),

                        /////////////////////////////////////////////////////////////////////////////album

                        Container(
                            child: ListView.builder(
                                padding: EdgeInsets.only(top: 16),
                                itemCount: Music.audiofiles.length,
                                itemBuilder: (context, index) {
                                  final file = Music.audiofiles[index];
                                  return GestureDetector(
                                    onTap: () async {
                                      await audioPlayer.setFilePath(file.path);
                                      audioPlayer.play();
                                      Music.isPlay = true;
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 16, top: 10),
                                      child: Row(
                                        children: [
                                          Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        const Color.fromARGB(
                                                            255, 37, 37, 37),
                                                        const Color.fromARGB(
                                                            255, 112, 112, 112)
                                                      ])),
                                              child: Icon(
                                                Icons.music_note,
                                                color: Colors.white,
                                                size: 25,
                                              )),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 16),
                                                child: Container(
                                                  width: 250,
                                                  child: Text(
                                                    file.path
                                                        .split("/")
                                                        .last
                                                        .split("-")
                                                        .first,
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: Colors.white,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 270,
                                                padding: EdgeInsets.only(
                                                  left: 16,
                                                ),
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                        //////////////////////////////////////////////////////////////////////artist
                        // Container(
                        //     child: ListView.builder(
                        //         padding: EdgeInsets.all(10),
                        //         itemCount: Music.audiofiles.length,
                        //         itemBuilder: (context, index) {
                        //           final file = Music.audiofiles[index];

                        //           return Container(
                        //               child: Row(
                        //             children: [
                        //               Container(
                        //                 margin: EdgeInsets.all(5),
                        //                 width: 70,
                        //                 height: 70,
                        //                 decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(100),
                        //                     gradient: LinearGradient(colors: [
                        //                       const Color.fromARGB(
                        //                           255, 37, 37, 37),
                        //                       const Color.fromARGB(
                        //                           255, 112, 112, 112)
                        //                     ])),
                        //                 child: Icon(
                        //                   Icons.person,
                        //                   size: 35,
                        //                   color: Colors.grey,
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 width: 10,
                        //               ),
                        //               Container(
                        //                 width: 250,
                        //                 child: Text(
                        //                   file.path
                        //                       .split("/")
                        //                       .last
                        //                       .split("-")
                        //                       .last
                        //                       .substring(
                        //                           0,
                        //                           file.path
                        //                                   .split("/")
                        //                                   .last
                        //                                   .split("-")
                        //                                   .last
                        //                                   .length -
                        //                               4),
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: 13),
                        //                 ),
                        //               )
                        //             ],
                        //           ));
                        //         })),

                        //////////////////////////////////////////////////////////favorite
                        Container(
                            child: Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.only(top: 5, left: 10),
                                    itemCount: favorit.length,
                                    itemBuilder: (context, index) {
                                      final file = favorit[index];
                                      return GestureDetector(
                                        onTap: () async {
                                          player.play();
                                          await player.setFilePath(file);
                                         setState(() {
                                            Music.isPlay = true;

                                         });
                                          Navigator.pushNamed(
                                              context, "musicapp",
                                              arguments: file);
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(top: 20),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 60,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            const Color
                                                                .fromARGB(255,
                                                                37, 37, 37),
                                                            const Color
                                                                .fromARGB(255,
                                                                112, 112, 112)
                                                          ])),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Image.asset(
                                                      "./images/log.jpeg",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 250,
                                                      child: Text(
                                                        file
                                                            .split("/")
                                                            .last
                                                            .split("-")
                                                            .first,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 250,
                                                      child: Text(
                                                        file
                                                            .split("/")
                                                            .last
                                                            .split("-")
                                                            .last
                                                            .substring(
                                                                0,
                                                                file
                                                                        .split(
                                                                            "/")
                                                                        .last
                                                                        .split(
                                                                            "-")
                                                                        .last
                                                                        .length -
                                                                    4),
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )),
                                      );
                                    }))),
                      ]),
                    ),
                    // Music.isPlay
                    //     ? GestureDetector(
                    //         onTap: () {
                    //           Navigator.pushNamed(context, "musicapp");
                    //         },
                    //         child: Container(
                    //           height: 70,
                    //           width: MediaQuery.of(context).size.width,
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(15),
                    //               gradient: LinearGradient(colors: [Colors.black,Colors.grey])),
                    //           child: Row(
                    //             children: [
                    //               Container(
                    //                 padding: EdgeInsets.only(left: 10),
                    //                 height: 62,
                    //                 width: 62,
                    //                 decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(20),
                    //                     color: Colors.transparent),
                    //                 child: ClipRRect(
                    //                   child: Image.asset(
                    //                     "./images/log.jpeg",
                    //                     fit: BoxFit.cover,
                    //                   ),
                    //                   borderRadius: BorderRadius.circular(20),
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 width: 10,
                    //               ),
                    //               Column(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceEvenly,
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: [
                    //                     Container(
                    //                       width: 230,
                    //                       height: 20,
                    //                       child: Text(
                    //                         Music.name
                    //                             .split("/")
                    //                             .last
                    //                             .split("-")
                    //                             .first,
                    //                         style: TextStyle(
                    //                             color: Colors.white,
                    //                             fontSize: 15),
                    //                       ),
                    //                     ),
                    //                     Container(
                    //                       width: 200,
                    //                       height: 15,
                    //                       child: Text(
                    //                         Music.name
                    //                             .split("/")
                    //                             .last
                    //                             .split("-")
                    //                             .last
                    //                             .substring(
                    //                                 0,
                    //                                 Music.name
                    //                                         .split("/")
                    //                                         .last
                    //                                         .split("-")
                    //                                         .last
                    //                                         .length -
                    //                                     4),
                    //                         style: TextStyle(
                    //                             color: Colors.white,
                    //                             fontSize: 12),
                    //                       ),
                    //                     ),   
                    //                   ]),
                    //                   // IconButton(
                    //                   //     alignment: Alignment.center,
                    //                   //     style: IconButton.styleFrom(
                    //                   //         backgroundColor:
                    //                   //             const Color.fromARGB(
                    //                   //                 255, 40, 6, 97)),
                    //                   //     onPressed: () {
                    //                   //       setState(() {
                    //                   //         Music.Icon = !Music.Icon;

                    //                   //        Music.Icon
                    //                   //             ? controller.forward()
                    //                   //             : controller.reverse();
                    //                   //         Music.Icon
                    //                   //             ? Music.player.pause()
                    //                   //             : Music.player.play();
                    //                   //       });
                    //                   //     },
                    //                   //     icon: AnimatedIcon(
                    //                   //         icon: AnimatedIcons.pause_play,
                    //                   //         size: 30,
                    //                   //         color: Colors.white,
                    //                   //         progress: controller)),
                                  
                    //               //               
                    //             ],
                    //           ),
                    //         ),
                    //       )
                        // : Container(),
                        Container(
                          height: 5,
                        )
                  ],
                ),
              ),
              
            )
            );
  }
   
}
