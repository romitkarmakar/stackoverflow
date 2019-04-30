import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stackoverflow/views/QuestionList.dart';
import 'package:stackoverflow/views/UserInterest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<dynamic> tags = [];

  Future<bool> getTags() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("tags") != null) {
      tags = jsonDecode(prefs.getString("tags"));
      return true;
    }

    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        decoration: BoxDecoration(color: Colors.black),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 90.0,
              ),
              Image.asset(
                "assets/logo.png",
                height: 100.0,
              ),
              SizedBox(
                height: 50.0,
              ),
              Text(
                "Stack Overflow",
                textScaleFactor: 2.0,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Login to fully enjoy StackOverflow's features",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 70.0,
              ),
              SizedBox(
                height: 60.0,
                child: FlatButton(
                  onPressed: () {
                    getTags().then((flag) {
                      if (flag)
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => QuestionList(
                                  tag: tags[0],
                                )));
                      else
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => UserInterest()));
                    });
                  },
                  color: Colors.orange,
                  child: Text("Login to Stack Overflow",
                      textScaleFactor: 1.3,
                      style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
