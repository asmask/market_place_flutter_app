import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:market_place_flutter_app/screens/home/home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    /*Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen())));*/
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 30.0,
              fontFamily: 'Agne',
              color: Theme.of(context).primaryColor,
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                WavyAnimatedText('Please wait!'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
