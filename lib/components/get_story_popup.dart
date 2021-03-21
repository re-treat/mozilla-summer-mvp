import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:retreatapp/constants.dart';

class GetStoryPopUp extends BeautifulPopupTemplate {
  final BeautifulPopup options;
  GetStoryPopUp(this.options) : super(options);

  @override
  Color get primaryColor => options.primaryColor ?? kLightBlueColor; 
  @override
  final maxWidth = 400; // In most situations, the value is the illustration size.
  @override
  final maxHeight = 600;
  @override
  final bodyMargin = 10;

  @override
  get layout {
    return [
      Positioned(
        child: background,
      ),
      Positioned(
        top: percentH(10),
        child: title,
      ),
      Positioned(
        top: percentH(40),
        height: percentH(actions == null ? 32 : 42),
        left: percentW(10),
        right: percentW(10),
        child: content,
      ),
      Positioned(
        bottom: percentW(10),
        left: percentW(10),
        right: percentW(10),
        child: actions ?? Container(),
      ),
    ];
  }
}