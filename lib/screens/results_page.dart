import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:retreatapp/models/brain.dart';
import 'package:retreatapp/models/exercise.dart';
import 'package:retreatapp/screens/exercise_page.dart';

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

List<IntSize> _createSizes(int count) {
  Random rnd = new Random();
  return new List.generate(count,
      (i) => new IntSize((rnd.nextInt(500) + 200), rnd.nextInt(800) + 200));
}

final title = RichText(
  text: TextSpan(
    // Note: Styles for TextSpans must be explicitly defined.
    // Child text spans will inherit styles from parent
    style: kTitleTextStyle,
    children: <TextSpan>[
//        new TextSpan(text: '               '),
      TextSpan(text: 'Here are what we found for ', style: kTitleTextStyle),
      TextSpan(text: 'you', style: kTitleHighlightTextStyle),
    ],
  ),
);

class ResultsPage extends StatelessWidget {
  @required
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Exercise>>(
      future: Provider.of<Brain>(context, listen: false).getRecommendExercises(),
      builder: (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot){
        if(snapshot.hasData){
          List<Exercise> recommendedExercises = snapshot.data;
          final int _kItemCount = recommendedExercises.length;
          List<IntSize> _sizes;
          _sizes = _createSizes(_kItemCount).toList();

          return Scaffold(
            appBar: AppBar(
              title: title,
              centerTitle: false,
              titleSpacing:
              (MediaQuery.of(context).size.width * (1 - kWidthFactor)) / 2.5,
              toolbarHeight: 120.0,
              elevation: 0.0,
            ),
            body: Center(
              child: FractionallySizedBox(
                widthFactor: kWidthFactor,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 188.0,
                      child: StaggeredGridView.countBuilder(
                        primary: false,
                        crossAxisCount: 4,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        itemBuilder: (context, index) => new _Tile(
                            index, _sizes[index], recommendedExercises[index]),
                        staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                        itemCount: recommendedExercises.length,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton.extended(
                        isExtended: true,
                        label: Text('Back'),
                        icon: Icon(Icons.arrow_back_ios),
                        backgroundColor: kDarkBlueColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        }
        else if(snapshot.hasError){
          return Text(
            'Error loading labels.',
            textAlign: TextAlign.center,
          );
        }
        else{
          return Text(
            'Loading labels...',
            textAlign: TextAlign.center,
          );
        }
      }
    );

  }
}

class IntSize {
  const IntSize(this.width, this.height);

  final int width;
  final int height;
}

class _Tile extends StatelessWidget {
  const _Tile(this.index, this.size, this.exercise);

  final IntSize size;
  final int index;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
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
