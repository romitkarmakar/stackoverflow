import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stackoverflow/views/QuestionList.dart';

var tags = <dynamic>[];
List<String> selectedTags = [];

class UserInterest extends StatefulWidget {
  @override
  _UserInterestState createState() => _UserInterestState();
}

class _UserInterestState extends State<UserInterest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var url =
        "https://api.stackexchange.com/tags?sort=popular&site=stackoverflow";
    http.get(url).then((response) {
      print(response.body);
      var value = jsonDecode(response.body);
      tags = value["items"].map((v) => v["name"]).toList();
      setState(() {});
    });
  }

  Future<void> persist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = jsonEncode(selectedTags);
    prefs.setString('tags', value);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Wrap(
              spacing: 20.0,
              children: List.generate(tags.length, (int index) {
                return TagChip(
                  tag: tags[index],
                  index: index,
                );
              }),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.green),
              child: Center(
                  child: FlatButton(
                      onPressed: () {
                        print("Clicked");
                        persist().then((_) {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => QuestionList(
                                        tag: selectedTags[0],
                                      )));
                        });
                      },
                      child: Text(
                        "SUBMIT",
                        textScaleFactor: 1.5,
                        style: TextStyle(color: Colors.white),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}

class TagChip extends StatefulWidget {
  String tag;
  num index;

  TagChip({this.tag, this.index});

  @override
  _TagChipState createState() => _TagChipState();
}

class _TagChipState extends State<TagChip> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ChoiceChip(
        avatar: isSelected ? Icon(Icons.check) : null,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        label: Text(widget.tag),
        selected: isSelected,
        onSelected: (bool selected) {
          if (selectedTags.length < 4) {
            if (selected)
              selectedTags.add(tags[widget.index]);
            else
              selectedTags.remove(tags[widget.index]);
            isSelected = selected;
            print(selectedTags);
            setState(() {});
          }
        },
      ),
    );
  }
}
