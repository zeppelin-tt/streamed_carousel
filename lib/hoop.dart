import 'package:flutter/material.dart';

class Hoop extends StatelessWidget {
  final Color color;
  final double thickness;
  final double blockSide;
  final double innerRadius;
  final Widget? centeredChild;

  const Hoop({
    super.key,
    required this.color,
    required this.thickness,
    required this.blockSide,
    required this.innerRadius,
    this.centeredChild,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: blockSide,
      width: blockSide,
      child: Center(
        child: CustomPaint(
          painter: _HoopPainter(color: color, innerRadius: innerRadius, thickness: thickness),
          child: Center(
            child: centeredChild,
          ),
        ),
      ),
    );
  }
}

class _HoopPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double innerRadius;

  const _HoopPainter({
    required this.color,
    required this.thickness,
    required this.innerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    assert(size.height == size.width, 'height and width must be the same');
    final blockCenter = size.width / 2;
    final paint = Paint()..color = color;
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addOval(Rect.fromCircle(center: Offset(blockCenter, blockCenter), radius: innerRadius + thickness)),
        Path()
          ..addOval(Rect.fromCircle(center: Offset(blockCenter, blockCenter), radius: innerRadius))
          ..close(),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
