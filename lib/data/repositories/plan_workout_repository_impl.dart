import 'package:evencir_app/data/datasources/workout_event_data_source.dart';
import 'package:evencir_app/data/models/plan_workout_event.dart';
import 'package:evencir_app/domain/repositories/plan_workout_repository.dart';

class PlanWorkoutRepositoryImpl implements PlanWorkoutRepository {
  const PlanWorkoutRepositoryImpl();

  @override
  List<PlanWorkoutEvent> loadWorkoutEvents() {
    return List<PlanWorkoutEvent>.unmodifiable(
      WorkoutEventDataSource.workoutEvents,
    );
  }
}
