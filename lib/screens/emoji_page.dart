import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:retreatapp/components/httpUtil.dart';
import 'package:retreatapp/components/cause_of_emotion_filter.dart';
import 'package:retreatapp/components/desired_emotion_filter.dart';
import 'package:retreatapp/components/emotion_filter.dart';
import 'package:retreatapp/components/svgs.dart';
import 'package:retreatapp/constants.dart';
import 'package:retreatapp/screens/input_page.dart';
import 'package:retreatapp/screens/mood_details.dart';
import 'package:retreatapp/screens/results_page.dart';
import 'package:easy_web_view/easy_web_view.dart';

import '../models/brain.dart';

class EmojiPage extends StatefulWidget {
  @override
  _EmojiPageState createState() => _EmojiPageState();
}

const disclaimer = '''
<h2><span style="font-size: 1.5em;">Disclaimer</span><br>
</h2>

<p>Re:treat aims to bridge the gap between professional mental and psychiatric care and college students’ daily
    emotional distress, but <strong>the website is NOT meant to substitute any advice, diagnosis, or treatment plans
        provided by medical professionals</strong>. If you suspect that you are facing mental-health related problems,
    you are strongly encouraged to seek professional help.</p>

<p>In regard to anonymity, Re:treat <strong>is fully anonymous and is NOT recording any identifiable data </strong>(e.g.
    your email or name) of our users, although we caution you against disclosing too personal information on the sharing
    platform since we have also published the website to Berkeley students only. We will also monitor posts that show
    potential warning signs of self-harm, suicidality, or health emergency, and <strong>reply with a referral
        message</strong> suggesting further interventions and help seeking.</p>

<p>Information found on this website should not be taken as medical advice or reproduced in any form without the
    permission of Re:treat team. For enquiries and feedbacks, please feel free to email <a
            href="mailto:hello@re-treat.app">hello@re-treat.app</a></p>

<p>Thank you for all the support and welcome to Re:treat!</p>

<p><strong>List of available mental health resource:</strong></p>

<p><strong>CAPS</strong></p>

<p>UC Berkeley Counseling and Psychological Services (CAPS) provide counseling for academic, personal and career
    concerns. Psychiatry services for when medication can help with counseling.</p>

<p><span style="box-sizing: border-box; -webkit-print-color-adjust: exact; border-bottom: 0.05em solid;">https://uhs.berkeley.edu/caps</span>
</p>

<p><strong>SoS</strong></p>

<p>Social Service Counseling provide counseling for specialized concerns such as chronic medical illnesses, pregnancy,
    eating disorders and nutrition, violence, and alcohol or other drugs</p>

<p><span style="box-sizing: border-box; -webkit-print-color-adjust: exact; border-bottom: 0.05em solid;">https://uhs.berkeley.edu/socialservices</span>
</p>

<p><strong>TAO</strong></p>

<p>TAO connect is an online library of interactive programs that help you learn life skills and bounce back from
    disappointment to achieve specific goals. TAO offers educational modules, assessments, practice tools and logs, and
    a mindfulness library.</p>

<p><span style="box-sizing: border-box; -webkit-print-color-adjust: exact; border-bottom: 0.05em solid;">https://uhs.berkeley.edu/tao</span>
</p>

<p><strong>SSPC</strong></p>

<p>Student to Student Peer Counseling (SSPC) is a group of student counselors providing free, one-on-one, confidential,
    walk-in services to UC Berkeley students.</p>

<p><span style="box-sizing: border-box; -webkit-print-color-adjust: exact; border-bottom: 0.05em solid;">https://sspc.berkeley.edu</span>
</p>

<p><strong>Mental Health Support at Undocumented Student Program</strong></p>

<p>mental health support program provides a confidential space for undocumented students to be seen by a licensed
    therapist who will collaborate with them on an individual wellness plan. Support varies by each student’s need
    including: one-time drop-in consultation, crisis management, on-going sessions, and connection to other campus
    resources.</p>

<p><span style="box-sizing: border-box; -webkit-print-color-adjust: exact; border-bottom: 0.05em solid;">https://undocu.berkeley.edu/academic-support/mental-health-support/</span>
</p>

<p><strong>Berkeley Free Clinic Peer Counseling</strong></p>

<p>The Berkeley Free Clinic provides free, confidential peer counseling for individuals 18 years of age and over.
    Services are provided by volunteers trained in active listening. During COVID-19, we’re offering peer counseling by
    phone.</p>

<p><a href="https://www.berkeleyfreeclinic.org/peer-counseling">https://www.berkeleyfreeclinic.org/peer-counseling</a>
</p>

<p><strong>National Suicide Prevention Lifeline</strong></p>

<p>If you&apos;re having suicidal thoughts, call <strong>1-800-273-TALK (8255)</strong> to talk to a skilled, trained
    counselor at a crisis center in your area at any time. If you are located outside the United States, call your local
    emergency line immediately.</p>

<p><br>
</p>

''';
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
          logVisit("emoji-detail+"+widget._tag,{
            "from":"MoodBoard",
            "emoji": widget._tag
          });
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
                mainAxisSpacing: 10,
              children: emojiRenderList

            )
              , SliverToBoxAdapter(child:EasyWebView(
                src: disclaimer,
                isHtml: true,
                // Use Html syntax
                isMarkdown: false,
                // Use markdown syntax
                convertToWidgets: true,
                // Try to convert to flutter widgets
                width: 100,
                height: 1000,
                onLoaded: () {},
                key: const ValueKey("disclaimer")
            ),)
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
                                            logVisit('ExerciseInputPage',{"from":"MoodBoard"});
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
                        fontFamily: 'OpenSans',
                        color:Colors.black,
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
                          padding: const EdgeInsets.all(0),
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
