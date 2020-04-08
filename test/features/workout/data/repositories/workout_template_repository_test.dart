import 'package:bodysculpting/core/error/exceptions.dart';
import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/features/workout/data/datasources/abstract_workout_templates_local_data_source.dart';
import 'package:bodysculpting/features/workout/data/models/exercise_set_model.dart';
import 'package:bodysculpting/features/workout/data/models/set_model.dart';
import 'package:bodysculpting/features/workout/data/models/units_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/data/repositories/workout_template_repository.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocalDataSource extends Mock
    implements AbstractWorkoutTemplatesLocalDataSource {}

void main() {
  WorkoutTemplateRepository repository;
  MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository =
        WorkoutTemplateRepository(localDataSource: mockLocalDataSource);
  });

  group('getWorkoutTemplates', () {
    final testWorkoutTemplateList = [
      WorkoutModel(
        activity: Activity.lift,
        name: 'Barbbell Lifts 3x10 A',
        description: some('Squat, Bench, Press'),
        units: UnitsModel(weight: "lb", distance: "km"),
        supersets: [
          [
            ExerciseSetModel(exerciseId: '1', exerciseName: 'Squats', targetWeight: 45, sets: [
              SetModel(targetReps: 10, targetRest: 0),
              SetModel(targetReps: 10, targetRest: 0),
              SetModel(targetReps: 10, targetRest: 0)
            ])
          ],
          [
            ExerciseSetModel(exerciseId: '1', exerciseName: 'Squats', targetWeight: 45,  sets: [
              SetModel(targetReps: 10, targetRest: 0),
              SetModel(targetReps: 10, targetRest: 0),
              SetModel(targetReps: 10, targetRest: 0)
            ]),
            ExerciseSetModel(
                exerciseId: '2',
                exerciseName: 'Bench Press',
                targetWeight: 45, 
                sets: [
                  SetModel(targetReps: 10, targetRest: 180),
                  SetModel(targetReps: 10, targetRest: 180),
                  SetModel(targetReps: 10, targetRest: 180)
                ]),
          ]
        ],
      ),
    ];

    test(
        'returns localWorkoutTemplates when data is present in the local data source',
        () async {
      // setup
      when(mockLocalDataSource.getWorkoutTemplates(any))
          .thenAnswer((_) async => Future.value(testWorkoutTemplateList));

      // test
      var result = await repository.getWorkoutTemplates(Activity.lift);

      // check
      expect(result, Right(testWorkoutTemplateList));
      verify(mockLocalDataSource.getWorkoutTemplates(Activity.lift));
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('returns CacheFailure when local data source throws CacheException',
        () async {
      // setup
      when(mockLocalDataSource.getWorkoutTemplates(any))
          .thenThrow(CacheException());

      // test
      var result = await repository.getWorkoutTemplates(Activity.lift);

      // check
      expect(result, Left(CacheFailure()));
      verify(mockLocalDataSource.getWorkoutTemplates(Activity.lift));
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });
}
