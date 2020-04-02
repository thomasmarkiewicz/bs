import 'package:bodysculpting/features/workout/domain/entities/rep.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class RepModel extends Rep {
  RepModel({
    @required int targetReps,
    @required int targetRest,
    @required int targetWeight,
    Option<int> reps,
    Option<int> weight,
  }) : super(
          targetReps: targetReps,
          targetRest: targetRest,
          targetWeight: targetWeight,
          reps: reps,
          weight: weight,
        );

  factory RepModel.from(Rep rep) {
    return RepModel(
      targetReps: rep.targetReps,
      targetRest: rep.targetRest,
      targetWeight: rep.targetWeight,
      reps: rep.reps,
      weight: rep.weight,
    );
  }

  factory RepModel.fromJson(Map<String, dynamic> json) {
    return RepModel(
      targetReps: json['target_reps'],
      targetRest: json['target_rest'],
      targetWeight: json['target_weight'],
      reps: json.containsKey('reps') ? some(json['reps']) : none(),
      weight: json.containsKey('weight') ? some(json['weight']) : none(),
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'target_reps': targetReps,
      'target_rest': targetRest,
      'target_weight': targetWeight,
    };

    reps.fold(
      () => {},
      (r) => {
        map.addAll({
          'reps': r,
        })
      },
    );

    weight.fold(
      () => {},
      (w) => {
        map.addAll({
          'weight': w,
        })
      },
    );

    return map;
  }
}
