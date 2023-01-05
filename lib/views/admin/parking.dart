import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParkingSchema extends StatelessWidget {
  final List<bool> availability;

  ParkingSchema({required this.availability});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ParkingSchemaPainter(availability: availability),
      child: Container(),
    );
  }
}

class ParkingSchemaPainter extends CustomPainter {
  final List<bool> availability;

  ParkingSchemaPainter({required this.availability});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final width = size.width / availability.length;

    for (int i = 0; i < availability.length; i++) {
      paint.color = availability[i] ? Colors.green : Colors.red;
      canvas.drawRect(
        Rect.fromLTWH(i * width, 0, width, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
