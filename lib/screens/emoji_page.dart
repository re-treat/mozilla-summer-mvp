import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:retreatapp/components/card_box_decoration.dart';
import 'package:retreatapp/components/cause_of_emotion_filter.dart';
import 'package:retreatapp/components/desired_emotion_filter.dart';
import 'package:retreatapp/components/emotion_filter.dart';
import 'package:retreatapp/components/svgs.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/screens/input_page.dart';
import 'package:retreatapp/screens/mood_details.dart';
import 'package:retreatapp/screens/results_page.dart';

import '../models/brain.dart';

class EmojiPage extends StatefulWidget {
  @override
  _EmojiPageState createState() => _EmojiPageState();
}

class EmojiCard extends StatefulWidget {
  Widget _picture = SVG_LOVE;
  String _tag = 'love';
  String _href = '';

  EmojiCard(Widget picture, String tag, String href) {
    this._picture = picture;
    this._tag = tag;
    this._href = href;
  }

  @override
  _EmojiCardState createState() => _EmojiCardState();

}

final List<Widget> emojiRenderList = EMOJI_LST.map((e){
  return Container(
    padding: const EdgeInsets.all(8),
    child: EmojiCard(e[2], e[0], e[1]),
  );
}).toList();

class _EmojiCardState extends State<EmojiCard> {
  bool _scaled = false;

  double getScale() {
    if (!_scaled) {
      return 1;
    } else {
      return 1.2;
    }
  }
  Widget getCard() {
    return Center(

        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getEmojiCard(),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text('#' + widget._tag,
                  style: TextStyle(
                    color: kEmojiTag,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Georgia",
                  ),
                ),
//              color: Colors.teal[200],
              )
            ]
        )
    );
  }


  Widget getEmojiCard() {
    const color = Colors.transparent;
    return Theme(
        data: Theme.of(context).copyWith(
          highlightColor: color,
          splashColor: color,
          hoverColor: color,
        ),
        child:InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  moodDetails(moodId: widget._tag),
            ),
          );
        },
      onHover: (isHovering) {
        if (isHovering) {
          setState(() {
            _scaled=true;
          });;
        } else {
          setState(() {
            _scaled = false;
          });
        }
      },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    blurRadius: 10, color: kLightGrayColor, spreadRadius: 2)
              ],
            ),
            padding: const EdgeInsets.all(40),

            child: CircleAvatar(
              radius: 60*getScale(),
              //半径，图形放大是radius的2倍
              //foregroundColor：子视图中文字的颜色
              //不设置backgroundColor和foregroundColor，CircleAvatar默认背景色是灰色
              //不设置backgroundColor，backgroundColor的颜色随foregroundColor变化而变化，但与foregroundColor色值不同
              //同时设置backgroundColor、backgroundImage，能直接看到的是backgroundImage
              foregroundColor: Colors.white,
              child: widget._picture,
              backgroundColor: Colors.white,
//      backgroundImage: NetworkImage(imageNetwork),
            ))));
  }
  Widget build(BuildContext context) {
    return getCard();
  }

}
class _EmojiPageState extends State<EmojiPage> {
  Color answerTextColor = kInactiveCardColour;


  EmotionFilter filter_q1;
  DesiredEmotionFilter filter_q2;
  CauseOfEmotionFilter filter_q3;


  _InputPageState() {
  }

  final questions = [
    'What emotion(s) are you feeling right now?',
    'What might have caused you to feel these emotions?',
    'What do you wish to achieve by this exercise?'
  ];

  Widget getEmojiList(){
    return Expanded(
        flex: 1,
        child: CustomScrollView(
            slivers: [SliverGrid.extent(
              maxCrossAxisExtent: 300,
              children: emojiRenderList

            )
              ,
            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: title,
//        shadowColor: Colors.white,
//        toolbarHeight: 120.0,
//        centerTitle: false,
//      ),
        body: Center(child: Consumer<Brain>(
            builder: (context, brain, child) {
              return Column(
                children: <Widget>[
                  Stack(
                      children:[Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                  image: AssetImage("images/bg.jpg"),
              fit: BoxFit.cover,
              ),
              ),
//                  color:Colors.teal[40],
//                    padding: const EdgeInsets.all(8),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width ,
                    height:150,
                    child:const Text(""),
                  )
                      , Positioned.fill(
                        child: Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.85,
                                child: Stack(
                                    children: <Widget>[
                                      Container(
                                          height: 150,
                                          padding: EdgeInsets.fromLTRB(
                                              50, 30, 20, 20),
                                          alignment: Alignment(-1, 0),
                                          child: const Text('Mood Board',
                                            style: TextStyle(
                                              color: kEmojiTag,
                                              fontSize: 48,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "Georgia",
                                            ),
                                          )
                                      ),
                                      Container(
                                        height: 200,
                                        padding: EdgeInsets.fromLTRB(
                                            50, 30, 20, 20),
                                        alignment: Alignment(1, 0),
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    InputPage(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                              child:Text('Take me to exercises')),
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty
                                                  .all(Colors.white),
                                              foregroundColor: MaterialStateProperty
                                                  .all(kEmojiTag),
                                              elevation: MaterialStateProperty
                                                  .all(10),
                                          ),
                                        ),
                                      )
                                    ]
                                ))
                        ),
                      )
                     ,  ]),
              Container(
                padding: EdgeInsets.all(8),
              margin: EdgeInsets.all (30),
              decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              boxShadow: [
              BoxShadow(blurRadius: 10,
              color: kLightGrayColor,
              spreadRadius: 2)
              ],
              ),
                child: RichText(
                  text: TextSpan(
                    text: ' ',
                    style: TextStyle(
                      fontSize: 18,
                        fontFamily: 'OpenSans'
                      //fontWeight: FontWeight.w600,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Find your ', ),
                      TextSpan(text: 'emotion community ', style:
                        TextStyle(
                        color: Colors.orange
                      )),
                      TextSpan(text: 'and read '),
                      TextSpan(text: 'top-hit stories ',style:
                      TextStyle(
                          color: Colors.orange,
                      )),
                      TextSpan(text: 'happening this week on UC Berkeley campus'),
                    ],
                  ),

                ),
              )
              ,

              Expanded(child:Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.85,
//                      color: Colors.teal[200],
//                  constraints: BoxConstraints.expand(),
                    child:(
                        Column(
                      children:<Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Text(''),

                        ),
                        getEmojiList()
                      ]
                    ))
                  ))


                ],
              )
              ;
            },

        )
        )
    );
  }
}
