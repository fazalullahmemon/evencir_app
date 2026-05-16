import 'dart:math' as math;

import 'package:evencir_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MoodColorRing extends StatelessWidget {
  const MoodColorRing({super.key, this.size = 320, this.strokeWidth});

  final double size;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    final effectiveStrokeWidth = strokeWidth ?? (size * 0.09);
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _MoodColorRingPainter(strokeWidth: effectiveStrokeWidth),
      ),
    );
  }
}

class _MoodColorRingPainter extends CustomPainter {
  _MoodColorRingPainter({required this.strokeWidth});

  final double strokeWidth;

  static const double _startAngle = -math.pi / 4;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..shader = SweepGradient(
        colors: const [
          AppColors.moodRingTeal,
          AppColors.moodRingTeal,
          AppColors.moodRingLavender,
          AppColors.moodRingLavender,
          AppColors.moodRingPink,
          AppColors.moodRingPink,
          AppColors.moodRingOrange,
          AppColors.moodRingOrange,
          AppColors.moodRingTeal,
        ],
        stops: const [0.0, 0.18, 0.25, 0.43, 0.50, 0.68, 0.75, 0.93, 1.0],
        startAngle: _startAngle,
        endAngle: _startAngle + (math.pi * 2),
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);

    final tickPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    final innerRadius = radius - strokeWidth / 2 + 2;
    final outerRadius = radius + strokeWidth / 2 - 2;
    const tickCount = 12;
    for (var i = 0; i < tickCount; i++) {
      final angle = _startAngle + ((math.pi * 2) / tickCount) * i;
      final start = Offset(
        center.dx + math.cos(angle) * innerRadius,
        center.dy + math.sin(angle) * innerRadius,
      );
      final end = Offset(
        center.dx + math.cos(angle) * outerRadius,
        center.dy + math.sin(angle) * outerRadius,
      );
      canvas.drawLine(start, end, tickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _MoodColorRingPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth;
  }
}
