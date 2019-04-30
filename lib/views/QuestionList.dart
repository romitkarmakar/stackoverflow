import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stackoverflow/views/SideDrawer.dart';
import 'package:http/http.dart' as http;

class QuestionList extends StatefulWidget {
  String tag;
  QuestionList({this.tag});

  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  List myQue = <String>[];
  List hot = <String>[];
  List week = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    My Tags question
    var myQueUrl =
        "https://api.stackexchange.com/questions?site=stackoverflow&tagged=${widget.tag}&pagesize=10";
    http.get(myQueUrl).then((response) {
      print(response.body);
      var value = jsonDecode(response.body);
      myQue = value["items"].map((v) => v["title"]).toList();
      setState(() {});
    });
//    Hot Tags
    var hotUrl =
        "https://api.stackexchange.com/questions?site=stackoverflow&tagged=${widget.tag}&pagesize=10&sort=hot";
    http.get(hotUrl).then((response) {
      print(response.body);
      var value = jsonDecode(response.body);
      hot = value["items"].map((v) => v["title"]).toList();
      setState(() {});
    });
//    Week Tags
    var weekUrl =
        "https://api.stackexchange.com/questions?site=stackoverflow&tagged=${widget.tag}&pagesize=10&sort=week";
    http.get(weekUrl).then((response) {
      print(response.body);
      var value = jsonDecode(response.body);
      week = value["items"].map((v) => v["title"]).toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Trending"),
          bottom: TabBar(tabs: [
            Tab(
              icon: Text(
                "YOUR #",
                textScaleFactor: 1.3,
              ),
            ),
            Tab(
                icon: Text(
              "HOT",
              textScaleFactor: 1.3,
            )),
            Tab(
                icon: Text(
              "WEEK",
              textScaleFactor: 1.3,
            )),
          ]),
        ),
        drawer: SideDrawer(),
        body: TabBarView(children: [
          Container(
            child: ListView.builder(
                itemCount: myQue.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                    leading: Text(myQue[index]),
                  );
                }),
          ),
          Container(
            child: ListView.builder(
                itemCount: hot.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                    leading: Text(hot[index]),
                  );
                }),
          ),
          Container(
            child: ListView.builder(
                itemCount: week.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                    leading: Text(week[index]),
                  );
                }),
          )
        ]),
      ),
    );
  }
}
