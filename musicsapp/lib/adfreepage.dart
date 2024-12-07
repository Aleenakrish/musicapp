import 'package:flutter/material.dart';

class Addfreepage extends StatefulWidget {
  const Addfreepage({super.key});

  @override
  State<Addfreepage> createState() => _AddfreepageState();
}

class _AddfreepageState extends State<Addfreepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
         decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, const Color.fromARGB(255, 87, 86, 86)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        child: ListView(
          children: [
            Container(margin: EdgeInsets.only(top: 100,left: 20),
              child: Text("Pay the music ",style: TextStyle(fontSize: 25,color: Colors.white),)
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text("you love, Ad-free.",style: TextStyle(fontSize: 25,color: Colors.white),)
            ),
            SizedBox(height: 60,),
            Container(
              height: 40,
              width: 300,
              margin: EdgeInsets.only(left: 30,right: 30),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
              child: Center(child: Text("Get Premium Indiividaula",style: TextStyle(fontSize: 18,color: Colors.black))),
            )
          ],
        ),
      ),
    );
  }
}