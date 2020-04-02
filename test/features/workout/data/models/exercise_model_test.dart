import 'dart:convert';

import 'package:bodysculpting/features/workout/data/models/exercise_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/exercise.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testExerciseModel = ExerciseModel(id: '1', name: 'Bench Press');

  test('is a subclass of Exercise entity', () async {
    expect(testExerciseModel, isA<Exercise>());
  });

  group('fromJson', () {
    test('returns a valid model when JSON is complete', () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('exercise_model.json'));
      final result = ExerciseModel.fromJson(jsonMap);
      expect(result, testExerciseModel);
    });
  });

  group('toJson', () {
    test('returns a JSON map containing the proper data', () async {
      final result = testExerciseModel.toJson();
      final expectedMap = {"id": "1", "name": "Bench Press"};
      expect(result, expectedMap);
    });
  });
}
