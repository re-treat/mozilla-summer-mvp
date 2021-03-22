import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:retreatapp/models/exercise.dart';
import 'package:retreatapp/models/story.dart';
import 'package:retreatapp/screens/exercise_page.dart';
import 'package:retreatapp/components/httpUtil.dart';
import 'package:retreatapp/components/svgs.dart';
import 'package:retreatapp/components/animation.dart';
import 'package:retreatapp/components/shared_story_card.dart';
import '../constants.dart';
import 'package:retreatapp/components/js-bridge.dart';

final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);


final leftPaddingPct = 0.12;
final GlobalKey<_MoodBoardListState> storyKey = GlobalKey();

void updateStoryLst() {
  storyKey.currentState.update();
}

class moodDetails extends StatelessWidget{
  final String moodId;
  var exerciseId;
  Widget getTitle(context){
    return Row(
      children: <Widget>[
        OnHoverScale(Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    color: kBackButtonShadow,
                    spreadRadius: 5)
              ],
            ),
            child:
                InkWell(
                onTap: () {
                  Navigator.maybePop(context);
                },
//                      onHover: (hovor){},
                child: CircleAvatar(
                  child: Icon(Icons.arrow_back_ios),
                  foregroundColor: kBackButton,
                  backgroundColor: Colors.white,
                  radius: 30,
                )
                )


        ),1.25),
        Padding(
            padding: EdgeInsets.only(left: 50),
            child: CircleAvatar(
              radius: 60,
              foregroundColor: Colors.transparent,
              child: EMOJI_MAP[moodId],
              backgroundColor: Colors.transparent,
            )),
        Padding(
            padding: EdgeInsets.only(left: 13),
            child: Text(
              "#" + moodId,
              style: kTitleTextStyle,
            )
        )
      ],
    );
  }
  moodDetails({Key key, @required this.moodId}){
    exerciseId = todaysChallengeIdMap[moodId];

  }

  @override
  Widget build(BuildContext context){
    setHost(host);
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(40,0,MediaQuery.of(context).size.width * 0.15,0),
        child: FloatingActionButton(
          onPressed: ()  {
            logVisit('OpenStorySharing', {"from": "MoodDetail","emoji":moodId});
          showInput(moodId);
          },
          child: const Icon(Icons.add),
        ),
      ),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children:[ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Image(
                image: AssetImage("images/bg.jpg"),
                fit: BoxFit.cover
            ),
          ),
          Container(
            alignment: Alignment(-1,0),
      padding: EdgeInsets.fromLTRB( MediaQuery.of(context).size.width * leftPaddingPct,0,0,0),
      child: getTitle(context)
      ),

          ]),

      centerTitle: false,
      //titleSpacing: (MediaQuery.of(context).size.width * (1 - kWidthFactor)) / 2.5,
      toolbarHeight: 195.0,
      elevation: 0.0,
      ),
      body: SingleChildScrollView(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * leftPaddingPct, top: 52.0),
                child:
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: moodDetailsSubTitleStyle,
                    text: "This Week's Challenge",
                  ),
                ),
              ),
              Container(
//                height: MediaQuery.of(context).size.width*0.3,
                width: min(screenSize.width,max(500, screenSize.width*0.5)),
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * leftPaddingPct-5, top: 16),
                child: _Tile(
                    0, new IntSize(100, 100), exerciseId)),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * leftPaddingPct, top: 34),
                child:
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: moodDetailsSubTitleStyle,
                    text: "Shared Stories",
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * leftPaddingPct),
                  child: MoodBoardList(moodId: moodId,key: storyKey)
              )
            ]
        )
      )
    );
  }
}

class MoodBoardList extends StatefulWidget {
  final String moodId;

  MoodBoardList({Key key,@required this.moodId}) : super(key: key);
  @override
  _MoodBoardListState createState() => _MoodBoardListState(moodId: moodId);
}
class _MoodBoardListState extends State<MoodBoardList> {
  final String moodId;
  Future<List<Story>> _future ;

