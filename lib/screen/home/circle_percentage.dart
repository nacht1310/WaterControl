import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uitest/constant.dart';

class CirclePercentage extends CustomPainter {
  double percentage;
  Color percentageColor;
  CirclePercentage(this.percentage, this.percentageColor);
  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 15
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
    Paint completeArc = Paint()
      ..strokeWidth = 15
      ..color = percentageColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 10;
    double angle = 2 * pi * percentage / 100;
    canvas.drawCircle(center, radius, outerCircle);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Circle extends StatelessWidget {
  final double _percentage;
  final int _concenstration;
  const Circle(this._percentage, this._concenstration, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter:
          CirclePercentage(_percentage, percentageColor(_percentage)),
      child: Center(
        child: Container(
          alignment: Alignment.centerLeft,
          width: 140,
          height: 140,
          child: Center(
            child: Text("$_concenstration ml",
                style: TextStyle(
                    fontSize: 20,
                    color: percentageColor(_percentage),
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
