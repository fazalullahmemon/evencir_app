import 'package:bloc/bloc.dart';

import 'package:evencir_app/data/models/plan_workout_event.dart';
import 'package:evencir_app/domain/usecases/load_plan_workout_events_usecase.dart';
import 'plan_event.dart';
import 'plan_state.dart';

export 'plan_event.dart';
export 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc({
    required LoadPlanWorkoutEventsUseCase loadPlanWorkoutEventsUseCase,
  }) : super(
          PlanState.ready(
            nutritionSelectedDay: _todayDateOnly(),
            nutritionFocusedDay: _todayDateOnly(),
            nutritionPlanStartDate: DateTime(2026, 5, 1),
            nutritionTotalWeeks: 4,
            workoutEvents: loadPlanWorkoutEventsUseCase(),
          ),
        ) {
    on<PlanWorkoutEventMoved>(_onPlanWorkoutEventMoved);
    on<PlanNutritionDaySelected>(_onPlanNutritionDaySelected);
    on<PlanNutritionFocusedDayChanged>(_onPlanNutritionFocusedDayChanged);
  }

  List<PlanWorkoutEvent> get workoutEvents => state.workoutEvents;

  List<PlanWorkoutEvent> workoutEventsForDay(DateTime day) {
    return state.workoutEvents
        .where((event) => _isSameDay(event.day, day))
        .toList(growable: false);
  }

  bool hasWorkoutOn(DateTime day) {
    return state.workoutEvents.any((event) => _isSameDay(event.day, day));
  }

  void moveWorkoutEvent({
    required String eventId,
    required DateTime newDay,
  }) {
    add(PlanWorkoutEventMoved(
      eventId: eventId,
      newDay: newDay,
    ));
  }

  void selectNutritionDay(DateTime selectedDay) {
    add(PlanNutritionDaySelected(selectedDay: selectedDay));
  }

  void focusNutritionDay(DateTime focusedDay) {
    add(PlanNutritionFocusedDayChanged(focusedDay: focusedDay));
  }

  Future<void> _onPlanWorkoutEventMoved(
    PlanWorkoutEventMoved event,
    Emitter<PlanState> emit,
  ) async {
    final normalizedDay = DateTime(
      event.newDay.year,
      event.newDay.month,
      event.newDay.day,
    );
    final eventIndex = state.workoutEvents.indexWhere(
      (workoutEvent) => workoutEvent.id == event.eventId,
    );

    if (eventIndex == -1) {
      return;
    }

    final currentEvent = state.workoutEvents[eventIndex];
    if (_isSameDay(currentEvent.day, normalizedDay)) {
      return;
    }

    final updatedEvents = List<PlanWorkoutEvent>.from(state.workoutEvents);
    updatedEvents[eventIndex] = currentEvent.copyWith(day: normalizedDay);
    emit(state.copyWith(workoutEvents: updatedEvents));
  }

  Future<void> _onPlanNutritionDaySelected(
    PlanNutritionDaySelected event,
    Emitter<PlanState> emit,
  ) async {
    final normalizedDay = DateTime(
      event.selectedDay.year,
      event.selectedDay.month,
      event.selectedDay.day,
    );

    if (_isSameDay(state.nutritionSelectedDay, normalizedDay)) {
      return;
    }

    emit(state.copyWith(nutritionSelectedDay: normalizedDay));
  }

  Future<void> _onPlanNutritionFocusedDayChanged(
    PlanNutritionFocusedDayChanged event,
    Emitter<PlanState> emit,
  ) async {
    final normalizedDay = DateTime(
      event.focusedDay.year,
      event.focusedDay.month,
      event.focusedDay.day,
    );

    if (_isSameDay(state.nutritionFocusedDay, normalizedDay)) {
      return;
    }

    emit(state.copyWith(nutritionFocusedDay: normalizedDay));
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

DateTime _todayDateOnly() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}
