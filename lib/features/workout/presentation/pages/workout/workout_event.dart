import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:equatable/equatable.dart';

abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();
}

class Refresh extends WorkoutEvent {
  @override
  List<Object> get props => null;
}

class WorkoutSelected extends WorkoutEvent {
  final WorkoutSummary workoutSummary;

  WorkoutSelected(this.workoutSummary);

  @override
  List<Object> get props => [workoutSummary];
}