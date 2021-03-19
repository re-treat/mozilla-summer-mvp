import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:retreatapp/screens/mood_details.dart';

// For most pages, please use B&W, greys, and blues
// use oranges when you need to highlight / differentiate from the blue
const kDarkGrayColor = Color(0xFFACACAC);
const kLightGrayColor = Color(0xFFE5E5E5);
const kDarkBlueColor = Color(0xFF98AECA);
const kLightBlueColor = Color(0xFFE0E7EF);
const kDarkOrangeColor = Color(0xFFF5AA84);
const kLightOrangeColor = Color(0xFFF5D7C9);
const kBlackColor = Color(0xFF000000);
const kWhiteColor = Color(0xFFFFFFFF);
const kGrayTextColor = Color(0xFF666666);
const kEmojiTag = Color.fromARGB(153 ,0,0,0);
const kLightGrayTextColor = Color(0xFFBFBFBF);
const kButtonColor = Color(0xFFBFBFBF);

const kWidthFactor = 0.7;
const kSpacing = 6.0;
const kRunSpacing = 0.0;
const inputCardPadding = EdgeInsets.fromLTRB(36.0, 20.0, 36.0, 30.0);

final herb = Emoji('herb', '🌿');
final target = Emoji('target', '🎯');
final trophy = Emoji('trophy', '🏆');
final clock = Emoji('clock', '⏰');
final link = Emoji('link', '🔗');
final smile = Emoji('smile', '😊');

final Map<String, String> todaysChallengeIdMap = {
  'stressed': 'visualizing_best_possible_self'
};

const moodDetailsSubTitleStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.w700,
  fontFamily: 'OpenSans');

const moodDetailsEmojiStyle = TextStyle(
  fontSize: 100.0,
  //fontWeight: FontWeight.w700,
);

const kTitleTextStyle = TextStyle(
    fontSize: 48.0,
    fontWeight: FontWeight.w700,
    color: kBlackColor,
    fontFamily: 'OpenSans');

const kTitleMaterialTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: kBlackColor,
    fontFamily: 'OpenSans');

const kSubtitleMaterialTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: kGrayTextColor,
    fontFamily: 'OpenSans');

const kBody1MaterialTextStyle = TextStyle(
    color: kBlackColor,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    fontFamily: 'OpenSans');

const kBody2MaterialTextStyle = TextStyle(
    color: kLightGrayColor,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    fontFamily: 'OpenSans');

const kTitleHighlightTextStyle = TextStyle(
    fontSize: 48.0,
    fontWeight: FontWeight.w700,
    color: kDarkBlueColor,
    fontFamily: 'OpenSans');

TextStyle kHeadLineTextStyle = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w500,
    color: kGrayTextColor,
    fontFamily: 'OpenSans');

TextStyle kHeadLineHighlightTextStyle = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w500,
    color: kDarkBlueColor,
    fontFamily: 'OpenSans');

TextStyle kHeadLineTimeLineTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: kGrayTextColor,
    fontFamily: 'OpenSans');

TextStyle kHeadLineTimeLineHighlightTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: kDarkBlueColor,
    fontFamily: 'OpenSans');

TextStyle kTimeLineTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    color: kDarkGrayColor,
    fontFamily: 'OpenSans');

TextStyle kTimeLineHighlightTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    color: kDarkOrangeColor,
    fontFamily: 'OpenSans');

TextStyle kInputTextStyle = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w500,
    color: kGrayTextColor,
    fontFamily: 'OpenSans');

TextStyle kCardHeaderTextStyle = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w500,
    color: kGrayTextColor,
    decoration: TextDecoration.underline,
    fontFamily: 'OpenSans');

const kAnswerTextStyle = TextStyle(
  color: kGrayTextColor,
  fontSize: 18.0,
  fontWeight: FontWeight.w600,
  fontFamily: 'OpenSans',
);

const kBody1TextStyle = TextStyle(
    color: kBlackColor,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    fontFamily: 'OpenSans');

const kBody2TextStyle = TextStyle(
    color: kLightGrayColor,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    fontFamily: 'OpenSans');

const kCardContentHeaderTextStyle = TextStyle(
    color: kDarkGrayColor,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    fontFamily: 'OpenSans');

const kCardContentDetailTextStyle = TextStyle(
    color: kDarkGrayColor,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    fontFamily: 'OpenSans');

const kBottomContainerHeight = 80.0;
const kActiveCardColour = Color(0xFF1E1D33);
const kInactiveCardColour = Color(0xFF111328);
const kBottomContainerColour = Color(0xFFEB1555);

const kLabelTextStyle =
    TextStyle(fontSize: 18.0, color: Color(0xFF8D8E98), fontFamily: 'OpenSans');

const kNumberTextStyle = TextStyle(
    fontSize: 50.0, fontWeight: FontWeight.w900, fontFamily: 'OpenSans');

const kLargeButtonTextStyle = TextStyle(
    fontSize: 25.0, fontWeight: FontWeight.bold, fontFamily: 'OpenSans');

const kResultTextStyle = TextStyle(
    color: Color(0xFF24D876),
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans');

const kBMITextStyle = TextStyle(
    fontSize: 100.0, fontWeight: FontWeight.bold, fontFamily: 'OpenSans');

const kBodyTextStyle = TextStyle(fontSize: 22.0, fontFamily: 'OpenSans');
