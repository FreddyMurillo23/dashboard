import 'dart:math';

import 'package:flutter/material.dart';

/// Creates a random pattern with random geometry shapes and colors.
/// This is just a visual aspect and do nothing.
class RandomPatternComponent extends StatelessWidget {
  const RandomPatternComponent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _PatterPainter(),
    );
  }
}

class _PatterPainter extends CustomPainter {

  // Colors to fill the component
  final colors = [
    Colors.orange,
    Colors.indigo,
    Colors.blue,
    Colors.orange,
    Colors.yellow,
    Colors.tealAccent,
    Colors.green,
    Colors.lightGreen,
    Colors.pink,
    Colors.red
  ];

  @override
  void paint(Canvas canvas, Size size) {
    
    final painter = Paint();
    Path path = Path();

    painter.color = colors[Random().nextInt(colors.length)];
    painter.strokeWidth = 2.0;

    // filling the component
    path.addRect(Rect.largest);
    canvas.drawPath(path, painter);
    painter.style = PaintingStyle.stroke;
    path.moveTo(0, 0);

    // cleaning up the path
    path = Path();
    painter.color = Colors.white.withOpacity(0.4);

    paintSquarePattern(path, size, howMany: 5);
    paintOvalPattern(path, size);

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void paintSquarePattern(Path path, Size size, {int howMany = 10}) {

    for(int i=0; i<howMany; ++i) {
      path.addRect(Rect.fromPoints(
        Offset(size.width * Random().nextDouble(), size.height * Random().nextDouble()), 
        Offset(size.width * Random().nextDouble(), size.height * Random().nextDouble())
      ));
    }
  }

  void paintOvalPattern(Path path, Size size, {int howMany = 10}) {

    for(int i=0; i<howMany; ++i) {
      path.addOval(Rect.fromCircle(
        center: Offset(size.width * Random().nextDouble(), size.height * Random().nextDouble()),
        radius: size.width * 0.2 * Random().nextDouble()
      ));
    }
  }
}