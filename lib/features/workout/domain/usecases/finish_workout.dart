import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/core/usecases/usecase.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class FinishWorkout implements Usecase<Workout, FinishWorkoutParams> {
  final AbstractWorkoutRepository repository;

  FinishWorkout(this.repository);

  @override
  Future<Either<Failure, Workout>> call(FinishWorkoutParams params) async {
    return await repository.updateWorkout(params.workout.finished());
  }
}

class FinishWorkoutParams extends Equatable {
  final Workout workout;

  @override
  List<Object> get props => [workout];

  FinishWorkoutParams({
    @required this.workout,
  });
}
