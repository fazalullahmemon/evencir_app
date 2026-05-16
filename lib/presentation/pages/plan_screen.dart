import 'package:evencir_app/core/utils/app_colors.dart';
import 'package:evencir_app/core/utils/app_text_styles.dart';
import 'package:evencir_app/presentation/widgets/plan_week_summary_widget.dart';
import 'package:evencir_app/presentation/widgets/plan_week_calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            const PlanWeekSummaryWidget(
              weekLabel: 'Week 2/8',
              dateRangeLabel: 'December 8-14',
              totalLabel: 'Total: 60min',
              dividerColor: AppColors.planDivider,
            ),
            SizedBox(height: 24.h),
             Expanded(
              child: PlanWeekCalendarWidget(
                startDate: DateTime(2026, 5, 1),
              ),
            ),
            const PlanWeekSummaryWidget(
              weekLabel: 'Week 2',
              dateRangeLabel: 'December 8-14',
              totalLabel: 'Total: 60min',
              dividerColor: Color(0xFF19AA99),
            ),
          ],
        ),
      ),
    );
  }
}
