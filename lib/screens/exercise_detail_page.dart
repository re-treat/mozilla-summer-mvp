import 'package:flutter/material.dart';
import 'package:retreatapp/components/bottom_button.dart';
import 'package:retreatapp/components/reusable_card.dart';
import 'package:retreatapp/screens/input_page.dart';

import '../constants.dart';

class ExerciseDetailPage extends StatelessWidget {
  ExerciseDetailPage({
    @required this.exercise,
  });

  // create Exercise class object
  final int exercise;

  final List exercises = [
    {
      'name': 'Visualizing Best Possible Self',
      'instructions':
          'Imagine what is it like to live the best possible self in the future. You may consider just one aspect of your life or multiple of them, like your work, your social relationships and things you love to do. Use specific words to describe your visions for that best possible future, and try to focus on future and details of when, where, who... a text entry ',
      'why_it_works':
          'Sheldon, K. M., & Lyubomirsky, S. (2006). How to increase and sustain positive emotion: The effects of expressing gratitude and visualizing best possible selves. Journal of Positive Psychology, 1(2), 73-82.'
    },
    {
      'name':
          ' Tackling Four Horsemen in Relationships & Conflicts - Criticism',
      'instructions':
          'We can always voice our concerns, but we may shift the focus of our words from the other person to our own feelings by using I statements and describing specific actions/events that make you feel in that way. For example, instead of "You are so inconsiderate!", we can say "I feel neglected when you make plans without me".',
      'why_it_works':
          'Carrere, S., Buehlman, K.T., Coan, J.A., Gottman, J.M., Coan, J.A., and Ruckstuhl, L., (2000). Predicting Marital Stability and Divorce in Newlywed Couples, Journal of Family Psychology, 14(1), 42-58.'
    },
    {
      'name': ' Tackling Four Horsemen in Relationships & Conflicts - Contempt',
      'instructions':
          'We may shift our mindset from recollecting all the flaws of the other person to considering their positive qualities and what you appreciate most about them. You may list out such things to direct your memory away from the negative experience and feelings and come back with a more holistic perspective.',
      'why_it_works':
          'Carrere, S., Buehlman, K.T., Coan, J.A., Gottman, J.M., Coan, J.A., and Ruckstuhl, L., (2000). Predicting Marital Stability and Divorce in Newlywed Couples, Journal of Family Psychology, 14(1), 42-58.'
    },
    {
      'name':
          ' Tackling Four Horsemen in Relationships & Conflicts - Defensiveness',
      'instructions':
          'Even that person has made some mistakes, we may still take time to hear them out and acknowledge what we might have done inappropriately. A simple, genuine apology can go a long way.',
      'why_it_works':
          'Carrere, S., Buehlman, K.T., Coan, J.A., Gottman, J.M., Coan, J.A., and Ruckstuhl, L., (2000). Predicting Marital Stability and Divorce in Newlywed Couples, Journal of Family Psychology, 14(1), 42-58.'
    },
    {
      'name':
          'Tackling Four Horsemen in Relationships & Conflicts - Stonewalling',
      'instructions':
          'It\'s a good thing to take some time to calm down and collect your minds, but we may let the other know about our intention before leaving and then return to the conversation when ready.',
      'why_it_works':
          'Carrere, S., Buehlman, K.T., Coan, J.A., Gottman, J.M., Coan, J.A., and Ruckstuhl, L., (2000). Predicting Marital Stability and Divorce in Newlywed Couples, Journal of Family Psychology, 14(1), 42-58.'
    },
    {
      'name': 'Feeling Compassion for Yourself',
      'instructions':
          'Write a letter about a distressing event that happened during the day, providing compassion to themselves. think about an event that occurred that day which was distressing and left them feeling upset -> write a one paragraph letter to themselves in the first person about the situation...',
      'why_it_works':
          'Breines, J. G., & Chen, S. (2012). Self-compassion increases self-improvement motivation. Personality and Social Psychology Bulletin, 18(9), 1133-1143.\n Shapira, L. B., & Mongrain, M. (2010). The benefits of self-compassion and optimism exercises for individuals vulnerable to depression. Journal of Positive Psychology, 5, 377-389.'
    },
    {
      'name': 'Get It Started: 5-Step Tackling Procrastination Bit by Bit',
      'instructions':
          """1. Acknowledge the distress: Without judging or criticizing yourself, take a moment to acknowledge and accept that you are, to a certain extent, disturbed by some kind of task that you think "I should do it today" but feel reluctant to start in it.\n' 
    2. Break it up: Let's break the task or the event that may sound intimidating into 3-5 smaller, specific and manageable steps. For example, when you plan to write an essay, you 1) brainstorm, 2) outline, 3) draft, 4) polish, 5) ask for advice, 6) final draft and submit.
    3. Find meaning and purpose: Reflect on what are some potential impact of the work you are going to do. Can you think of the meaning of this task for you or for somebody else, for now or for the future?
    4. A ritual for starting: While starting the task may sound unpleasant in anyway, why don't we create a little 5-10min ritual for ourselves to kick start the work and bring in some excitement. For someone this starting ritual can be a cup of coffee, a quick journal entry, a post-it notes or a youtube video. Come up with your starting ritual today:)
    5. Treat yourself for hitting the goal: Envision how you will treat yourself after finishing this task or one of the steps. Or, you can also imagine some positive feelings you might have upon successfully accomplishing what you want to achieve today.""",
      'why_it_works':
          'Sheldon, K. M., & Lyubomirsky, S. (2006). How to increase and sustain positive emotion: The effects of expressing gratitude and visualizing best possible selves. Journal of Positive Psychology, 1(2), 73-82.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EXERCISE DETAIL',
          style: kHeadLineTextStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: ReusableCard(
              colour: kLightBlueColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(exercises[exercise]['name'], style: kHeadLineTextStyle),
                  Text(
                    exercises[exercise]['instructions'],
                    textAlign: TextAlign.center,
                    style: kBody2TextStyle,
                  ),
                  Text(
                    exercises[exercise]['why_it_works'],
                    textAlign: TextAlign.center,
                    style: kBody2TextStyle,
                  ),
                ],
              ),
            ),
          ),
          BottomButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputPage(),
                ),
              );
            },
            buttonTitle: 'START OVER',
          )
        ],
      ),
    );
  }
}
