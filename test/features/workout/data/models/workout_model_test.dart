import 'dart:convert';
import 'package:bodysculpting/features/workout/data/models/exercise_set_model.dart';
import 'package:bodysculpting/features/workout/data/models/set_model.dart';
import 'package:bodysculpting/features/workout/data/models/units_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
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

  test('is a subclass of Workout entity', () async {
    expect(testWorkout, isA<Workout>());
  });

  group('fromJson', () {
    test('returns a valid model when JSON has one or more sets in supersets',
        () {
      final Map<String, dynamic> jsonMap = json.decode(fixture('workout.json'));
      final result = WorkoutModel.fromJson(jsonMap);
      expect(result, testWorkout);
    });
  });

  group('toJson', () {
    test('returns a JSON map containing the proper data', () async {
      final result = testWorkout.toJson();
      final expectedMap = {
        "activity": "lift",
        "name": "Barbbell Lifts 3x10 A",
        "description": "Squat, Bench, Press",
        "units": {
          "weight": "lb",
          "distance": "mi"
        },
        "start": "2020-04-25T17:30:00.000",
        "end": "2020-04-25T18:00:00.000",
        "summary": "Optional summary",
        "supersets": [
          [
            {
              "exercise_id": "1",
              "exercise_name": "Squats",
              "target_weight": 135,
              "sets": [
                {
                  "target_reps": 10,
                  "target_rest": 180,
                  "reps": 10,
                  "weight": 135
                },
                {
                  "target_reps": 10,
                  "target_rest": 180,
                  "reps": 10,
                  "weight": 135
                },
                {
                  "target_reps": 10,
                  "target_rest": 180,
                  "reps": 10,
                  "weight": 135
                }
              ]
            }
          ],
          [
            {
              "exercise_id": "1",
              "exercise_name": "Squats",
              "target_weight": 135,
              "sets": [
                {
                  "target_reps": 10,
                  "target_rest": 180,
                  "reps": 9,
                  "weight": 135
                },
                {
                  "target_reps": 10,
                  "target_rest": 180,
                  "reps": 9,
                  "weight": 135
                },
                {
                  "target_reps": 10,
                  "target_rest": 180,
                  "reps": 8,
                  "weight": 130
                }
              ]
            },
            {
              "exercise_id": "2",
              "exercise_name": "Bench Press",
              "target_weight": 135,
              "sets": [
                {"target_reps": 10, "target_rest": 180},
                {"target_reps": 10, "target_rest": 180},
                {"target_reps": 10, "target_rest": 180}
              ]
            }
          ]
        ]
      };
      expect(result, expectedMap);
    });
  });
}
