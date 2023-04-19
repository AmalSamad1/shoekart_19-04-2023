import 'dart:async';

import 'package:flutter/material.dart';

import '../loginpage_test/login_test1.dart';


class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>Log1())));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        // color:  Color.fromARGB(223, 82, 54, 43),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.white54, const Color.fromARGB(223, 82, 54, 43)
            ]
          )
        ),
        child: Center(
          child: Column(children: [
            SizedBox(height: 140,),
            Image.asset("images/shoesplashcreen.png",height: 300,width: 300,),
            CircularProgressIndicator(
              valueColor:  AlwaysStoppedAnimation<Color>(Color.fromARGB(223, 82, 54, 43)),
            )
          ],),
        )
    );
  }
}