import 'package:flutter/material.dart';
// import 'package:musicapp/animationpage.dart';
import 'package:musicapp/loginpage.dart';
import 'package:musicapp/musicpage.dart';
import 'package:musicapp/songslist.dart';

void main() {
  runApp(MaterialApp(
    home: Loginpage(),
    routes: {
      "musicapp": (context) => Musicpage(),
      "songslist": (context) => Songslist(),
      
    },
  ));
}
