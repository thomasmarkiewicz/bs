import 'package:bodysculpting/features/workout/data/models/set_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/set.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testSetModel = SetModel(
    targetReps: 5,
    targetRest: 180,
    reps: some(4),
    weight: some(135),
  );

  final testSetModelRequiredFieldsOnly = SetModel(
    targetReps: 10,
    targetRest: 180,
    reps: none(),
    weight: none(),
  );

  test('is a subclass of Rep', () async {
    expect(testSetModel, isA<Set>());
  });

  group('fromJson', () {
    test('returns a valid model when JSON is good', () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('set_model.json'));
      final result = SetModel.fromJson(jsonMap);
      expect(result, testSetModel);
    });
    test('returns a valid model when JSON contains required fields only', () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('set_model_required_only.json'));
      final result = SetModel.fromJson(jsonMap);
      expect(result, testSetModelRequiredFieldsOnly);
    });
  });

  group('toJson', () {
    test('return a JSON map containing all the fields', () async {
      final result = testSetModel.toJson();
      final expectedMap = {
        "target_reps": 5,
        "target_rest": 180,
        "reps": 4,
        "weight": 135,
      };
      expect(result, expectedMap);
    });

    test('return a JSON map containing only required fields', () async {
      final result = testSetModelRequiredFieldsOnly.toJson();
      final expectedMap = {
        "target_reps": 10,
        "target_rest": 180,
      };
      expect(result, expectedMap);
    });
  });
}
