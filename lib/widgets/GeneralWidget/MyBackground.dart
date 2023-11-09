import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:example_menu/GlobalVariable.dart';

class MyBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);


    canvas.drawCircle(
        Offset(width, height),
        height * 0.5,
        Paint()
          ..color = bigCircleBG
          ..style = PaintingStyle.stroke
          ..strokeWidth = height * 0.05
    );

    canvas.drawCircle(
        Offset(width, height),
        height * 0.4,
        Paint()..color = bigCircleBG
    );

    canvas.drawCircle(
        Offset(0, 0),
        height * 0.3,
        Paint()
          ..color = bigCircleBG
          ..style = PaintingStyle.stroke
          ..strokeWidth = height * 0.05
    );

    canvas.drawCircle(
        Offset(0, 0),
        height * 0.2,
        Paint()
          ..color = bigCircleBG
          ..style = PaintingStyle.stroke
          ..strokeWidth = height * 0.05
    );




/*
    Path smallCircle = Path();
    smallCircle.addOval(Rect.fromCircle(center: Offset(0, height * .1), radius: height * 0.1));
    paint.color = smallCircleBG;
    canvas.drawPath(smallCircle, paint);
*/

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

}