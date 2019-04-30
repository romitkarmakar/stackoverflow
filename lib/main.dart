import 'package:flutter/material.dart';
import 'package:stackoverflow/views/SplashScreen.dart';

void main() => runApp(StackOverflow());

class StackOverflow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Stack Overflow",
      home: SplashScreen(),
    );
  }
}
