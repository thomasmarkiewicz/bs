import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/core/usecases/usecase.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CreateWorkout implements Usecase<Workout, Params> {
  final AbstractWorkoutRepository repository;

  CreateWorkout(this.repository);

  @override
  Future<Either<Failure, Workout>> call(Params params) async {
    return await repository.createWorkout(params.workout);
  }
}

class Params extends Equatable {
  final Workout workout;

  @override
  List<Object> get props => [workout];

  Params({@required this.workout});
}
