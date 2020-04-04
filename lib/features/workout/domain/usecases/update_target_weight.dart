import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/core/usecases/usecase.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UpdateTargetWeight implements Usecase<Workout, TargetWeightParams> {
  final AbstractWorkoutRepository repository;

  UpdateTargetWeight(this.repository);

  @override
  Future<Either<Failure, Workout>> call(TargetWeightParams params) async {
    final workout = params.workout.updateTargetWeight(
      supersetIndex: params.supersetIndex,
      exerciseSetIndex: params.exerciseSetIndex,
      weight: params.weight,
    );

    return await repository.updateWorkout(workout);
  }
}

class TargetWeightParams extends Equatable {
  final Workout workout;
  final int supersetIndex;
  final int exerciseSetIndex;
  final int weight;

  @override
  List<Object> get props =>
      [workout, supersetIndex, exerciseSetIndex, weight];

  TargetWeightParams({
    @required this.workout,
    @required this.supersetIndex,
    @required this.exerciseSetIndex,
    @required this.weight,
  });
}
