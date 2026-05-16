import 'package:evencir_app/data/models/plan_workout_event.dart';

abstract class PlanWorkoutRepository {
  List<PlanWorkoutEvent> loadWorkoutEvents();
}
