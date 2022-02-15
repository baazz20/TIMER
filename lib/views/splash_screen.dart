import 'dart:async';

import 'package:flutter/material.dart';
import 'package:odatimer/views/countdown-page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),
        (() => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => CountdownPage()))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/logooda.jpeg',
                  width: 300.0,
                  height: 300.0,
                ),
                Text(
                  "ODA Timer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                )
              ],
            ),
            CircularProgressIndicator(),
            Text(
              "by Yao Eloge",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 10.0),
            )
          ],
        ),
      ),
    );
  }
}
