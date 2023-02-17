import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:animated_text_kit/animated_text_kit.dart";

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stupefying_wallpapers/views/screens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6)).then((value) {
      Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              "images/camera_logo.png",
              width: 250,
            ),
            const SizedBox(
              height: 30,
            ),
            AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
              TypewriterAnimatedText("STUPEFYING \nWALLPAPERS",
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  speed: Duration(milliseconds: 100)),
            ]),
            const SizedBox(
              height: 100,
            ),
            const SpinKitSquareCircle(
              color: Colors.redAccent,
              size: 60.0,
            ),
            const SizedBox(
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedTextKit(
                animatedTexts: [
                  RotateAnimatedText(
                    "DEVELOPED BY: SYED HASSAAN ALI",
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    rotateOut: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
