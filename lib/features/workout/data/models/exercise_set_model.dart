import 'package:bodysculpting/features/workout/data/models/rep_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/exercise_set.dart';
import 'package:meta/meta.dart';

// Set, as in weight lifting sets and reps

class ExerciseSetModel extends ExerciseSet {
  ExerciseSetModel({
    @required String exerciseId,
    @required String exerciseName,
    @required List<RepModel> sets,
  }) : super(exerciseId: exerciseId, exerciseName: exerciseName, sets: sets);

  factory ExerciseSetModel.from(ExerciseSet exerciseSet) {

    List<RepModel> setList = exerciseSet.sets != null
        ? exerciseSet.sets.map((s) => RepModel.from(s)).toList()
        : List<RepModel>();

    return ExerciseSetModel(
      exerciseId: exerciseSet.exerciseId,
      exerciseName: exerciseSet.exerciseName,
      sets: setList,
    );
  }

  factory ExerciseSetModel.fromJson(Map<String, dynamic> json) {
    final sets = json['sets'] as List;
    List<RepModel> setList = sets != null
        ? sets.map((s) => RepModel.fromJson(s)).toList()
        : List<RepModel>();

    return ExerciseSetModel(
      exerciseId: json['exercise_id'],
      exerciseName: json['exercise_name'],
      sets: setList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> sets = this.sets != null
        ? this.sets.map((i) => (i as RepModel).toJson()).toList()
        : null;

    return {
      'exercise_id': exerciseId,
      'exercise_name': exerciseName,
      'sets': sets,
    };
  }
}
