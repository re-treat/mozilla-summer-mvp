import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:retreatapp/screens/exercise_detail_page.dart';
import 'package:retreatapp/components/exercise_description.dart';

import '../constants.dart';

class ResultsPage extends StatelessWidget {
  List<String> recommendedExercises;
  List exercises = [];
  
  ResultsPage({
    @required this.recommendedExercises,
  }){
    recommendedExercises.forEach((id) => {
      exercises.add(exercise_description[id])
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RECOMMENDED EXERCISES',
          style: kHeadLineTextStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              flex: 5,
              child: new StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: exercises.length,
                itemBuilder: (BuildContext context, int index) => new Container(
                    color: kLightBlueColor,
                    child: RawMaterialButton(
                      onLongPress: () {
                        print(index);
                        final popup = BeautifulPopup(
                          context: context,
                          template: TemplateSuccess,
                        );
                        popup.show(
                          barrierDismissible: true,
                          title: exercises[index]['name'],
                          content: exercises[index]['instructions'],
                          actions: [
                            popup.button(
                              label: 'Begin Exercise',
                              onPressed: () {
                                // show detail
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExerciseDetailPage(
                                      exerciseId: exercises[index]['id'],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                          // Widget close,
                        );
                      },
                      onPressed: () {
                        // show detail
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseDetailPage(
                              exerciseId: exercises[index]['id'],
                            ),
                          ),
                        );
                      },
                      child: new Center(
                        child: Text(exercises[index]['name'],
                            style: kBodyLargeTextStyle),
                      ),
                    )),
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(2, index.isEven ? 2 : 1),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              )),
        ],
      ),
    );
  }
}
