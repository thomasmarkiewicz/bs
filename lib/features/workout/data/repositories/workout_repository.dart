import 'package:bodysculpting/core/error/exceptions.dart';
import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/features/workout/data/datasources/abstract_workout_local_data_source.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class WorkoutRepository implements AbstractWorkoutRepository {
  final AbstractWorkoutLocalDataSource localDataSource;

  WorkoutRepository({@required this.localDataSource});

  @override
  Future<Either<Failure, Workout>> createWorkout(Workout workout) async {
    try {
      final Workout result = await localDataSource.createWorkout(workout);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Workout>> deleteWorkout({
    DateTime start,
    DateTime end,
  }) async {
    try {
      final result =
          await localDataSource.deleteWorkout(start: start, end: end);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Workout>> getActiveWorkout() {
    // TODO: implement getActiveWorkout
    return null;
  }

  @override
  Future<Either<Failure, Workout>> getWorkout({
    @required DateTime start,
    @required Option<DateTime> end,
  }) async {
    try {
      final result = await localDataSource.getWorkout(start: start, end: end);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<WorkoutSummary>>> getWorkoutSummaries({
    DateTime start,
    DateTime end,
  }) async {
    try {
      final result =
          await localDataSource.getWorkoutSummaries(start: start, end: end);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Workout>> updateWorkout(Workout workout) async {
    try {
      final Workout result =
          await localDataSource.updateWorkout(WorkoutModel.from(workout));
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
