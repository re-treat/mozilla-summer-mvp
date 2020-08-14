import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:retreatapp/components/card_box_decoration.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/screens/exercise_page.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage({
    @required this.recommendedExercises,
  });

  final title = new RichText(
    text: new TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: kTitleTextStyle,
      children: <TextSpan>[
        new TextSpan(text: '               '),
        new TextSpan(
            text: 'Here are what we found for ', style: kTitleTextStyle),
        new TextSpan(text: 'you', style: kTitleHighlightTextStyle),
      ],
    ),
  );

  final List<String> recommendedExercises;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        shadowColor: Colors.white,
        toolbarHeight: 120.0,
        centerTitle: false,
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: kWidthFactor,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: new StaggeredGridView.countBuilder(
                    crossAxisCount: (recommendedExercises.length / 2).round(),
                    itemCount: recommendedExercises.length,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExercisePage(
                                instructions: exercises[recommendedExercises[index]].instructions),
                          ),
                        );
                      },
                      onHover: (bool) {
                        print(bool);
//                        showDialog(
//                            context: context,
//                            builder: (context) =>
//                                ExercisePreview(exercise: exercises[index]));
                      },
                      child: new Container(
                          padding: EdgeInsets.all(19.0),
                          color: Colors.white,
                          child: DecoratedBox(
                            decoration: cardBoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.all(48.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            herb.code + exercises[recommendedExercises[index]].name,
                                            style: kCardHeaderTextStyle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          height: 80.0,
                                          child: FlatButton(
                                            color: Colors.blueGrey,
                                            child: Text(''),
                                            onPressed: () {
                                              // do something
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                subtitle: Text(
                                                  target.code +
                                                      'Target emotion: ${exercises[recommendedExercises[i]].labelsTargetEmotion.join(', ')}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                subtitle: Text(
                                                  trophy.code +
                                                      'Effect/goal: ${exercises[recommendedExercises[i]].labelsEffectAndGoal.join(', ')}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(2),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

// final popup = BeautifulPopup(
//                          context: context,
//                          template: MyPopupTemplate,
//                        );
//                        popup.show(
//                          barrierDismissible: true,
//                          title: exercises[index].name,
//                          content: exercises[index].whyItWorks.toString(),
//                          actions: [
//                            popup.button(
//                              label: 'Begin Exercise',
//                              onPressed: () {
//                                // show detail
//                                Navigator.of(context).pop();
//                                Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                    builder: (context) => ExercisePage(
//                                      instructions:
//                                          exercises[index].instructions,
//                                    ),
//                                  ),
//                                );
//                              },
//                            ),
//                          ],
//
//                          // bool barrierDismissible = false,
//                          // Widget close,
//                        );

//                              child: RawMaterialButton(
//                                onLongPress: () {
//                                  print(index);
//                                  final popup = BeautifulPopup(
//                                    context: context,
//                                    template: TemplateSuccess,
//                                  );
//                                  popup.show(
//                                    barrierDismissible: true,
//                                    title: exercises[index]['name'],
//                                    content: exercises[index]['instructions'],
//                                    actions: [
//                                      popup.button(
//                                        label: 'Begin Exercise',
//                                        onPressed: () {
//                                          // show detail
//                                          Navigator.of(context).pop();
//                                          Navigator.push(
//                                            context,
//                                            MaterialPageRoute(
//                                              builder: (context) =>
//                                                  ExerciseDetailPage(
//                                                exercise: index,
//                                              ),
//                                            ),
//                                          );
//                                        },
//                                      ),
//                                    ],
//                                    // Widget close,
//                                  );
//                                },
//                                onPressed: () {
//                                  // show detail
//                                  Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => ExerciseDetailPage(
//                                        exercise: index,
//                                      ),
//                                    ),
//                                  );
//                                },
//                                child: new Center(
//                                  child: Text(exercises[index]['name'],
//                                      style: kBodyLargeTextStyle),
//                                ),
//                              ),
