import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_base.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:equatable/equatable.dart';

abstract class WorkoutState extends Equatable {
  const WorkoutState();
}

// initial state
class Initial extends WorkoutState {
  final List<WorkoutSummary> workoutSummaries = List<WorkoutSummary>();

  @override
  List<Object> get props => [workoutSummaries];
}

class Ready extends WorkoutState {
  final List<WorkoutSummary> workoutSummaries;

  @override
  List<Object> get props => [];

  const Ready(this.workoutSummaries);
}

class Final extends WorkoutState {
  final Workout workout;

  Final(this.workout);

  @override
  List<Object> get props => [workout];
}

class Adding extends WorkoutState {
  final Activity activity;

  Adding(this.activity);

  @override
  List<Object> get props => [activity];
}
