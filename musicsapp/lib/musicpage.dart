import 'package:flutter/material.dart';

class Musicpage extends StatefulWidget {
  const Musicpage({super.key});

  @override
  State<Musicpage> createState() => _MusicpageState();
}

class _MusicpageState extends State<Musicpage> {
  bool repeat = false;
  bool shuffle = false;
  bool _isrotation = false;
  bool favorite = false;
  bool play = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:
      body: Container(
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
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            )),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 90, top: 10),
                              child: Text(
                                "NOW PLAYING",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: const Color.fromARGB(
                                        255, 209, 208, 208)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 90, top: 5),
                              child: Text(
                                "Shape of You",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 70),
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
                              // child: Container(
                              //     height: 210,
                              //     width: 210,
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(150),
                              //         color: Colors.white,
                              //         boxShadow: [
                              //           BoxShadow(
                              //               blurRadius: 1, color: Colors.white)
                              //         ]),
                              //     child: ClipRRect(
                              //       borderRadius: BorderRadius.circular(150),
                              //       child: Image.asset(
                              //         "./images/log.jpeg",
                              //         fit: BoxFit.cover,
                              //       ),
                              //     )),
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
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "Shape of You",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    child: Text(
                      "Ed Sheeran",
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 139, 139, 139),
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 50),
                          child: Icon(
                            Icons.share_outlined,
                            color: const Color.fromARGB(255, 235, 233, 233),
                            size: 30,
                          ),
                        ),
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
                      margin: EdgeInsets.only(left: 10),
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
                    margin: EdgeInsets.only(left: 30),
                    child: Icon(
                      Icons.skip_previous,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              play = !play;
                              _isrotation = !_isrotation;
                            });
                          },
                          icon: play
                              ? Icon(
                                  Icons.play_circle,
                                  size: 70,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                  size: 70,
                                ))),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 20),
                    child: Icon(
                      Icons.skip_next,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10),
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
              )
            ],
          )),
    );
  }
}
