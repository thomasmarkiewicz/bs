import 'package:bodysculpting/core/error/exceptions.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_summary_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:dartz/dartz.dart';
import 'abstract_json_local_data_source.dart';
import 'abstract_workout_local_data_source.dart';
import 'dart:io';
import 'package:meta/meta.dart';

class WorkoutLocalDataSource implements AbstractWorkoutLocalDataSource {
  final AbstractJsonLocalDataSource jsonLocalDataSource;

  WorkoutLocalDataSource(this.jsonLocalDataSource);

  @override
  Future<WorkoutModel> createWorkout(WorkoutModel workout) async {
    if (await jsonLocalDataSource.workoutExists(
        start: workout.start.getOrElse(() => DateTime.now()))) {
      throw CacheException();
    }

    try {
      // we are sure here the workout being created doesn't exist yet
      final newWorkout = await jsonLocalDataSource.writeWorkout(workout);
      return newWorkout;
    } on FileSystemException {
      // failed to write it for some other reason
      throw CacheException();
    }
  }

  @override
  Future<WorkoutModel> updateWorkout(WorkoutModel workout) async {
    if (!await jsonLocalDataSource.workoutExists(
        start: workout.start.getOrElse(() => DateTime.now()))) {
      throw CacheException();
    }

    try {
      final updatedWorkout = await jsonLocalDataSource.writeWorkout(workout);
      return updatedWorkout;
    } on FileSystemException {
      throw CacheException();
    }
  }

  @override
  Future<List<WorkoutSummaryModel>> getWorkoutSummaries(
      {DateTime start, DateTime end}) async {
    try {
      final summaries = await jsonLocalDataSource.readWorkoutSummaries(
        start: start,
        end: end,
      );
      return summaries;
    } on FileSystemException {
      throw CacheException();
    }
  }

  @override
  Future<Workout> getWorkout({
    @required DateTime start,
    @required Option<DateTime> end,
  }) async {
    try {
      final workout = await jsonLocalDataSource.readWorkout(
        start: start,
        end: end,
      );
      return workout;
    } on FileSystemException {
      throw CacheException();
    }
  }

  @override
  Future<WorkoutModel> deleteWorkout({
    DateTime start,
    DateTime end,
  }) async {
    try {
      final workout = await jsonLocalDataSource.deleteWorkout(
        start: start,
        end: end,
      );
      return workout;
    } on FileSystemException {
      throw CacheException();
    }
  }
}
