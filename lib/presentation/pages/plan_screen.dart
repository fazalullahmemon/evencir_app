import 'package:evencir_app/core/utils/app_colors.dart';
import 'package:evencir_app/core/utils/app_text_styles.dart';
import 'package:evencir_app/data/models/plan_workout_event.dart';
import 'package:evencir_app/presentation/bloc/plan_bloc.dart';
import 'package:evencir_app/presentation/widgets/plan_week_calendar_widget.dart';
import 'package:evencir_app/presentation/widgets/plan_week_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  static final DateTime _planStartDate = DateTime(2026, 5, 1);
  static const int _totalWeeks = 8;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        final week1 = _buildSummaryForWeek(
          state.workoutEvents,
          weekIndex: 1,
        );
        final week2 = _buildSummaryForWeek(
          state.workoutEvents,
          weekIndex: 2,
        );

        return Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: AppBar(
            backgroundColor: AppColors.pageBackground,
            elevation: 0,
            centerTitle: false,
            titleSpacing: 16,
            title: Text(
              'Training Calendar',
              style: AppTextStyles.heading.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteColor,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(
                    'Save',
                    style: AppTextStyles.saveTextStyle.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlanWeekSummaryWidget(
                  weekLabel: week1.weekLabel,
                  dateRangeLabel: week1.dateRangeLabel,
                  totalLabel: week1.totalLabel,
                  dividerColor: AppColors.planDivider,
                ),
                SizedBox(height: 24.h),
                 Expanded(
                  child: PlanWeekCalendarWidget(
                    startDate: _planStartDate,
                  ),
                ),
                PlanWeekSummaryWidget(
                  weekLabel: week2.weekLabel,
                  dateRangeLabel: week2.dateRangeLabel,
                  totalLabel: week2.totalLabel,
                  dividerColor: const Color(0xFF19AA99),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _WeekSummaryData _buildSummaryForWeek(
    List<PlanWorkoutEvent> workoutEvents, {
    required int weekIndex,
  }) {
    final weekStart = _planStartDate.add(Duration(days: (weekIndex - 1) * 7));
    final weekEnd = weekStart.add(const Duration(days: 6));
    final eventsInWeek = workoutEvents
        .where((event) => _isInRange(event.day, weekStart, weekEnd))
        .toList(growable: false);
    final totalMinutes = eventsInWeek.fold<int>(
      0,
      (sum, event) => sum + _minimumDurationMinutes(event.durationLabel),
    );

    return _WeekSummaryData(
      weekLabel: 'Week $weekIndex/$_totalWeeks',
      dateRangeLabel: _formatDateRange(weekStart, weekEnd),
      totalLabel: 'Total: ${totalMinutes}min',
    );
  }

  bool _isInRange(DateTime day, DateTime start, DateTime end) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    final normalizedStart = DateTime(start.year, start.month, start.day);
    final normalizedEnd = DateTime(end.year, end.month, end.day);
    return !normalizedDay.isBefore(normalizedStart) &&
        !normalizedDay.isAfter(normalizedEnd);
  }

  int _minimumDurationMinutes(String durationLabel) {
    final match = RegExp(r'(\d+)m').firstMatch(durationLabel);
    if (match == null) {
      return 0;
    }
    return int.tryParse(match.group(1) ?? '') ?? 0;
  }

  String _formatDateRange(DateTime start, DateTime end) {
    const months = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    if (start.month == end.month) {
      return '${months[start.month - 1]} ${start.day}-${end.day}';
    }

    return '${months[start.month - 1]} ${start.day} - ${months[end.month - 1]} ${end.day}';
  }
}

final class _WeekSummaryData {
  const _WeekSummaryData({
    required this.weekLabel,
    required this.dateRangeLabel,
    required this.totalLabel,
  });

  final String weekLabel;
  final String dateRangeLabel;
  final String totalLabel;
}
