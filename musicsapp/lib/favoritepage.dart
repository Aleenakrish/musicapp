// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// class FavoriteMusiclist extends StatefulWidget {
//   const FavoriteMusiclist({super.key});

//   @override
//   State<FavoriteMusiclist> createState() => _FavoriteMusiclistState();
// }

// class _FavoriteMusiclistState extends State<FavoriteMusiclist> {
//   List favorite = [];
//   final _favorite = Hive.box("mybox");

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           iconTheme: IconThemeData(color: Colors.white),
//           backgroundColor: Colors.transparent,
//         ),
//         body: Container(
//           padding: EdgeInsets.all(10),
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 const Color.fromARGB(255, 55, 15, 124),
//                 Colors.black,
//               ],
//               end: Alignment.topCenter,
//               begin: Alignment.bottomCenter,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 100,
//               ),
//               Row(
//                 children: [
//                   Icon(
//                     Icons.favorite,
//                     color: Colors.white,
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     "Your Favorite Playlist",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 25,
//                         fontFamily: "Schyler"),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ));
//   }
// }