  _MoodBoardListState({@required this.moodId}){
    _future = getStoriesForEmotion(moodId);
  }
  void update(){
    _future = getStoriesForEmotion(moodId);
    this.setState(() {
    });
  }
  Widget _buildDataView(snapshot) {
    List<Story> stories = snapshot.data;
    var col = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [],
    );
    stories.forEach((story) {
        col.children.add(SharedStoryCard(story: story,callBack:(responses){
          story.responses = responses;
          setState((){});
        }
      )
        );
    });
    return (Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.only(top: 16, bottom: 52.0),
      child: col,
    ));
  }
  Widget build(BuildContext context) {
    return FutureBuilder<List<Story>>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<List<Story>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              snapshot.connectionState != ConnectionState.active ) {
            return Text('Loading'
                , style: loadingStyle);
          }
          if (snapshot.hasError) {
            return Text(snapshot.error);
          }
          if (snapshot.hasData) {
            return _buildDataView(snapshot);
          }
          return const Text('No Data'
              , style: loadingStyle);
        });
  }
}

//class MoodBoardList extends StatefulWidget {
//  @override
//  _MoodBoardListState createState() => _MoodBoardListState();
//}
//class _MoodBoardListState extends State<MoodBoardList> {
//
//  _MoodBoardListState(moodId)
//
//  Widget build(BuildContext context) {
//    return FutureBuilder<List<Story>>(
//        future: getStoriesForEmotion(moodId),
//        builder: (BuildContext context, AsyncSnapshot<List<Story>> snapshot) {
//          if (snapshot.hasData) {
//            List<Story> stories = snapshot.data;
//            var col = Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: [],
//            );
//            stories.forEach((story) {
//              col.children.add(SharedStoryCard(story: story));
//            });
//            return Padding(
//              padding: EdgeInsets.only(top: 16, bottom: 52.0),
//              child: col,
//            );
//          }
//          else if (snapshot.hasError) {
//            return Text(snapshot.error);
//          }
//          else {
//            return const Text('Loading'
//                , style: loadingStyle);
//          }
//        })
//  }
//}



class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}

class _Tile extends StatelessWidget {
  _Tile(this.index, this.size, this.exerciseId);

  final IntSize size;
  final int index;
  final String exerciseId;
  Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Exercise>(
        future: getExercise(exerciseId),
        builder: (BuildContext context, AsyncSnapshot<Exercise> snapshot){
          if(snapshot.hasData){
            exercise = snapshot.data;
            return InkWell(
              onTap: () {
                logVisit('StartExercise',
                    {"from": "MoodDetail"});
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExercisePage(
                          exercise: exercise,
                        )));
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                margin: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          herb.code + ' ${exercise.name}',
                          style: kCardHeaderTextStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 18.0),
                      child: Row(
                        children: [
                          // image
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: <Widget>[
                                  //new Center(child: new CircularProgressIndicator()),
                                  new Center(
                                    child: new FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: exercise.image,
                                      fit: BoxFit.fitWidth,
                                      imageScale: 2.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // target emotion and effect/goal text
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: new Column(
                                children: <Widget>[
                                  CardContentText(
                                    emoji: target.code,
                                    header: 'Targeting emotion',
                                    content: exercise.labelsTargetEmotion.join(', '),
                                  ),
                                  CardContentText(
                                    emoji: trophy.code,
                                    header: 'Effect/goal',
                                    content: exercise.labelsEffectAndGoal.join(', '),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          else if(snapshot.hasError){
            return Text(
              "Error loading this week's challenge.",
              textAlign: TextAlign.center,
            );
          }
          else{
            return Padding(
              padding: EdgeInsets.only(left: 5),
                child:const Text("Loading...", style: loadingStyle));
          }
    });
  }
}
//class ex{
//
//bool _commented;
//
//_CardContentText() {
//  _commented = ResponseHistory.hasResponded(widget.id);
//}
//
//void response(response) {
//  sendResponse(widget.id, response);
//  ResponseHistory.respond(widget.id);
//}
//
//}

class CardContentText extends StatelessWidget {
  const CardContentText({
    Key key,
    @required this.emoji,
    @required this.header,
    @required this.content,
  }) : super(key: key);

  final String emoji;
  final String header;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          children: <TextSpan>[
            TextSpan(text: '$emoji '),
            TextSpan(
                text: '$header: ', style: kCardContentHeaderTextStyle),
            TextSpan(
                text: '$content', style: kCardContentDetailTextStyle),
          ],
        ),
      ),
    );
  }
}

