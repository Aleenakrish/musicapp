import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  //https://i1.sndcdn.com/avatars-cdAKzhi1JITtzW6V-qDBkHQ-t1080x1080.jpg
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 42, 42),
      body: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(colors: [const Color.fromARGB(255, 59, 59, 59),const Color.fromARGB(255, 117, 116, 116)])
        ),
        child:ListView(
          children: [
            Container(
              height: 80,
              // color: Colors.black,
              child: Row(
                children: [
                  Container(
                    child:IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: Colors.white,))
                  ),
                  SizedBox(width: 180,),
                  Container(
                    // height: 60,
                    // width: 70,
                    child: Center(child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 20),)),
                  )
                ],
              ),
            ),
            SizedBox(height: 40,),
            Container(
              height:260 ,
              width: 260,
              alignment: Alignment.center,
              child: Container(
                // margin: EdgeInsets.only(left: 20,right: 20),
                height: 250,
                width: 250,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(150),color: Colors.black),
                // alignment: Alignment.center,
               child:ClipRRect(borderRadius: BorderRadius.circular(150),
                child: Image.asset("./images/logo.jpg",fit: BoxFit.cover,),) ,
              ),
            ),
            SizedBox(height: 150,),
            Container(
              margin: EdgeInsets.only(left: 60,right: 60),
               height: 70,
               width: 300,
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
               gradient: LinearGradient(colors: [Colors.black,const Color.fromARGB(255, 73, 72, 72)])
               ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 70),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),),
                  child:
                   ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: 
                    Image.asset("./images/google.jpg",)
                    ) ,
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                  child: TextButton(onPressed: (){},
                   child: Text("Sign in with Google",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}