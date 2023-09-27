import 'package:flutter/material.dart';

class FacePainter extends CustomPainter {
  final double screenWidth;
  final double screenHeight;

  FacePainter({required this.screenWidth, required this.screenHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = screenWidth * 0.35;
    const strokeWidth = 2.0;
    final offset = Offset(screenWidth / 2, screenHeight / 2.5);
    final circlePath = Path()
      ..addOval(Rect.fromCircle(
        center: offset,
        radius: radius,
      ));

    final outerPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, screenWidth, screenHeight));
    final overlayPath =
        Path.combine(PathOperation.difference, outerPath, circlePath);

    final paint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawPath(overlayPath, paint);
    canvas.drawCircle(
      offset,
      radius,
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
