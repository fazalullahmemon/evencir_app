sealed class PlanEvent {
  const PlanEvent();
}

final class PlanWorkoutEventMoved extends PlanEvent {
  const PlanWorkoutEventMoved({
    required this.eventId,
    required this.newDay,
  });

  final String eventId;
  final DateTime newDay;
}

final class PlanNutritionDaySelected extends PlanEvent {
  const PlanNutritionDaySelected({
    required this.selectedDay,
  });

  final DateTime selectedDay;
}

final class PlanNutritionFocusedDayChanged extends PlanEvent {
  const PlanNutritionFocusedDayChanged({
    required this.focusedDay,
  });

  final DateTime focusedDay;
}
