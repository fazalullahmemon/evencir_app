import 'dart:math' as math;

import 'package:evencir_app/core/utils/app_colors.dart';
import 'package:evencir_app/core/utils/app_text_styles.dart';
import 'package:evencir_app/gen/assets.gen.dart';
import 'package:evencir_app/presentation/widgets/mood_color_ring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MoodOption { calm, content, peaceful, happy }

extension MoodOptionX on MoodOption {
  String get label {
    switch (this) {
      case MoodOption.calm:
        return 'Calm';
      case MoodOption.content:
        return 'Content';
      case MoodOption.peaceful:
        return 'Peaceful';
      case MoodOption.happy:
        return 'Happy';
    }
  }

  SvgGenImage get icon {
    switch (this) {
      case MoodOption.calm:
        return Assets.icons.calm;
      case MoodOption.content:
        return Assets.icons.content;
      case MoodOption.peaceful:
        return Assets.icons.peaceful;
      case MoodOption.happy:
        return Assets.icons.happy;
    }
  }

  double get angle {
    switch (this) {
      case MoodOption.calm:
        return -math.pi / 4;
      case MoodOption.content:
        return math.pi / 4;
      case MoodOption.peaceful:
        return 3 * math.pi / 4;
      case MoodOption.happy:
        return -3 * math.pi / 4;
    }
  }
}

class MoodSelectorWidget extends StatefulWidget {
  const MoodSelectorWidget({super.key, this.maxSize = 288});

  final double maxSize;

  @override
  State<MoodSelectorWidget> createState() => _MoodSelectorWidgetState();
}

class _MoodSelectorWidgetState extends State<MoodSelectorWidget> {
  MoodOption _selectedMood = MoodOption.calm;
  double? _dragAngle;
  bool _isDragging = false;

  static const double _ringStartAngle = -math.pi / 4;
  static const double _segmentSweep = math.pi / 2;

  double get _currentAngle => _dragAngle ?? _selectedMood.angle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : widget.maxSize;
        final availableHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : availableWidth;
        final selectorSize = math.min(
          widget.maxSize,
          math.min(availableWidth, availableHeight) * 0.60,
        );
        final ringStrokeWidth = selectorSize * 0.09;
        final knobDiameter = selectorSize * 0.22;
        final ringRadius =
            selectorSize / 2 - (ringStrokeWidth / 2) + selectorSize * 0.01;
        final angle = _currentAngle;
        final knobCenter = Offset(
          selectorSize / 2 + math.cos(angle) * ringRadius,
          selectorSize / 2 + math.sin(angle) * ringRadius,
        );
        final knobLeft = knobCenter.dx - knobDiameter / 2;
        final knobTop = knobCenter.dy - knobDiameter / 2;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: selectorSize,
              height: selectorSize,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: MoodColorRing(
                      size: selectorSize,
                      strokeWidth: ringStrokeWidth,
                    ),
                  ),
                  Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: Tween<double>(
                              begin: 0.96,
                              end: 1.0,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: _MoodIcon(
                        key: ValueKey(_selectedMood),
                        mood: _selectedMood,
                        size: selectorSize * 0.33,
                      ),
                    ),
                  ),
                  if (_isDragging)
                    Positioned(
                      left: knobLeft,
                      top: knobTop,
                      child: _Knob(diameter: knobDiameter),
                    )
                  else
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      left: knobLeft,
                      top: knobTop,
                      child: _Knob(diameter: knobDiameter),
                    ),
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanDown: (details) {
                        setState(() {
                          _isDragging = true;
                        });
                        _updateMood(details.localPosition, selectorSize);
                      },
                      onPanStart: (details) {
                        setState(() {
                          _isDragging = true;
                        });
                        _updateMood(details.localPosition, selectorSize);
                      },
                      onPanUpdate: (details) {
                        _updateMood(details.localPosition, selectorSize);
                      },
                      onPanEnd: (_) {
                        setState(() {
                          _isDragging = false;
                        });
                      },
                      onTapDown: (details) {
                        setState(() {
                          _isDragging = false;
                        });
                        _updateMood(details.localPosition, selectorSize);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.08),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: Text(
                _selectedMood.label,
                key: ValueKey(_selectedMood),
                style: AppTextStyles.moodTitleStyle.copyWith(
                  color: AppColors.whiteColor,
                  height: 1.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateMood(Offset localPosition, double size) {
    final angle = _angleForPosition(localPosition, size);
    setState(() {
      _dragAngle = angle;
      _selectedMood = _moodForAngle(angle);
    });
  }

  double _angleForPosition(Offset localPosition, double size) {
    final center = Offset(size / 2, size / 2);
    return math.atan2(
      localPosition.dy - center.dy,
      localPosition.dx - center.dx,
    );
  }

  MoodOption _moodForAngle(double angle) {
    final normalized =
        (angle - _ringStartAngle + (math.pi * 2)) % (math.pi * 2);
    final segmentIndex = (normalized / _segmentSweep).floor() % 4;

    switch (segmentIndex) {
      case 0:
        return MoodOption.calm;
      case 1:
        return MoodOption.content;
      case 2:
        return MoodOption.peaceful;
      case 3:
        return MoodOption.happy;
      default:
        return MoodOption.calm;
    }
  }
}

class _MoodIcon extends StatelessWidget {
  const _MoodIcon({super.key, required this.mood, required this.size});

  final MoodOption mood;
  final double size;

  @override
  Widget build(BuildContext context) {
    return mood.icon.svg(width: size, height: size);
  }
}

class _Knob extends StatelessWidget {
  const _Knob({required this.diameter});

  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFE8F4F3),
        border: Border.all(color: AppColors.whiteColor, width: 5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
    );
  }
}
