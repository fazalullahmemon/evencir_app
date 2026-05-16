import 'package:evencir_app/core/utils/app_colors.dart';
import 'package:evencir_app/core/utils/app_text_styles.dart';
import 'package:evencir_app/data/models/hydration_log_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HydrationLogWidget extends StatelessWidget {
  const HydrationLogWidget({
    super.key,
    required this.data,
  });

  final HydrationLogData data;

  String _formatLiters(int ml) {
    final liters = ml / 1000;
    if (liters == liters.roundToDouble()) {
      return '${liters.toStringAsFixed(0)} L';
    }
    return '${liters.toStringAsFixed(1)} L';
  }

  @override
  Widget build(BuildContext context) {
    final progressText = '${(data.progressPercent * 100).round()}%';
    const majorTickWidth = 14.0;
    const majorTickHeight = 6.0;
    const minorTickWidth = 8.0;
    const minorTickHeight = 4.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        progressText,
                        style: AppTextStyles.caloriesNumberStyle.copyWith(
                          color: AppColors.hydrationAccent,
                          fontSize: 48.sp,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Hydration',
                        style: AppTextStyles.title.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 18.sp,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Log Now',
                        style: AppTextStyles.caloriesRemainingStyle.copyWith(
                          color: AppColors.mutedText,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 200,
                  height: 170,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _formatLiters(data.goalMl),
                              style: AppTextStyles.caloriesTextStyle.copyWith(
                                color: AppColors.whiteColor,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              '0 L',
                              style: AppTextStyles.caloriesTextStyle.copyWith(
                                color: AppColors.whiteColor,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: SfCartesianChart(
                                margin: EdgeInsets.only(right: 30),
                                plotAreaBorderWidth: 0,
                                backgroundColor: Colors.transparent,
                                primaryXAxis: NumericAxis(
                                  minimum: 0,
                                  maximum: data.goalMl.toDouble(),
                                  interval: 500,
                                  labelStyle: const TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 1,
                                  ),
                                  majorTickLines: const MajorTickLines(size: 0),
                                  minorTickLines: const MinorTickLines(size: 0),
                                  majorGridLines: const MajorGridLines(width: 0),
                                  minorGridLines: const MinorGridLines(width: 0),
                                  axisLine: const AxisLine(
                                    width: 1,
                                    color: Color(0xFF3A3A3D),
                                  ),
                                ),
                                primaryYAxis: NumericAxis(
                                  minimum: 0,
                                  maximum: 2,
                                  interval: 1,
                                  labelStyle: const TextStyle(
                                    color: Colors.transparent,
                                    fontSize: 1,
                                  ),
                                  majorTickLines: const MajorTickLines(size: 0),
                                  minorTicksPerInterval: 4,
                                  minorTickLines: const MinorTickLines(size: 0),
                                  majorGridLines: const MajorGridLines(width: 0),
                                  minorGridLines: const MinorGridLines(width: 0),
                                  axisLine: const AxisLine(width: 0),
                                ),
                                series: const <CartesianSeries<dynamic, dynamic>>[],
                              ),
                            ),
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _TickCapsule(
                                      width: majorTickWidth,
                                      height: majorTickHeight,
                                      color: AppColors.hydrationAccent,
                                    ),
                                    _TickCapsule(
                                      width: minorTickWidth,
                                      height: minorTickHeight,
                                      color: AppColors.hydrationAccent.withOpacity(0.22),
                                    ),
                                    _TickCapsule(
                                      width: minorTickWidth,
                                      height: minorTickHeight,
                                      color: AppColors.hydrationAccent.withOpacity(0.22),
                                    ),
                                    _TickCapsule(
                                      width: minorTickWidth,
                                      height: minorTickHeight,
                                      color: AppColors.hydrationAccent.withOpacity(0.22),
                                    ),
                                    _TickCapsule(
                                      width: minorTickWidth,
                                      height: minorTickHeight,
                                      color: AppColors.hydrationAccent.withOpacity(0.22),
                                    ),
                                    _TickCapsule(
                                      width: majorTickWidth,
                                      height: majorTickHeight,
                                      color: AppColors.hydrationAccent,
                                    ),
                                    _TickCapsule(
                                      width: minorTickWidth,
                                      height: minorTickHeight,
                                      color: AppColors.hydrationAccent.withOpacity(0.22),
                                    ),
                                    _TickCapsule(
                                      width: minorTickWidth,
                                      height: minorTickHeight,
                                      color: AppColors.hydrationAccent.withOpacity(0.22),
                                    ),
                                    _TickCapsule(
                                      width: minorTickWidth,
                                      height: minorTickHeight,
                                      color: AppColors.hydrationAccent.withOpacity(0.22),
                                    ),
                                    _TickCapsule(
                                      width: minorTickWidth,
                                      height: minorTickHeight,
                                      color: AppColors.hydrationAccent.withOpacity(0.22),
                                    ),
                                    _TickCapsule(
                                      width: majorTickWidth,
                                      height: majorTickHeight,
                                      color: AppColors.hydrationAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,

                              child: Text(
                                '0ml',
                                style: AppTextStyles.caloriesTextStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            decoration: BoxDecoration(
              color: const Color(0xFF214D58),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Text(
              '${data.addedMl} ml added to water log',
              textAlign: TextAlign.center,
              style: AppTextStyles.caloriesRemainingStyle.copyWith(
                color: AppColors.whiteColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TickCapsule extends StatelessWidget {
  const _TickCapsule({
    required this.width,
    required this.height,
    required this.color,
  });

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
