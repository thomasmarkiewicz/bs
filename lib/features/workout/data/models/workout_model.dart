import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_base.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import 'exercise_set_model.dart';

class WorkoutModel extends Workout {
  WorkoutModel({
    @required String name,
    @required Activity activity,
    Option<String> description,
    Option<DateTime> start,
    Option<DateTime> end,
    Option<String> summary,
    @required List<List<ExerciseSetModel>> supersets,
  }) : super(
          name: name,
          activity: activity,
          description: description,
          start: start,
          end: end,
          summary: summary,
          supersets: supersets,
        );

  factory WorkoutModel.from(Workout workout) {
    final supersetList = List<List<ExerciseSetModel>>();

    if (workout.supersets != null) {
      workout.supersets.forEach((ss) {
        final exerciseSetModelList = List<ExerciseSetModel>.from(
            ss.map((es) => ExerciseSetModel.from(es)));
        supersetList.add(exerciseSetModelList);
      });
    }

    return WorkoutModel(
      name: workout.name,
      activity: workout.activity,
      description: workout.description,
      start: workout.start,
      end: workout.end,
      summary: workout.summary,
      supersets: supersetList,
    );
  }

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    final supersets = json['supersets'] as List;
    final supersetList = List<List<ExerciseSetModel>>();

    if (supersets != null) {
      supersets.forEach((ss) {
        final exerciseSetModelList = List<ExerciseSetModel>.from(
            ss.map((es) => ExerciseSetModel.fromJson(es)));
        supersetList.add(exerciseSetModelList);
      });
    }

    return WorkoutModel(
      name: json['name'],
      activity: Activity.values
          .firstWhere((e) => e.toString() == 'Activity.' + json['activity']),
      description:
          json.containsKey('description') ? some(json['description']) : none(),
      start: json.containsKey('start')
          ? some(DateTime.parse(json['start']))
          : none(),
      end: json.containsKey('end') ? some(DateTime.parse(json['end'])) : none(),
      summary: json.containsKey('summary') ? some(json['summary']) : none(),
      supersets: supersetList,
    );
  }

  Map<String, dynamic> toJson() {
    final supersets = List<List<Map>>();
    if (this.supersets != null) {
      this.supersets.forEach((ss) {
        final superset =
            List.of(ss.map((s) => (s as ExerciseSetModel).toJson()));
        supersets.add(superset);
      });
    }

    final map = {
      'name': name,
      'activity': describeEnum(activity),
      'description': description.getOrElse(() => ''),
      'supersets': supersets,
    };

    start.fold(
      () => {},
      (s) => {
        map.addAll({
          'start': s.toIso8601String(),
        })
      },
    );

    end.fold(
      () => {},
      (e) => {
        map.addAll({
          'end': e.toIso8601String(),
        })
      },
    );

    summary.fold(
      () => {},
      (s) => {
        map.addAll({
          'summary': s,
        })
      },
    );

    return map;
  }
}
