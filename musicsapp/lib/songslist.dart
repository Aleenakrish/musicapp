import 'package:flutter/material.dart';
import 'package:musicapp/loginpage.dart';
import 'package:musicapp/musicpage.dart';

class Songslist extends StatefulWidget {
  const Songslist({super.key});

  @override
  State<Songslist> createState() => _SongslistState();
}

class _SongslistState extends State<Songslist>
    with SingleTickerProviderStateMixin {
  bool play = false;
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void dispose() {
    // Dispose of the TabController to avoid memory leaks
    _tabController.dispose();
    super.dispose();
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
                                onPressed: () {
                                  Navigator.pushNamed(context, "musicapp");
                                },
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
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Container(
                              // height: 50,
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.transparent),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        "./images/shapofyou.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.only(top: 4, left: 15),
                                          child: Text(
                                            "Shape of You",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Container(
                                          child: Text("Ed Sheeran",
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 156, 156, 156))),
                                        )
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            play = !play;
                                          });
                                        },
                                        icon: play
                                            ? Icon(
                                                Icons.pause,
                                                size: 35,
                                                color: Colors.white,
                                              )
                                            : Icon(
                                                Icons.play_circle,
                                                color: Colors.white,
                                                size: 40,
                                              )),
                                  )
                                ],
                              )),
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
