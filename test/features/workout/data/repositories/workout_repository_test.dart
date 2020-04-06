import 'package:bodysculpting/core/error/exceptions.dart';
import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/features/workout/data/datasources/abstract_workout_local_data_source.dart';
import 'package:bodysculpting/features/workout/data/models/exercise_set_model.dart';
import 'package:bodysculpting/features/workout/data/models/rep_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/data/repositories/workout_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocalDataSource extends Mock
    implements AbstractWorkoutLocalDataSource {}

void main() {
  WorkoutRepository repository;
  MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = WorkoutRepository(localDataSource: mockLocalDataSource);
  });

  final testWorkout = WorkoutModel(
    activity: Activity.lift,
    name: 'Barbbell Lifts 3x10 A',
    description: some('Squat, Bench, Press'),
    start: some(DateTime(2020, 4, 25, 17, 30, 00)),
    end: some(DateTime(2020, 4, 25, 18, 00, 00)),
    summary: some("Optional summary"),
    supersets: [
      [
        ExerciseSetModel(exerciseId: '1', exerciseName: 'Squats', sets: [
          RepModel(
              targetReps: 10,
              targetRest: 180,
              targetWeight: 135,
              reps: some(10),
              weight: some(135)),
          RepModel(
              targetReps: 10,
              targetRest: 180,
              targetWeight: 135,
              reps: some(10),
              weight: some(135)),
          RepModel(
              targetReps: 10,
              targetRest: 180,
              targetWeight: 135,
              reps: some(10),
              weight: some(135)),
        ])
      ],
      [
        ExerciseSetModel(exerciseId: '1', exerciseName: 'Squats', sets: [
          RepModel(
              targetReps: 10,
              targetRest: 180,
              targetWeight: 135,
              reps: some(9),
              weight: some(135)),
          RepModel(
              targetReps: 10,
              targetRest: 180,
              targetWeight: 135,
              reps: some(9),
              weight: some(135)),
          RepModel(
              targetReps: 10,
              targetRest: 180,
              targetWeight: 135,
              reps: some(8),
              weight: some(130)),
        ]),
        ExerciseSetModel(exerciseId: '2', exerciseName: 'Bench Press', sets: [
          RepModel(
            targetReps: 10,
            targetRest: 180,
            targetWeight: 135,
            reps: none(),
            weight: none(),
          ),
          RepModel(
            targetReps: 10,
            targetRest: 180,
            targetWeight: 135,
            reps: none(),
            weight: none(),
          ),
          RepModel(
            targetReps: 10,
            targetRest: 180,
            targetWeight: 135,
            reps: none(),
            weight: none(),
          ),
        ]),
      ]
    ],
  );

  group('createWorkout', () {
    test('returns created workout when local data source saves is successfully',
        () async {
      // setup
      when(mockLocalDataSource.createWorkout(any))
          .thenAnswer((_) async => Future.value(testWorkout));

      // test
      var result = await repository.createWorkout(testWorkout);

      // check
      expect(result, Right(testWorkout));
      verify(mockLocalDataSource.createWorkout(testWorkout));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('returns CacheFailure when local data source throws a CacheException',
        () async {
      // setup
      when(mockLocalDataSource.createWorkout(any)).thenThrow(CacheException());

      // test
      var result = await repository.createWorkout(testWorkout);

      // check
      expect(result, Left(CacheFailure()));
      verify(mockLocalDataSource.createWorkout(testWorkout));
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });

  group('updateWorkout', () {
    test('returns updated workout when local data source saves is successfully',
        () async {
      // setup
      when(mockLocalDataSource.updateWorkout(any))
          .thenAnswer((_) async => Future.value(testWorkout));

      // test
      var result = await repository.updateWorkout(testWorkout);

      // check
      expect(result, Right(testWorkout));
      verify(mockLocalDataSource.updateWorkout(testWorkout));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('returns CacheFailure when local data source throws a CacheException',
        () async {
      // setup
      when(mockLocalDataSource.updateWorkout(any)).thenThrow(CacheException());

      // test
      var result = await repository.updateWorkout(testWorkout);

      // check
      expect(result, Left(CacheFailure()));
      verify(mockLocalDataSource.updateWorkout(testWorkout));
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });
}
