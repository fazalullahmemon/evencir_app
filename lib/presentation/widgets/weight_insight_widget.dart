import 'package:evencir_app/core/utils/app_colors.dart';
import 'package:evencir_app/core/utils/app_text_styles.dart';
import 'package:evencir_app/data/models/weight_insight_data.dart';
import 'package:evencir_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class WeightInsightWidget extends StatelessWidget {
  const WeightInsightWidget({
    super.key,
    required this.data,
  });

  static const double _cardHeight = 170;

  final WeightInsightData data;

  String _formatTrend(double value) {
    final text = value.toStringAsFixed(1);
    return text.endsWith('.0') ? text.substring(0, text.length - 2) : text;
  }

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                    Text(
                      data.currentWeight.toString(),
                      style: AppTextStyles.weightNumberStyle.copyWith(
                        color: AppColors.whiteColor,
                        
                      ),
                    ),
                    const SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'kg',
                        style: AppTextStyles.weightTextStyle.copyWith(
                          color: AppColors.whiteColor,
                          
                        ),
                      ),
                    ),
                  ],
                ),
                ),
                  const SizedBox(height: 6),
            Row(
              children: [
                Assets.icons.upwardTrendArrow.svg(
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 10),
              Text(
                '+${_formatTrend(data.upwardTrendWeight)}kg',
                style: AppTextStyles.weightTextStyle.copyWith(
                  color: AppColors.mutedText,
                  
                ),
              ),
            ],
          ),
              ],
            ),
          
          const SizedBox(height: 14),
          Text(
            'Weight',
            style: AppTextStyles.weightNameStyle.copyWith(
              color: AppColors.whiteColor,
              
            ),
          ),
        ],
      ),
      ),
    );
  }
}
