import 'package:evencir_app/core/utils/app_colors.dart';
import 'package:evencir_app/core/utils/app_text_styles.dart';
import 'package:evencir_app/data/models/calorie_insight_data.dart';
import 'package:flutter/material.dart';

class CalorieInsightWidget extends StatelessWidget {
  const CalorieInsightWidget({
    super.key,
    required this.data,
  });

  static const double _cardHeight = 170;

  final CalorieInsightData data;

  @override
  Widget build(BuildContext context) {
    final progress = data.progress.clamp(0.0, 1.0);

    return SizedBox(
      height: _cardHeight,
      child: Container(
        width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.caloriesBurned.toString(),
                  style: AppTextStyles.caloriesNumberStyle.copyWith(
                    color: AppColors.whiteColor,
                    
                  ),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Calories',
                    style: AppTextStyles.caloriesTextStyle.copyWith(
                      color: AppColors.whiteColor,
                      
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${data.caloriesRemaining} Remaining',
            style: AppTextStyles.caloriesRemainingStyle.copyWith(
              color: AppColors.mutedText,
              
            ),
          ),
          const SizedBox(height: 34),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0',
                style: AppTextStyles.caloriesRangeStyle.copyWith(
                  color: AppColors.mutedText,
                  
                ),
              ),
              Text(
                data.totalCalories.toString(),
                style: AppTextStyles.caloriesRangeStyle.copyWith(
                  color: AppColors.mutedText,
                  
                ),
              ),
            ],
          ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 8,
                value: progress,
                backgroundColor: AppColors.dayBackground,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.workoutAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
