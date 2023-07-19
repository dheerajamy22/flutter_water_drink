import 'dart:async';
//import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_tracker/pages/mainscreen.dart';
import 'package:water_tracker/pages/onbaord.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
 void seescreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? screens = pref.getBool('screen');
    if (screens == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) =>
                  mainscreen(access_from: 'spls', cat_water_value: ''))));
    }else{
      Timer(
      Duration(seconds: 0),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => onboard(),
        ),
      ),
    );
    }
  }

  @override
  void initState() {
    seescreen();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.blue,
      body: Center(
        child: Container(
          height: 500,
          width: 300,
          child: Center(
              child: Image.asset(
            'assets/splash_logo.png',
             color: Colors.white,
          )),
        
        ),
      ),
    );
  }
}
