import 'dart:typed_data';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:retreatapp/models/exercise.dart';
import 'package:retreatapp/models/story.dart';
import 'package:retreatapp/screens/exercise_page.dart';
import 'package:retreatapp/components/httpUtil.dart';
import 'package:retreatapp/components/svgs.dart';
import 'package:retreatapp/components/shared_story_card.dart';
import '../constants.dart';

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

class moodDetails extends StatelessWidget{
  final String moodId;
  var exerciseId;
  var title;
  moodDetails({Key key, @required this.moodId}){
    exerciseId = todaysChallengeIdMap[moodId];
    title = Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 60,
                  foregroundColor: Colors.transparent,
                  child: EMOJI_MAP[moodId],
                  backgroundColor: Colors.transparent,
                ),
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

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.15),
        child: FloatingActionButton(
          onPressed: () => {

          },
          child: const Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * leftPaddingPct),
          child: title
        ),
        flexibleSpace: Image(
          image: AssetImage("images/bg.jpg"),
          fit: BoxFit.fill
        ),
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
                    text: "Today's Challenge",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * leftPaddingPct-5, top: 16),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height*0.3,
                  child: StaggeredGridView.countBuilder(
                    primary: false,
                    crossAxisCount: 6,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    itemBuilder: (context, index) => new _Tile(
                        index, new IntSize(100, 100), exerciseId),
                    staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                    itemCount: 1,
                  ),
                ),
              ),
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
                  child: FutureBuilder<List<Story>>(
                      future: getStoriesForEmotion(moodId),
                      builder: (BuildContext context, AsyncSnapshot<List<Story>> snapshot) {
                        if(snapshot.hasData){
                          List<Story> stories = snapshot.data;
                          var col = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
                          );
                          stories.forEach((story) {col.children.add(SharedStoryCard(story: story));});
                          return Padding(
                            padding: EdgeInsets.only(top: 16, bottom: 52.0),
                            child: col,
                          );
                        }
                        else if(snapshot.hasError) { return Text(snapshot.error); }
                        else{ return Text('loading'); }
                      })
              )
            ]
        )
      )
    );
  }
}

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
              'Error loading today\'s challenge.',
              textAlign: TextAlign.center,
            );
          }
          else{
            return RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: moodDetailsSubTitleStyle,
                children: <TextSpan>[
                  TextSpan(text: "Loading...", style: moodDetailsSubTitleStyle),
                ],
              ),
            );
          }
    });
  }
}

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
            TextSpan(text: '$header: ', style: kCardContentHeaderTextStyle),
            TextSpan(text: '$content', style: kCardContentDetailTextStyle),
          ],
        ),
      ),
    );
  }
}