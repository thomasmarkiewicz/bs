import 'package:bodysculpting/features/workout/domain/entities/set.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class SetModel extends Set {
  SetModel({
    @required int targetReps,
    @required int targetRest,
    Option<int> reps,
    Option<int> weight,
  }) : super(
          targetReps: targetReps,
          targetRest: targetRest,
          reps: reps,
          weight: weight,
        );

  factory SetModel.from(Set rep) {
    return SetModel(
      targetReps: rep.targetReps,
      targetRest: rep.targetRest,
      reps: rep.reps,
      weight: rep.weight,
    );
  }

  factory SetModel.fromJson(Map<String, dynamic> json) {
    return SetModel(
      targetReps: json['target_reps'],
      targetRest: json['target_rest'],
      reps: json.containsKey('reps') ? some(json['reps']) : none(),
      weight: json.containsKey('weight') ? some(json['weight']) : none(),
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'target_reps': targetReps,
      'target_rest': targetRest,
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
