import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/adfreepage.dart';
import 'package:musicapp/demo.dart';
import 'package:musicapp/favoritepage.dart';

import 'package:musicapp/loginpage.dart';
import 'package:musicapp/musicpage.dart';
import 'package:musicapp/provider/changenotifier.dart';
import 'package:provider/provider.dart';
import 'package:musicapp/songslist.dart';

void main() async {
  await Hive.initFlutter();
  var favorite = await Hive.openBox("mybox");
  runApp(ChangeNotifierProvider(
      create: (context) => providerr(),
      child: MaterialApp(
        home: Loginpage(),
        routes: {
          // "songslist":(context)=>Songslist(),
          "musicapp": (context) => Musicpage(),
          "songslist": (context) => Songslist(),
          "addfreepage": (context) => Addfreepage(),
          
        },
      )));
}
