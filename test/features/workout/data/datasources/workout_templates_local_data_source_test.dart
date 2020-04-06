import 'package:bodysculpting/features/workout/data/datasources/abstract_json_local_data_source.dart';
import 'package:bodysculpting/features/workout/data/datasources/workout_templates_local_data_source.dart';
import 'package:bodysculpting/features/workout/data/models/document_model.dart';
import 'package:bodysculpting/features/workout/data/models/exercise_model.dart';
import 'package:bodysculpting/features/workout/data/models/exercise_set_model.dart';
import 'package:bodysculpting/features/workout/data/models/rep_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_base.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockJsonLocalDataSource extends Mock
    implements AbstractJsonLocalDataSource {}

void main() {
  MockJsonLocalDataSource mockJsonLocalDataSource;
  WorkoutTemplatesLocalDataSource localDataSource;

  setUp(() {
    mockJsonLocalDataSource = MockJsonLocalDataSource();
    localDataSource = WorkoutTemplatesLocalDataSource(mockJsonLocalDataSource);
  });

  group('getWorkoutTemplates', () {
    // setup a model with one Activity.lift and also another type
    final testDocumentModel = DocumentModel(
      version: "0.0.1",
      syncCounter: 0,
      exercises: [
        ExerciseModel(id: "0537cd19644c", name: "Squats"),
        ExerciseModel(id: "33871bf6de60", name: "Bench Press"),
        ExerciseModel(id: "7eef10e8aaed", name: "Shoulder Press"),
        ExerciseModel(id: "056672996981", name: "Rows"),
        ExerciseModel(id: "ca1240b16dab", name: "Deadlifts"),
      ],
      workoutTemplates: [
        WorkoutModel(
            activity: Activity.lift,
            name: "Barbbell Lifts 5x5 A",
            description: some("Squat, Bench, Deadlift"),
            supersets: [
              [
                ExerciseSetModel(
                    exerciseId: "0537cd19644c",
                    exerciseName: "Squats",
                    sets: [
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(targetReps: 5, targetWeight: 45, targetRest: 180)
                    ])
              ],
              [
                ExerciseSetModel(
                    exerciseId: "33871bf6de60",
                    exerciseName: "Bench Press",
                    sets: [
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(targetReps: 5, targetWeight: 45, targetRest: 180)
                    ])
              ],
              [
                ExerciseSetModel(
                    exerciseId: "ca1240b16dab",
                    exerciseName: "Deadlifts",
                    sets: [
                      RepModel(targetReps: 5, targetWeight: 45, targetRest: 180)
                    ])
              ]
            ]),
        WorkoutModel(
            activity: Activity.bike,
            name: "Barbbell Lifts 5x5 B",
            description: some("Squat, Shoulder Press, Rows"),
            supersets: [
              [
                ExerciseSetModel(
                    exerciseId: "0537cd19644c",
                    exerciseName: "Squats",
                    sets: [
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(targetReps: 5, targetWeight: 45, targetRest: 180)
                    ])
              ],
              [
                ExerciseSetModel(
                    exerciseId: "7eef10e8aaed",
                    exerciseName: "Shoulder Press",
                    sets: [
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(targetReps: 5, targetWeight: 45, targetRest: 180)
                    ])
              ],
              [
                ExerciseSetModel(
                    exerciseId: "056672996981",
                    exerciseName: "Rows",
                    sets: [
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(
                          targetReps: 5, targetWeight: 45, targetRest: 180),
                      RepModel(targetReps: 5, targetWeight: 45, targetRest: 180)
                    ])
              ]
            ]),
      ],
    );

    test(
        'returns workoutTemplates for only the specified activity type when other types are present as well',
        () async {
      when(mockJsonLocalDataSource.readDocument())
          .thenAnswer((_) async => Future.value(testDocumentModel));
      final result = await localDataSource.getWorkoutTemplates(Activity.lift);
      expect(result.length, 1); // because the other activity was not 'lift'
    });

    test(
        "returns an empty workoutTemplates list when it doesn't finde any for a given activity type",
        () async {
      when(mockJsonLocalDataSource.readDocument())
          .thenAnswer((_) async => Future.value(testDocumentModel));
      final result = await localDataSource.getWorkoutTemplates(Activity.other);
      expect(result, isA<List<Workout>>());
      expect(result.length, 0);
    });
  });
}
