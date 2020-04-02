import 'dart:convert';

import 'package:bodysculpting/features/workout/data/models/exercise_set_model.dart';
import 'package:bodysculpting/features/workout/data/models/rep_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/exercise_set.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testExerciseSetModel = ExerciseSetModel(
    exerciseId: '1',
    exerciseName: 'Bench Press',
    sets: [
      RepModel(
        targetReps: 5,
        targetRest: 180,
        targetWeight: 135,
        reps: some(5),
        weight: some(135),
      ),
      RepModel(
        targetReps: 5,
        targetRest: 180,
        targetWeight: 135,
        reps: some(4),
        weight: some(130),
      ),
      RepModel(
        targetReps: 5,
        targetRest: 180,
        targetWeight: 135,
        reps: none(),
        weight: none(),
      ),
    ],
  );

  final testExerciseSetModel_EmptySets = ExerciseSetModel(
    exerciseId: '2',
    exerciseName: 'Dumbbell Rows',
    sets: [],
  );

  test('is a subclass of ExerciseSet entity', () async {
    expect(testExerciseSetModel, isA<ExerciseSet>());
  });

  group('fromJson', () {
    test('returns a valid model when JSON is good', () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('exercise_set_model.json'));
      final result = ExerciseSetModel.fromJson(jsonMap);
      expect(result, testExerciseSetModel);
    });

    test('returns a valid model when JSON has empty sets', () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('exercise_set_model_empty_sets.json'));
      final result = ExerciseSetModel.fromJson(jsonMap);
      expect(result, testExerciseSetModel_EmptySets);
    });
  });

  group('toJson', () {
    test('returns a JSON map containing the proper data', () async {
      final result = testExerciseSetModel.toJson();
      final expectedMap = {
        "exercise_id": "1",
        "exercise_name": "Bench Press",
        "sets": [
          {"target_reps": 5, "target_rest": 180, "target_weight": 135, "reps": 5, "weight": 135},
          {"target_reps": 5, "target_rest": 180, "target_weight": 135, "reps": 4, "weight": 130},
          {"target_reps": 5, "target_rest": 180, "target_weight": 135},
        ]
      };
      expect(result, expectedMap);
    });

    test('returns a JSON map containing the proper data when sets are empty',
        () async {
      final result = testExerciseSetModel_EmptySets.toJson();
      final expectedMap = {
        "exercise_id": "2",
        "exercise_name": "Dumbbell Rows",
        "sets": []
      };
      expect(result, expectedMap);
    });
  });
}
