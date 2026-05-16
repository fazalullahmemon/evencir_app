import 'package:evencir_app/data/models/plan_workout_event.dart';

class WorkoutEventFormatter {
  WorkoutEventFormatter._();

  static const List<String> _months = <String>[
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

  static String formatDayLabel(DateTime day) {
    return '${_months[day.month - 1]} ${day.day}';
  }

  static String formatNutritionSubtitle(PlanWorkoutEvent event) {
    return '${formatDayLabel(event.day)} - ${event.durationLabel}';
  }
}
