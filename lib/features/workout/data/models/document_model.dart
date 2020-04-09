import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'exercise_model.dart';

class DocumentModel extends Equatable {
  final String version;
  final int syncCounter;
  final List<ExerciseModel> exercises;
  final List<WorkoutModel> workoutTemplates;

  @override
  List<Object> get props => [version, syncCounter, exercises, workoutTemplates];

  DocumentModel({
    @required this.version,
    @required this.syncCounter,
    @required this.exercises,
    @required this.workoutTemplates,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    final exercises = json['exercises'] as List;
    List<ExerciseModel> exercisesList = exercises != null
        ? exercises.map((s) => ExerciseModel.fromJson(s)).toList()
        : List<ExerciseModel>();

    final workoutTemplates = json['workout_templates'] as List;
    List<WorkoutModel> workoutTemplateList = workoutTemplates != null
        ? workoutTemplates.map((s) => WorkoutModel.fromJson(s)).toList()
        : List<ExerciseModel>();

    return DocumentModel(
      version: json['version'],
      syncCounter: json['sync_counter'],
      exercises: exercisesList,
      workoutTemplates: workoutTemplateList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map> exercises = this.exercises != null
        ? this.exercises.map((exercise) => exercise.toJson()).toList()
        : null;

    List<Map> workoutTemplates = this.workoutTemplates != null
        ? this
            .workoutTemplates
            .map((workoutTemplate) => workoutTemplate.toJson())
            .toList()
        : null;

    return {
      'version': version,
      'sync_counter': syncCounter,
      'exercises': exercises,
      'workout_templates': workoutTemplates
    };
  }
}
