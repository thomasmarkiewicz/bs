import 'dart:io';
import 'package:bodysculpting/features/workout/data/datasources/json_local_data_source.dart';
import 'package:bodysculpting/features/workout/data/models/document_model.dart';
import 'package:bodysculpting/features/workout/data/models/exercise_model.dart';
import 'package:bodysculpting/features/workout/data/models/exercise_set_model.dart';
import 'package:bodysculpting/features/workout/data/models/set_model.dart';
import 'package:bodysculpting/features/workout/data/models/units_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final jsonLocalDataSource = JsonLocalDataSource();

  final testWorkoutFinished = WorkoutModel(
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

  final testWorkoutActive = WorkoutModel(
    name: testWorkoutFinished.name,
    activity: testWorkoutFinished.activity,
    start: testWorkoutFinished.start,
    units: UnitsModel(weight: "lb", distance: "km"),
    end: none(),
    description: testWorkoutFinished.description,
    summary: testWorkoutFinished.summary,
    supersets: testWorkoutFinished.supersets,
  );

  setUpAll(() async {
    // Create a temporary directory.
    final directory = await Directory.systemTemp.createTemp();

    // Mock out the MethodChannel for the path_provider plugin.
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      // If you're getting the apps documents directory, return the path to the
      // temp directory on the test environment instead.
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return directory.path;
      }
      return null;
    });
  });

  group('readDocument', () {
    test("always returns DocumentModel even when it doesn't exist initially",
        () async {
      final result = await jsonLocalDataSource.readDocument();
      expect(result, isA<DocumentModel>());
    });
  });

  group('writeDocument', () {
    test("writes provided DocumentModel and reads the same model back",
        () async {
      final document = await jsonLocalDataSource.readDocument();
      document.exercises
          .add(ExerciseModel(id: '123456', name: 'Test Exercise'));
      await jsonLocalDataSource.writeDocument(document);
      final savedDocument = await jsonLocalDataSource.readDocument();
      expect(document, savedDocument);
    });
  });

  group('writeWorkout and readWorkout', () {
    test('writes a finished Workout and returns the same model back', () async {
      final result =
          await jsonLocalDataSource.writeWorkout(testWorkoutFinished);
      expect(result, testWorkoutFinished);
    });

    test('reads a written finished Workout and returns the same model back',
        () async {
      await jsonLocalDataSource.writeWorkout(testWorkoutFinished);
      final result = await jsonLocalDataSource.readWorkout(
        start: testWorkoutFinished.start.getOrElse(() => DateTime.now()),
        end: testWorkoutFinished.end,
      );
      expect(result, testWorkoutFinished);
    });

    test('reads a written active Workout and returns the same model back',
        () async {
      await jsonLocalDataSource.writeWorkout(testWorkoutActive);
      final result = await jsonLocalDataSource.readWorkout(
        start: testWorkoutActive.start.getOrElse(() => DateTime.now()),
        end: testWorkoutActive.end,
      );
      expect(result, testWorkoutActive);
    });

    test('updates a written active Workout and returns the updated model back',
        () async {
      await jsonLocalDataSource.writeWorkout(testWorkoutActive);

      final testUpdatedWorkoutActive = WorkoutModel(
        name: testWorkoutActive.name,
        activity: testWorkoutActive.activity,
        start: testWorkoutActive.start,
        end: none(),
        description: testWorkoutActive.description,
        units: UnitsModel(weight: "lb", distance: "km"),
        summary: some("This is some different summary changed from original"),
        supersets: testWorkoutActive.supersets,
      );

      await jsonLocalDataSource.writeWorkout(testUpdatedWorkoutActive);

      final result = await jsonLocalDataSource.readWorkout(
        start: testWorkoutActive.start.getOrElse(() => DateTime.now()),
        end: testWorkoutActive.end,
      );
      expect(result, testUpdatedWorkoutActive);
    });
  });
}
