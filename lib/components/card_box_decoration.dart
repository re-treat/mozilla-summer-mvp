import 'package:flutter/material.dart';
import 'package:retreatapp/constants.dart';

BoxDecoration cardBoxDecoration() {
  return BoxDecoration(
      color: kWhiteColor,
      border: Border.all(color: kLightGrayColor),
      borderRadius: BorderRadius.all(
        Radius.circular(12.0),
      ),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: kLightGrayColor,
          blurRadius: 10.0,
          spreadRadius: 4.0,
        )
      ]);
}
