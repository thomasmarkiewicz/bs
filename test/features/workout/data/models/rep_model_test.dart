import 'package:bodysculpting/features/workout/data/models/rep_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/rep.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final testRepModel = RepModel(
    targetReps: 5,
    targetRest: 180,
    targetWeight: 135,
    reps: some(4),
    weight: some(135),
  );

  final testRepModelRequiredFieldsOnly = RepModel(
    targetReps: 10,
    targetRest: 180,
    targetWeight: 20,
    reps: none(),
    weight: none(),
  );

  test('is a subclass of Rep', () async {
    expect(testRepModel, isA<Rep>());
  });

  group('fromJson', () {
    test('returns a valid model when JSON is good', () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('rep_model.json'));
      final result = RepModel.fromJson(jsonMap);
      expect(result, testRepModel);
    });
    test('returns a valid model when JSON contains required fields only', () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('rep_model_required_only.json'));
      final result = RepModel.fromJson(jsonMap);
      expect(result, testRepModelRequiredFieldsOnly);
    });
  });

  group('toJson', () {
    test('return a JSON map containing all the fields', () async {
      final result = testRepModel.toJson();
      final expectedMap = {
        "target_reps": 5,
        "target_rest": 180,
        "target_weight": 135,
        "reps": 4,
        "weight": 135,
      };
      expect(result, expectedMap);
    });

    test('return a JSON map containing only required fields', () async {
      final result = testRepModelRequiredFieldsOnly.toJson();
      final expectedMap = {
        "target_reps": 10,
        "target_rest": 180,
        "target_weight": 20,
      };
      expect(result, expectedMap);
    });
  });
}
