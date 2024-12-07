import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/adfreepage.dart';
import 'package:musicapp/demo.dart';
// import 'package:musicapp/animationpage.dart';
import 'package:musicapp/loginpage.dart';
import 'package:musicapp/musicpage.dart';
import 'package:musicapp/songslist.dart';

void main() {
  runApp(MaterialApp(
    home: Songslist(),
    routes: {
      "musicapp": (context) => Musicpage(),
      "songslist": (context) => Songslist(),
      "addfreepage": (context) => Addfreepage()
    },
  ));
}
