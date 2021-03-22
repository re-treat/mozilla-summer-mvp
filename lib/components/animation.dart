import 'package:flutter/material.dart';
//import 'package:oktoast/oktoast.dart';
//import 'package:provider/provider.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:retreatapp/components/card_box_decoration.dart';
//import 'package:retreatapp/components/cause_of_emotion_filter.dart';
//import 'package:retreatapp/components/desired_emotion_filter.dart';
//import 'package:retreatapp/components/emotion_filter.dart';
//import 'package:retreatapp/components/svgs.dart';
//import 'package:retreatapp/constants.dart';
//import 'package:retreatapp/screens/input_page.dart';
//import 'package:retreatapp/screens/mood_details.dart';
//import 'package:retreatapp/screens/results_page.dart';

//import '../models/brain.dart';

class OnHoverScale extends StatefulWidget {
  Widget _child;
  double _scale = 1.2;

  OnHoverScale(Widget child, double scale) {
    this._child = child;
    this._scale = scale;
  }
  @override
  _OnHoverScale createState() => _OnHoverScale();
}

class _OnHoverScale extends State<OnHoverScale> with TickerProviderStateMixin{
  bool _scaled = false;
  double _scale = 1.0; // animation position
  AnimationController _controller;
  double getScale() {
    if (!_scaled) {
      return 1;
    } else {
      return widget._scale;
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        lowerBound: 1,
        upperBound: widget._scale,
        duration: Duration(milliseconds: 200));
    _controller.addListener(() {
      setState(() {
        _scale = _controller.value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget render() {
    const color = Colors.transparent;
    double scale = _scale;
    return Theme(
        data: Theme.of(context).copyWith(
          highlightColor: color,
          splashColor: color,
          hoverColor: color,
        ),
        child: InkWell(
            onTap: () {
            },
            onHover: (isHovering) {
              if (isHovering) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
            child: Transform(
    alignment: Alignment(0,0),
    transform: Matrix4.diagonal3Values(scale, scale, 1.0),
    child:widget._child)
    )
    );
  }

  Widget build(BuildContext context) {
    return render();
  }

}
