import 'package:bodysculpting/features/workout/data/models/set_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/exercise_set.dart';
import 'package:meta/meta.dart';

// Set, as in weight lifting sets and reps

class ExerciseSetModel extends ExerciseSet {
  ExerciseSetModel({
    @required String exerciseId,
    @required String exerciseName,
    @required int targetWeight,
    @required List<SetModel> sets,
  }) : super(
          exerciseId: exerciseId,
          exerciseName: exerciseName,
          targetWeight: targetWeight,
          sets: sets,
        );

  factory ExerciseSetModel.from(ExerciseSet exerciseSet) {
    List<SetModel> setList = exerciseSet.sets != null
        ? exerciseSet.sets.map((s) => SetModel.from(s)).toList()
        : List<SetModel>();

    return ExerciseSetModel(
      exerciseId: exerciseSet.exerciseId,
      exerciseName: exerciseSet.exerciseName,
      targetWeight: exerciseSet.targetWeight,
      sets: setList,
    );
  }

  factory ExerciseSetModel.fromJson(Map<String, dynamic> json) {
    final sets = json['sets'] as List;
    List<SetModel> setList = sets != null
        ? sets.map((s) => SetModel.fromJson(s)).toList()
        : List<SetModel>();

    return ExerciseSetModel(
      exerciseId: json['exercise_id'],
      exerciseName: json['exercise_name'],
      targetWeight: json['target_weight'],
      sets: setList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> sets = this.sets != null
        ? this.sets.map((i) => (i as SetModel).toJson()).toList()
        : null;

    return {
      'exercise_id': exerciseId,
      'exercise_name': exerciseName,
      'target_weight': targetWeight,
      'sets': sets,
    };
  }
}
