import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  double _opacity = 0.0;
  @override
  void initState() {
    super.initState();
    // Delay the fade-in animation
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  //https://i1.sndcdn.com/avatars-cdAKzhi1JITtzW6V-qDBkHQ-t1080x1080.jpg
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, const Color.fromARGB(255, 87, 86, 86)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: ListView(
            children: [
              Container(
                height: 80,
                // color: Colors.black,
                child: Row(
                  children: [
                    // Container(
                    //     child: IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(
                    //           Icons.arrow_back,
                    //           color: Colors.white,
                    //         ))),
                    SizedBox(
                      width: 120,
                    ),
                    // Container(
                    //   // height: 60,
                    //   // width: 70,
                    //   child: Center(
                    //       child: Text(
                    //     "Login",
                    //     style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold),
                    //   )),
                    // )
                  ],
                ),
              ),
              // SizedBox(
              //   height: 40,
              // ),
              // Container(
              //   child: Center(
              //       child: Text(
              //     "Welcome",
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 27,
              //         fontWeight: FontWeight.bold),
              //   )),
              // ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 310,
                width: 310,
                alignment: Alignment.center,
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      color: const Color.fromARGB(255, 104, 103, 103)),
                  alignment: Alignment.center,
                  child: Center(
                    child: AnimatedOpacity(
                        opacity: _opacity,
                        duration: Duration(seconds: 4),
                        child: ClipRRect(borderRadius: BorderRadius.circular(150),
                          child: Image.asset(
                            "./images/r.jpg",
                            fit: BoxFit.cover,
                          ),
                        )
                        // Image.asset(
                        //   "./images/r.jpg",
                        //   fit: BoxFit.cover,
                        // ), // Replace with your image path
                        ),
                  ),
                ),
              ),

              SizedBox(
                height: 170,
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // gradient: LinearGradient(
                    //   colors: [
                    //     Colors.black,
                    //     const Color.fromARGB(255, 85, 84, 84),
                    //   ],
                    // ),
                    color: Colors.transparent),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 40),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: Image.asset(
                            "./images/search.png",
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "songslist");
                          },
                          child: Text(
                            "Sign in with Google",
                            style: TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
