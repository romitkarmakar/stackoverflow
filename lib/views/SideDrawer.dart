import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stackoverflow/views/QuestionList.dart';

List<dynamic> tags = ["loading", "loading", "loading", "loading"];

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  Future<void> getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString('tags');
    tags = jsonDecode(value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValue().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView.builder(
          itemCount: tags.length,
          itemBuilder: (context, int index) {
            return ListTile(
              leading: Text(
                tags[index],
                textScaleFactor: 1.5,
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => QuestionList(
                          tag: tags[index],
                        )));
              },
            );
          }),
    );
  }
}
