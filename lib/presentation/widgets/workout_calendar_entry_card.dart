import 'package:evencir_app/core/utils/app_colors.dart';
import 'package:evencir_app/core/utils/app_text_styles.dart';
import 'package:evencir_app/core/utils/workout_event_formatter.dart';
import 'package:evencir_app/data/models/plan_workout_event.dart';
import 'package:evencir_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class WorkoutCalendarEntryCard extends StatelessWidget {
  const WorkoutCalendarEntryCard({
    super.key,
    required this.event,
  });

  final PlanWorkoutEvent event;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.workoutAccent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 10, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    WorkoutEventFormatter.formatNutritionSubtitle(event),
                    style: AppTextStyles.workoutWidgetDateStyle.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    event.title,
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Assets.icons.rightArrow.svg(
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
