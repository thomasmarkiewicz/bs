import 'dart:convert';

import 'package:bodysculpting/features/workout/data/models/document_model.dart';
import 'package:bodysculpting/features/workout/data/models/exercise_model.dart';
import 'package:bodysculpting/features/workout/data/models/exercise_set_model.dart';
import 'package:bodysculpting/features/workout/data/models/set_model.dart';
import 'package:bodysculpting/features/workout/data/models/units_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testDocument = DocumentModel(
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
          units: UnitsModel(weight: 'lb', distance: 'mi'),
          supersets: [
            [
              ExerciseSetModel(
                  exerciseId: "0537cd19644c",
                  exerciseName: "Squats",
                  targetWeight: 45,
                  sets: [
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180)
                  ])
            ],
            [
              ExerciseSetModel(
                  exerciseId: "33871bf6de60",
                  exerciseName: "Bench Press",
                  targetWeight: 45,
                  sets: [
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180)
                  ])
            ],
            [
              ExerciseSetModel(
                  exerciseId: "ca1240b16dab",
                  exerciseName: "Deadlifts",
                  targetWeight: 45,
                  sets: [SetModel(targetReps: 5, targetRest: 180)])
            ]
          ]),
      WorkoutModel(
          activity: Activity.lift,
          name: "Barbbell Lifts 5x5 B",
          description: some("Squat, Shoulder Press, Rows"),
          units: UnitsModel(weight: 'lb', distance: 'mi'),
          supersets: [
            [
              ExerciseSetModel(
                  exerciseId: "0537cd19644c",
                  exerciseName: "Squats",
                  targetWeight: 45,
                  sets: [
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180)
                  ])
            ],
            [
              ExerciseSetModel(
                  exerciseId: "7eef10e8aaed",
                  exerciseName: "Shoulder Press",
                  targetWeight: 45,
                  sets: [
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180)
                  ])
            ],
            [
              ExerciseSetModel(
                  exerciseId: "056672996981",
                  exerciseName: "Rows",
                  targetWeight: 45,
                  sets: [
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180),
                    SetModel(targetReps: 5, targetRest: 180)
                  ])
            ]
          ]),
    ],
  );

  group('fromJson', () {
    test('returns a valid model when JSON is good', () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('document_model.json'));
      final result = DocumentModel.fromJson(jsonMap);
      expect(result, testDocument);
    });
  });

  group('toJson', () {
    test('returns a JSON map containing the proper data', () async {
      final result = testDocument.toJson();
      final expectedMap = {
        "version": "0.0.1",
        "sync_counter": 0,
        "exercises": [
          {"id": "0537cd19644c", "name": "Squats"},
          {"id": "33871bf6de60", "name": "Bench Press"},
          {"id": "7eef10e8aaed", "name": "Shoulder Press"},
          {"id": "056672996981", "name": "Rows"},
          {"id": "ca1240b16dab", "name": "Deadlifts"}
        ],
        "workout_templates": [
          {
            "activity": "lift",
            "name": "Barbbell Lifts 5x5 A",
            "description": "Squat, Bench, Deadlift",
            "units": {
              "weight": "lb",
              "distance": "mi"
            },
            "supersets": [
              [
                {
                  "exercise_id": "0537cd19644c",
                  "exercise_name": "Squats",
                  "target_weight": 45,
                  "sets": [
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180}
                  ]
                }
              ],
              [
                {
                  "exercise_id": "33871bf6de60",
                  "exercise_name": "Bench Press",
                  "target_weight": 45,
                  "sets": [
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180}
                  ]
                }
              ],
              [
                {
                  "exercise_id": "ca1240b16dab",
                  "exercise_name": "Deadlifts",
                  "target_weight": 45,
                  "sets": [
                    {"target_reps": 5, "target_rest": 180}
                  ]
                }
              ]
            ]
          },
          {
            "activity": "lift",
            "name": "Barbbell Lifts 5x5 B",
            "description": "Squat, Shoulder Press, Rows",
            "units": {
              "weight": "lb",
              "distance": "mi"
            },
            "supersets": [
              [
                {
                  "exercise_id": "0537cd19644c",
                  "exercise_name": "Squats",
                  "target_weight": 45,
                  "sets": [
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180}
                  ]
                }
              ],
              [
                {
                  "exercise_id": "7eef10e8aaed",
                  "exercise_name": "Shoulder Press",
                  "target_weight": 45,
                  "sets": [
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180}
                  ]
                }
              ],
              [
                {
                  "exercise_id": "056672996981",
                  "exercise_name": "Rows",
                  "target_weight": 45,
                  "sets": [
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180},
                    {"target_reps": 5, "target_rest": 180}
                  ]
                }
              ]
            ]
          }
        ]
      };
      expect(result, expectedMap);
    });
  });
}
