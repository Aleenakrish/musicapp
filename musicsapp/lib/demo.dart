// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/services.dart';

// class AudioPlayerPage extends StatefulWidget {
//   @override
//   _AudioPlayerPageState createState() => _AudioPlayerPageState();
// }

// class _AudioPlayerPageState extends State<AudioPlayerPage> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   List<File> _audioFiles = [];

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _requestPermissions();
//   // }

//   // Request necessary permissions
//   // void _requestPermissions() async {
//   //   var status = await Permission.storage.request();
//   //   if (status.isGranted) {
//   //     _loadAudioFiles();
//   //   } else {
//   //     // Handle permission denial
//   //      _loadAudioFiles();
//   //     print('Permission denied');
//   //   }
//   // }

//   // Load audio files from the device
//   // Future<void> _loadAudioFiles() async {
//   //   final directory = await getExternalStorageDirectory();
//   //   if (directory == null) {
//   //     print("Failed to get external directory");
//   //     return;
//   //   }
//   //   print("AUDIO FILES======================");
//   //   print(directory);

//   //   // Assuming that music files are in the Music folder, you can change this path as per your needs.
//   //   try {
//   //     final musicDirectory = Directory('${directory.path}');
//   //     // final musicDirectory = Directory('/storage/emulated/0/Music');
//   //     if (await musicDirectory.exists()) {
//   //       final audioFiles = musicDirectory
//   //           .listSync()
//   //           .where((file) =>
//   //               file is File &&
//   //               (file.path.endsWith('.mp3') || file.path.endsWith('.wav')))
//   //           .map((file) => file as File)
//   //           .toList();

//   //       setState(() {
//   //         _audioFiles = audioFiles;
//   //       });
//   //     }
//   //       print("AUDIO FILES======================");
//   //   print(_audioFiles);
//   //   } catch (e) {
//   //     print("EXCEPTION");
//   //     print(e);
//   //   }
//   // }

//   // Play selected audio
//   // void _playAudio(String filePath) async {
//   //   try {
//   //     await _audioPlayer.setFilePath(filePath);
//   //     _audioPlayer.play();
//   //   } on PlayerException catch (e) {
//   //     print("Error loading file: $e");
//   //   }
//   // }

//   // void _pauseAudio(String filePath) async {
//   //   try {
//   //     await _audioPlayer.setFilePath(filePath);
//   //     _audioPlayer.stop();
//   //   } on PlayerException catch (e) {
//   //     print("Error loading file: $e");
//   //   }
//   // }

//   // void _loop(String filePath) async {
//   //   try {
//   //     await _audioPlayer.setFilePath(filePath);
//   //     _audioPlayer.setVolume(100);
//   //   } on PlayerException catch (e) {
//   //     print("Error loading file: $e");
//   //   }
//   // }

//   // @override
//   // void dispose() {
//   //   _audioPlayer.dispose();
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Local Music Player'),
//       ),
//       body: _audioFiles.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: _audioFiles.length,
//               itemBuilder: (context, index) {
//                 final audioFile = _audioFiles[index];
//                 return ListTile(
//                   title: Text(audioFile.uri.pathSegments.last),
//                   onTap: () => _playAudio(audioFile.path),
//                   trailing: IconButton(
//                       onPressed: () {
//                         _pauseAudio(audioFile.path);
//                       },
//                       icon: Icon(Icons.abc)),
//                 );
//               },
//             ),
//     );
//   }
// }



















// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:just_audio/just_audio.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:permission_handler/permission_handler.dart';

// // class MusicPlayer extends StatefulWidget {
// //   @override
// //   _MusicPlayerState createState() => _MusicPlayerState();
// // }

// // class _MusicPlayerState extends State<MusicPlayer> {
// //   final AudioPlayer _audioPlayer = AudioPlayer();
// //   List<FileSystemEntity> _songs = [];
// //   bool _permissionDenied = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadSongs();
// //   }








// //   Future<void> _loadSongs() async {
// //     // Request permissions if not granted
// //     PermissionStatus permission = await Permission.storage.request();
    
// //     if (permission.isGranted) {
// //       // If permission is granted, proceed to load songs
// //       final directory = await getExternalStorageDirectory();
// //       final path = directory?.path;
// //       if (path != null) {
// //         final songsDir = Directory(path);
// //         final songFiles = songsDir.listSync().where((item) {
// //           return item.path.endsWith('.mp3') || item.path.endsWith('.wav');
// //         }).toList();

// //         setState(() {
// //           _songs = songFiles;
// //           _permissionDenied = false;
// //         });
// //       }
// //     } else if (permission.isDenied) {
// //       // If permission is denied but not permanently, you can show a request again
// //       setState(() {
// //         _permissionDenied = true;
// //       });
// //     } else if (permission.isPermanentlyDenied) {
// //       // If permission is permanently denied (e.g., the user chose "Don't ask again"),
// //       // show a message with the option to go to settings
// //       setState(() {
// //         _permissionDenied = true;
// //       });
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _audioPlayer.dispose();
// //     super.dispose();
// //   }

// //   void _openSettings() async {
// //     // Open the app settings for the user to manually enable permissions
// //     await openAppSettings();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Local Music Player"),
// //       ),
// //       body: _permissionDenied
// //           ? Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Text(
// //                     "Storage permission is required to access local music.",
// //                     textAlign: TextAlign.center,
// //                     style: TextStyle(fontSize: 16),
// //                   ),
// //                   SizedBox(height: 20),
// //                   ElevatedButton(
// //                     onPressed: _openSettings,
// //                     child: Text("Open App Settings"),
// //                   ),
// //                 ],
// //               ),
// //             )
// //           : _songs.isEmpty
// //               ? Center(child: CircularProgressIndicator())
// //               : ListView.builder(
// //                   itemCount: _songs.length,
// //                   itemBuilder: (context, index) {
// //                     final song = _songs[index];
// //                     return ListTile(
// //                       title: Text(song.path.split('/').last),
// //                       onTap: () async {
// //                         await _audioPlayer.setFilePath(song.path);
// //                         await _audioPlayer.play();
// //                       },
// //                     );
// //                   },
// //                 ),
// //     );
// //   }
// // }

// // void main() {
// //   runApp(MaterialApp(
// //     home: MusicPlayer(),
// //   ));
// // }

