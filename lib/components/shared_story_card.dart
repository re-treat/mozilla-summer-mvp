import 'package:flutter/material.dart';
import 'package:retreatapp/models/story.dart';
import 'package:retreatapp/constants.dart';

class SharedStoryCard extends StatelessWidget{
  final Story story;

  SharedStoryCard({@required this.story});
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(top: 26.0),
      child: InkWell(
        onTap: () {},
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 227,
            child: Card(
                child: Padding (
                    padding: EdgeInsets.only(top: 28.0, left: 19.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            children: <Widget>[
                              Container(
                                width: 41,
                                height:41,
                                decoration: new BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 6, left: 11),
                                  child: Text(
                                      this.story.author,
                                      style: sharedStoryAuthorStyle
                                  )
                              )
                            ]
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                                this.story.body,
                                style: sharedStoryBodyStyle
                            )
                        )
                      ],
                    )
                )
            )
        ),
      )
    );
  }
}