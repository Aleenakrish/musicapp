import 'package:flutter/material.dart';

class Songslist extends StatefulWidget {
  const Songslist({super.key});

  @override
  State<Songslist> createState() => _SongslistState();
}

class _SongslistState extends State<Songslist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, const Color.fromARGB(255, 87, 86, 86)])),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, top: 10),
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
                        gradient: LinearGradient(colors: [
                          const Color.fromARGB(255, 20, 20, 20),
                          const Color.fromARGB(255, 100, 99, 99)
                        ])),
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
          ],
        ),
      ),
    );
  }
}
