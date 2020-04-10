import 'dart:io';
import 'package:bodysculpting/core/error/exceptions.dart';
import 'package:bodysculpting/features/workout/data/datasources/abstract_json_local_data_source.dart';
import 'package:bodysculpting/features/workout/data/datasources/workout_local_data_source.dart';
import 'package:bodysculpting/features/workout/data/models/exercise_set_model.dart';
import 'package:bodysculpting/features/workout/data/models/set_model.dart';
import 'package:bodysculpting/features/workout/data/models/units_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

class MockJsonLocalDataSource extends Mock
    implements AbstractJsonLocalDataSource {}

void main() {
  MockJsonLocalDataSource mockJsonLocalDataSource;
  WorkoutLocalDataSource localDataSource;

  final whenWorkoutExists = () =>
      when(mockJsonLocalDataSource.workoutExists(start: anyNamed('start')))
          .thenAnswer((_) async => Future.value(true));

  final whenWorkoutDoesNotExist = () =>
      when(mockJsonLocalDataSource.workoutExists(start: anyNamed('start')))
          .thenAnswer((_) async => Future.value(false));

  setUp(() {
    mockJsonLocalDataSource = MockJsonLocalDataSource();
    localDataSource = WorkoutLocalDataSource(mockJsonLocalDataSource);
  });

  final testWorkout = WorkoutModel(
    activity: Activity.lift,
    name: 'Barbbell Lifts 3x10 A',
    description: some('Squat, Bench, Press'),
    units: UnitsModel(weight: "lb", distance: "km"),
    start: some(DateTime(2020, 4, 25, 17, 30, 00)),
    end: some(DateTime(2020, 4, 25, 18, 00, 00)),
    summary: some("Optional summary"),
    supersets: [
      [
        ExerciseSetModel(
            exerciseId: '1',
            exerciseName: 'Squats',
            targetWeight: 135,
            sets: [
              SetModel(
                  targetReps: 10,
                  targetRest: 180,
                  reps: some(10),
                  weight: some(135)),
              SetModel(
                  targetReps: 10,
                  targetRest: 180,
                  reps: some(10),
                  weight: some(135)),
              SetModel(
                  targetReps: 10,
                  targetRest: 180,
                  reps: some(10),
                  weight: some(135)),
            ])
      ],
      [
        ExerciseSetModel(
            exerciseId: '1',
            exerciseName: 'Squats',
            targetWeight: 135,
            sets: [
              SetModel(
                  targetReps: 10,
                  targetRest: 180,
                  reps: some(9),
                  weight: some(135)),
              SetModel(
                  targetReps: 10,
                  targetRest: 180,
                  reps: some(9),
                  weight: some(135)),
              SetModel(
                  targetReps: 10,
                  targetRest: 180,
                  reps: some(8),
                  weight: some(130)),
            ]),
        ExerciseSetModel(
            exerciseId: '2',
            exerciseName: 'Bench Press',
            targetWeight: 135,
            sets: [
              SetModel(
                targetReps: 10,
                targetRest: 180,
                reps: none(),
                weight: none(),
              ),
              SetModel(
                targetReps: 10,
                targetRest: 180,
                reps: none(),
                weight: none(),
              ),
              SetModel(
                targetReps: 10,
                targetRest: 180,
                reps: none(),
                weight: none(),
              ),
            ]),
      ]
    ],
  );

  group('createWorkout', () {
    test('returns a Workout if one did not exist yet', () async {
      when(mockJsonLocalDataSource.writeWorkout(any))
          .thenAnswer((_) async => Future.value(testWorkout));
      whenWorkoutDoesNotExist();
      final result = await localDataSource.createWorkout(testWorkout);

      expect(result, testWorkout);
      verify(mockJsonLocalDataSource.workoutExists(
        start: testWorkout.start.getOrElse(() => DateTime.now()),
      ));
      verify(mockJsonLocalDataSource.writeWorkout(testWorkout));
      verifyNoMoreInteractions(mockJsonLocalDataSource);
    });

    test('throws CacheException if workout already exists', () async {
      whenWorkoutExists();

      final call = localDataSource.createWorkout;

      await expectLater(() async => await call(testWorkout),
          throwsA(TypeMatcher<CacheException>()));

      verify(mockJsonLocalDataSource.workoutExists(
        start: testWorkout.start.getOrElse(() => DateTime.now()),
      ));

      verifyNoMoreInteractions(mockJsonLocalDataSource);
    });

    test(
        'throws CacheException if workout does not exist yet but fails to write',
        () async {
      whenWorkoutDoesNotExist();

      when(mockJsonLocalDataSource.writeWorkout(any))
          .thenThrow(FileSystemException());

      final call = localDataSource.createWorkout;

      await expectLater(() async => await call(testWorkout),
          throwsA(TypeMatcher<CacheException>()));

      verify(mockJsonLocalDataSource.workoutExists(
        start: testWorkout.start.getOrElse(() => DateTime.now()),
      ));

      verify(mockJsonLocalDataSource.writeWorkout(testWorkout));

      verifyNoMoreInteractions(mockJsonLocalDataSource);
    });
  });

  group('updateWorkout', () {
    test('throws CacheException if workout does not already exist', () async {
      whenWorkoutDoesNotExist();

      final call = localDataSource.updateWorkout;

      await expectLater(() async => await call(testWorkout),
          throwsA(TypeMatcher<CacheException>()));

      verify(mockJsonLocalDataSource.workoutExists(
        start: testWorkout.start.getOrElse(() => DateTime.now()),
      ));

      verifyNoMoreInteractions(mockJsonLocalDataSource);
    });

    test('throws CacheException if writing fails', () async {
      whenWorkoutExists();

      when(mockJsonLocalDataSource.writeWorkout(any))
          .thenThrow(FileSystemException());

      final call = localDataSource.updateWorkout;

      await expectLater(() async => await call(testWorkout),
          throwsA(TypeMatcher<CacheException>()));

      verify(mockJsonLocalDataSource.workoutExists(
        start: testWorkout.start.getOrElse(() => DateTime.now()),
      ));

      verify(mockJsonLocalDataSource.writeWorkout(testWorkout));

      verifyNoMoreInteractions(mockJsonLocalDataSource);
    });

    test('returns saved workout if everything succeeded', () async {
      // setup mock to pretend workout already exists
      whenWorkoutExists();

      when(mockJsonLocalDataSource.writeWorkout(any))
          .thenAnswer((_) async => Future.value(testWorkout));

      final result = await localDataSource.updateWorkout(testWorkout);

      expect(result, testWorkout);

      verify(mockJsonLocalDataSource.workoutExists(
        start: testWorkout.start.getOrElse(() => DateTime.now()),
      ));

      verify(mockJsonLocalDataSource.writeWorkout(testWorkout));

      verifyNoMoreInteractions(mockJsonLocalDataSource);
    });
  });
}
