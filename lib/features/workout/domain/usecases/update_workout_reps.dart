import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/core/usecases/usecase.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UpdateWorkoutReps implements Usecase<Workout, UpdateRepsParams> {
  final AbstractWorkoutRepository repository;

  UpdateWorkoutReps(this.repository);

  @override
  Future<Either<Failure, Workout>> call(UpdateRepsParams params) async {
    final workout = params.workout.updateReps(
      supersetIndex: params.supersetIndex,
      exerciseSetIndex: params.exerciseSetIndex,
      repIndex: params.repIndex,
    );

    return await repository.updateWorkout(workout);
  }
}

class UpdateRepsParams extends Equatable {
  final Workout workout;
  final int supersetIndex;
  final int exerciseSetIndex;
  final int repIndex;

  @override
  List<Object> get props =>
      [workout, supersetIndex, exerciseSetIndex, repIndex];

  UpdateRepsParams({
    @required this.workout,
    @required this.supersetIndex,
    @required this.exerciseSetIndex,
    @required this.repIndex,
  });
}
