import 'package:evencir_app/data/models/plan_workout_event.dart';

enum PlanStatus {
  initial,
  ready,
}

final class PlanState {
  PlanState({
    required this.status,
    required this.nutritionSelectedDay,
    required this.nutritionFocusedDay,
    required this.nutritionPlanStartDate,
    required this.nutritionTotalWeeks,
    required List<PlanWorkoutEvent> workoutEvents,
  }) : workoutEvents = List<PlanWorkoutEvent>.unmodifiable(workoutEvents);

  PlanState.initial()
      : this(
          status: PlanStatus.initial,
          nutritionSelectedDay: _todayDateOnly(),
          nutritionFocusedDay: _todayDateOnly(),
          nutritionPlanStartDate: DateTime(2025, 12, 8),
          nutritionTotalWeeks: 4,
          workoutEvents: const <PlanWorkoutEvent>[],
        );

  PlanState.ready({
    required DateTime nutritionSelectedDay,
    required DateTime nutritionFocusedDay,
    required DateTime nutritionPlanStartDate,
    required int nutritionTotalWeeks,
    required List<PlanWorkoutEvent> workoutEvents,
  }) : this(
          status: PlanStatus.ready,
          nutritionSelectedDay: nutritionSelectedDay,
          nutritionFocusedDay: nutritionFocusedDay,
          nutritionPlanStartDate: nutritionPlanStartDate,
          nutritionTotalWeeks: nutritionTotalWeeks,
          workoutEvents: workoutEvents,
        );

  final PlanStatus status;
  final DateTime nutritionSelectedDay;
  final DateTime nutritionFocusedDay;
  final DateTime nutritionPlanStartDate;
  final int nutritionTotalWeeks;
  final List<PlanWorkoutEvent> workoutEvents;

  int _weekIndexFor(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    final start = DateTime(
      nutritionPlanStartDate.year,
      nutritionPlanStartDate.month,
      nutritionPlanStartDate.day,
    );
    final differenceInDays = normalizedDay.difference(start).inDays;
    if (differenceInDays <= 0) {
      return 1;
    }
    final cycleIndex = (differenceInDays ~/ 7) % nutritionTotalWeeks;
    return cycleIndex + 1;
  }

  int get nutritionSelectedWeekIndex => _weekIndexFor(nutritionSelectedDay);
  String get nutritionWeekLabel =>
      'Week $nutritionSelectedWeekIndex/$nutritionTotalWeeks';

  PlanState copyWith({
    PlanStatus? status,
    DateTime? nutritionSelectedDay,
    DateTime? nutritionFocusedDay,
    DateTime? nutritionPlanStartDate,
    int? nutritionTotalWeeks,
    List<PlanWorkoutEvent>? workoutEvents,
  }) {
    return PlanState(
      status: status ?? this.status,
      nutritionSelectedDay: nutritionSelectedDay ?? this.nutritionSelectedDay,
      nutritionFocusedDay: nutritionFocusedDay ?? this.nutritionFocusedDay,
      nutritionPlanStartDate:
          nutritionPlanStartDate ?? this.nutritionPlanStartDate,
      nutritionTotalWeeks: nutritionTotalWeeks ?? this.nutritionTotalWeeks,
      workoutEvents: workoutEvents ?? this.workoutEvents,
    );
  }
}

DateTime _todayDateOnly() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}
