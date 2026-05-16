import 'package:evencir_app/core/utils/app_colors.dart';
import 'package:evencir_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanWeekSummaryWidget extends StatelessWidget {
  const PlanWeekSummaryWidget({
    super.key,
    required this.weekLabel,
    required this.dateRangeLabel,
    required this.totalLabel,
    required this.dividerColor,
  });

  final String weekLabel;
  final String dateRangeLabel;
  final String totalLabel;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.planWeekSummaryBackground,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 3, color: dividerColor),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        weekLabel,
                        style: AppTextStyles.planWeekTitleStyle.copyWith(
                          color: AppColors.whiteColor,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        dateRangeLabel,
                        style: AppTextStyles.planWeekSubtitleStyle.copyWith(
                          color: AppColors.mutedText,
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Text(
                    totalLabel,
                    style: AppTextStyles.planWeekSubtitleStyle.copyWith(
                      color: AppColors.mutedText,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
