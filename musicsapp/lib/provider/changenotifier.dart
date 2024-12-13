
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class providerr  extends ChangeNotifier{

  final AudioPlayer player = AudioPlayer();
  List<File> audiofiles = [];

  bool rotation = false;

  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  int currentsongIndex = 0;
  late AnimationController _controller;

   int currentIndex = 0;


  final _favorite = Hive.box("mybox");
  List favorit = [];


  bool Icon = false;
  bool _isrotation = false;
  bool Shuffle = false;
  bool repeat = false;
  bool muted = false;
  bool arrow = false;


 Future<void> loadMusicFiles() async {
    await requestPermission();

    var files = await getMusicFile();
    notifyListeners();
    audiofiles = files;
    print(audiofiles);
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
    // final directory = await getExternalStorageDirectory();
    final musicDir = Directory("/storage/emulated/0/Music");

    if (musicDir.existsSync()) {
      return musicDir
          .listSync()
          .where((file) => file.path.endsWith(".m4a"))
          .map((file) => File(file.path))
          .toList();
    } else {
      return [];
    }
  }


  Future<void> playMusic(String filePath) async {
    try {
      await player.setFilePath(filePath);
      await player.play();
    } catch (e) {
      print("Error Playing audio:$e");
    }
  }

  String? _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void duration(){
    player.positionStream.listen((position) {
     currentPosition = position;
     notifyListeners();
    });

    player.durationStream.listen((duration) {
        totalDuration = duration ?? Duration.zero;
        notifyListeners();
      });
    
  }

    void _toggleRepeat() {
    
      repeat = !repeat;

    if (repeat) {
      // Loop the song
      player.setLoopMode(LoopMode.one);
    } else {
      // Stop the loop (it will play once)
      player.setLoopMode(LoopMode.off);
    }
  }

  Future<void> playNext() async {
    
      currentIndex = (currentIndex + 1) % audiofiles.length;
  
    playMusic(audiofiles[currentIndex].path);
    // playMusic(audiofiles[currentIndex].uri.pathSegments.last);
  }
  Future<void> playName() async {
    
      currentIndex = (currentIndex + 1) % audiofiles.length;
  
    // playMusic(audiofiles[currentIndex].path);
    // playMusic(audiofiles[currentIndex].uri.pathSegments.last);
    audiofiles[currentIndex].uri.pathSegments.last;
  }
 
  Future<void> playPrevious() async {
    
      currentIndex = (currentIndex - 1 + audiofiles.length) % audiofiles.length;
    
    playMusic(audiofiles[currentIndex].path);
  }

  void favortes() {
    if (_favorite.get("key") != null) {
      favorit = _favorite.get("key");
    }
    print("===================================");
  }
  


}