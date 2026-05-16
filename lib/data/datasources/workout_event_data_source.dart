import 'package:evencir_app/data/models/plan_workout_event.dart';

class WorkoutEventDataSource {
  WorkoutEventDataSource._();

  static final List<PlanWorkoutEvent> workoutEvents =
      List<PlanWorkoutEvent>.unmodifiable(<PlanWorkoutEvent>[
    PlanWorkoutEvent(
      id: 'upper-body',
      day: DateTime(2025, 12, 22),
      badgeLabel: 'Upper Body',
      title: 'Upper Body',
      durationLabel: '25m - 30m',
    ),
    PlanWorkoutEvent(
      id: 'lower-body',
      day: DateTime(2025, 12, 23),
      badgeLabel: 'Lower Body',
      title: 'Lower Body',
      durationLabel: '20m - 28m',
    ),
    PlanWorkoutEvent(
      id: 'may-upper-body',
      day: DateTime(2026, 5, 5),
      badgeLabel: 'Upper Body',
      title: 'Upper Body Blast',
      durationLabel: '25m - 30m',
    ),
    PlanWorkoutEvent(
      id: 'may-core',
      day: DateTime(2026, 5, 12),
      badgeLabel: 'Core',
      title: 'Core Strength',
      durationLabel: '18m - 22m',
    ),
    PlanWorkoutEvent(
      id: 'may-recovery',
      day: DateTime(2026, 5, 23),
      badgeLabel: 'Recovery',
      title: 'Recovery Flow',
      durationLabel: '15m - 20m',
    ),
    PlanWorkoutEvent(
      id: 'may-week1-push',
      day: DateTime(2026, 5, 1),
      badgeLabel: 'Push',
      title: 'Push Power',
      durationLabel: '20m - 25m',
    ),
    PlanWorkoutEvent(
      id: 'may-week1-mobility',
      day: DateTime(2026, 5, 3),
      badgeLabel: 'Mobility',
      title: 'Mobility Flow',
      durationLabel: '15m - 18m',
    ),
    PlanWorkoutEvent(
      id: 'may-week1-legs',
      day: DateTime(2026, 5, 7),
      badgeLabel: 'Legs',
      title: 'Leg Builder',
      durationLabel: '22m - 28m',
    ),
    PlanWorkoutEvent(
      id: 'may-week2-pull',
      day: DateTime(2026, 5, 8),
      badgeLabel: 'Pull',
      title: 'Pull Strength',
      durationLabel: '20m - 26m',
    ),
    PlanWorkoutEvent(
      id: 'may-week2-core',
      day: DateTime(2026, 5, 10),
      badgeLabel: 'Core',
      title: 'Core Stability',
      durationLabel: '16m - 20m',
    ),
    PlanWorkoutEvent(
      id: 'may-week2-cardio',
      day: DateTime(2026, 5, 14),
      badgeLabel: 'Cardio',
      title: 'Cardio Burn',
      durationLabel: '18m - 24m',
    ),
    PlanWorkoutEvent(
      id: 'may-week3-upper',
      day: DateTime(2026, 5, 15),
      badgeLabel: 'Upper Body',
      title: 'Upper Body Blast',
      durationLabel: '25m - 30m',
    ),
    PlanWorkoutEvent(
      id: 'may-week3-recovery',
      day: DateTime(2026, 5, 17),
      badgeLabel: 'Recovery',
      title: 'Recovery Stretch',
      durationLabel: '12m - 18m',
    ),
    PlanWorkoutEvent(
      id: 'may-week3-legs',
      day: DateTime(2026, 5, 21),
      badgeLabel: 'Legs',
      title: 'Leg Day Drive',
      durationLabel: '24m - 30m',
    ),
    PlanWorkoutEvent(
      id: 'may-week4-push',
      day: DateTime(2026, 5, 22),
      badgeLabel: 'Push',
      title: 'Push Endurance',
      durationLabel: '20m - 25m',
    ),
    PlanWorkoutEvent(
      id: 'may-week4-core',
      day: DateTime(2026, 5, 24),
      badgeLabel: 'Core',
      title: 'Core Finish',
      durationLabel: '18m - 22m',
    ),
    PlanWorkoutEvent(
      id: 'may-week4-flow',
      day: DateTime(2026, 5, 28),
      badgeLabel: 'Flow',
      title: 'Flow Session',
      durationLabel: '15m - 20m',
    ),
    PlanWorkoutEvent(
      id: 'may-week5-reset',
      day: DateTime(2026, 5, 29),
      badgeLabel: 'Reset',
      title: 'Reset Routine',
      durationLabel: '15m - 18m',
    ),
    PlanWorkoutEvent(
      id: 'may-week5-mobility',
      day: DateTime(2026, 5, 30),
      badgeLabel: 'Mobility',
      title: 'Mobility Reset',
      durationLabel: '14m - 18m',
    ),
    PlanWorkoutEvent(
      id: 'may-week5-cardio',
      day: DateTime(2026, 5, 31),
      badgeLabel: 'Cardio',
      title: 'Cardio Sprint',
      durationLabel: '18m - 22m',
    ),
  ]);
}
