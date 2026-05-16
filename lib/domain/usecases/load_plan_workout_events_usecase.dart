import 'package:evencir_app/data/models/plan_workout_event.dart';
import 'package:evencir_app/domain/repositories/plan_workout_repository.dart';

class LoadPlanWorkoutEventsUseCase {
  const LoadPlanWorkoutEventsUseCase(this._repository);

  final PlanWorkoutRepository _repository;

  List<PlanWorkoutEvent> call() {
    return _repository.loadWorkoutEvents();
  }
}
