import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/components/httpUtil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:retreatapp/screens/mood_details.dart';

class CreateStoryCard extends StatefulWidget {
  var emotion;
  CreateStoryCard(emotionId) { this.emotion = emotionId; }

  @override
  _CreateStoryCardState createState() => _CreateStoryCardState(this.emotion);
}

class _CreateStoryCardState extends State<CreateStoryCard>{
  var emotion;
  final widthPct = 0.565;
  final height = 500.0;
  final count = 5;
  var namesAreFetched = false;
  var values;
  var dropdownValue;
  var bodyText;

  _CreateStoryCardState(emotion) {
    this.emotion = emotion;
  }

  Future<List<String>> getNames() async {
    if(!this.namesAreFetched){
      await getAvailableUsernames(this.count).then((names) => {
        this.values = names,
        this.dropdownValue = this.values[0]
      });
      this.namesAreFetched = true;
    }
    return this.values;
  }

  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*widthPct,
      height: this.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                "Post my story",
                style: kLargeButtonTextStyle,
                )
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                // padding: const EdgeInsets.only(left: 50),
                child: CloseButton(),
                ),
              ),
            ],
          ),
          Container(
            // width: MediaQuery.of(context).size.width * widthPct * 0.88,
            // height: this.height * 0.2,
            margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10, bottom: 10),
            padding: const EdgeInsets.only(left: 35.0, right: 25.0, top: 10, bottom: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Center (
                child: Text(
                  " 📌 All contents you share with us is safe and anonymous. We will not use your inputs for any identification purpose.",
                  style: kAnswerTextStyle,
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.only(left: 15, top: 5, bottom: 10),
            child: Text(
              "Tell your story: "
            )
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SizedBox(
              // width:  MediaQuery.of(context).size.width * widthPct * 0.88,
              height: this.height * 0.5,
              child: Card(
                  color: kLightGrayBgColor,
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
            padding: const EdgeInsets.only(left: 20, bottom: 5),
            child: FutureBuilder<List<String>>(
                future: this.getNames(),
                builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                  if(snapshot.hasData){
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
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: const EdgeInsets.only(left: 50),
              child: TextButton(
                onPressed: () {
                  var author = this.dropdownValue;
                  String body = this.bodyText;
                  if(body == null || body.isEmpty){
                    showToast(
                        "Please say something in your story!",
                        position: ToastPosition.bottom,
                        backgroundColor: kDarkBlueColor,
                        radius: 13.0,
                        textStyle: TextStyle(
                            color: Colors.white,
                            backgroundColor: kDarkBlueColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            fontFamily: 'OpenSans'),
                        animationBuilder: Miui10AnimBuilder()
                    );
                  }
                  else{
                    createStory(body, author, this.emotion).then(
                        (value)=> updateStoryLst()
                    );
                    Navigator.pop(context);
                    //updateStoryLst();
                  }
                },
                child: const Icon(FontAwesomeIcons.paperPlane, size: 20)
              )
            )
          )
            ],
          )
        ],
      )
    );
  }
}
