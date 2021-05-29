import 'package:flutter/material.dart';
import 'package:retreatapp/models/story.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/components/animation.dart';
import 'package:retreatapp/components/httpUtil.dart';
import 'package:retreatapp/components/responses.dart';

class SharedStoryCard extends StatefulWidget{
  final Story story;
  Function callBack;

  SharedStoryCard({@required this.story, @required this.callBack});

  @override
  _SharedStoryCardState createState() => _SharedStoryCardState(story.id);
}

Widget RichTextEmoji(String text,{TextStyle style}){
//  return RichText(
//      text: TextSpan(
//          text: text,
//          style:style
//      )
//  );
  return Text(text, style: style);
}

class _SharedStoryCardState extends State<SharedStoryCard> {
  bool _commented;
  double _opacity;
  List<String> _responses;
  _SharedStoryCardState(id){
    _commented = ResponseHistory.hasResponded(id);
    _opacity = 0;
  }

  @override
  void initState() {
    _responses = widget.story.responses;
    super.initState();
  }

  void respond(String response) {
    sendResponse(widget.story.id, response).then((responses)  {
    print(responses);
    setState((){_responses=responses;});});
    ResponseHistory.respond(widget.story.id);
    setState(() {
      _commented=true;
    });
    widget.story.addResponses();
//    widget.callBack();
  }

  void setOpacity(double opacity){
    setState(() {
      _opacity = opacity;
    });
  }

  Widget getEmojiList(List<String> responses){
    return Row(
        children:responses.map((e) {
      return RichTextEmoji(respEmoji.containsKey(e) ? respEmoji[e]:"", style:sharedStoryEmojiStyle);
    }).toList()
    );
  }
  Widget getEmojiResponse(){
    if (_commented){
      return Text("");
    }
    if(_opacity==1.0){
      return TextButton(
          onPressed: () {
            setOpacity(0.0);
          },
          child: Text("Close",
              style: sharedStoryBodyStyle)
      );
    }
    return TextButton(
      onPressed: (){
        setOpacity(1.0);
      },
      child: Text("Respond",
          style: sharedStoryBodyStyle)
    );
  }
  Widget getCard(BuildContext context){
    return Container(
        padding: EdgeInsets.only(top: 26.0),
        child: InkWell(
          onTap: () {},
          child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.7,
              height: 227,
              child: Card(
                  child: Padding(
                      padding: EdgeInsets.only(top: 28.0, left: 19.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                              children: <Widget>[
                                Container(
                                  width: 41,
                                  height: 41,
                                  decoration: new BoxDecoration(
                                      image: getAvatarBG(widget.story.author.split(' ')[1]),
                                      shape: BoxShape.circle
                                  ),
                                  alignment:Alignment.center ,
                                  child: Text(
                                      widget.story.author.split(' ')[1].substring(0,1),
                                      style:avatarInitialStyle
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 6, left: 11),
                                    child: Text(
                                        widget.story.author,
                                        style: sharedStoryAuthorStyle
                                    )
                                )
                              ]
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: Text(
                                  widget.story.body,
                                  style: sharedStoryBodyStyle
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: const Text("")
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 26.0),
                            child: Row(
                                children: [
                                  getEmojiList(_responses),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(20, 0, 20,
                                          0),
                                      child: Text(widget.story.count
                                          .toString() + ' Responses')
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: const Text(""),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(right: 26.0),
                                      child: getEmojiResponse()
                                  )
                                ]
                            ),
                          )
                        ],
                      )
                  )
              )
          ),
        )
    );
  }

  Widget getFloating(BuildContextcontext){
     return Positioned(
         bottom: 20,
         right: 20,
         child:AnimatedOpacity(
       opacity: _opacity,
         duration:Duration(seconds: 1),
         child:Container(
       padding: EdgeInsets.all(8),
       margin: EdgeInsets.all(30),
//       width: 100,
//       height:30,
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(10),
         boxShadow: [
           BoxShadow(blurRadius: 10,
               color: kLightGrayColor,
               spreadRadius: 2)
         ],
       ),
       child: Row(
    children: respEmoji.entries.map((e) {
    return OnHoverScale(InkWell(
        onTap: (){respond(e.key);
        setOpacity(0.0);},
        child: RichTextEmoji(e.value, style: sharedStoryRespEmojiStyle)),1.2);
    }).toList()
       ),
     )));
  }
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getCard(context),
        getFloating(context),
      ],
    );
  }
}

