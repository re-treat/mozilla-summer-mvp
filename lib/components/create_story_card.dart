import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/components/httpUtil.dart';

class CreateStoryCard extends StatefulWidget {
  var emotion;
  CreateStoryCard({@required this.emotion});

  @override
  _CreateStoryCardState createState() => _CreateStoryCardState(this.emotion);
}

class _CreateStoryCardState extends State<CreateStoryCard>{
  var emotion;
  final widthPct = 0.565;
  final height = 500.0;
  final count = 5;
  var values;
  var dropdownValue;
  var bodyText;
  _CreateStoryCardState(emotion);

  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*widthPct,
      height: this.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Post my story",
            style: kTitleTextStyle,
          ),
          Text(
              "Tell your story: "
          ),
          SizedBox(
            width:  MediaQuery.of(context).size.width * widthPct * 0.88,
            height: this.height * 0.5,
            child: Card(
              color: Colors.black12,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  autocorrect: true,
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none
                  ),
                  onChanged: (String body) {
                    this.bodyText = body;
                  },
                ),
              )
            ),
          ),
          FutureBuilder<List<String>>(
            future: getAvailableUsernames(this.count),
            builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if(snapshot.hasData){
                List<String> names = snapshot.data;
                this.values = names;
                return Row(
                  children: <Widget>[
                    Text("Post as: Anonymous "),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String newValue) {
                        setState(() { dropdownValue = newValue; });
                      },
                      items: this.values.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                );
              }
              else if(snapshot.hasError){ return Text(snapshot.error); }
              else{ return Text("loading"); }
            }
          ),
          TextButton(
              onPressed: () {
                var author = this.dropdownValue;
                var body = this.bodyText;
                createStory(body, author, this.emotion);
                Navigator.pop(context);
              },
              child: Text("post")
          )
        ],
      )
    );
  }
}