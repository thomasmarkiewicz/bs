import 'package:bodysculpting/core/error/exceptions.dart';
import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/core/usecases/usecase.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class DeleteWorkout implements Usecase<Workout, DeleteWorkoutParams> {
  final AbstractWorkoutRepository repository;

  DeleteWorkout(this.repository);

  @override
  Future<Either<Failure, Workout>> call(DeleteWorkoutParams params) async {
    return await repository.deleteWorkout(
      start: params.workout.start.getOrElse(() => throw CacheException()),
      end: params.workout.end.getOrElse(() => throw CacheException()),
    );
  }
}

class DeleteWorkoutParams extends Equatable {
  final Workout workout;

  @override
  List<Object> get props => [workout];

  DeleteWorkoutParams({
    @required this.workout,
  });
}
