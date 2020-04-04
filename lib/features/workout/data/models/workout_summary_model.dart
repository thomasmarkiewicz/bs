import 'package:bodysculpting/features/workout/data/models/units_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class WorkoutSummaryModel extends WorkoutSummary {
  WorkoutSummaryModel({
    @required String name,
    @required Activity activity,
    @required UnitsModel units,
    Option<String> description,
    Option<DateTime> start,
    Option<DateTime> end,
    Option<String> summary,
  }) : super(
          name: name,
          activity: activity,
          units: units,
          description: description,
          start: start,
          end: end,
          summary: summary,
        );

  factory WorkoutSummaryModel.from(WorkoutSummary workoutSummary) {
    return WorkoutSummaryModel(
      name: workoutSummary.name,
      activity: workoutSummary.activity,
      units: UnitsModel.from(workoutSummary.units),
      description: workoutSummary.description,
      start: workoutSummary.start,
      end: workoutSummary.end,
      summary: workoutSummary.summary,
    );
  }

  factory WorkoutSummaryModel.fromJson(Map<String, dynamic> json) {
    return WorkoutSummaryModel(
      name: json['name'],
      activity: Activity.values
          .firstWhere((e) => e.toString() == 'Activity.' + json['activity']),
      units: UnitsModel.fromJson(json['units']),
      description:
          json.containsKey('description') ? some(json['description']) : none(),
      start: json.containsKey('start')
          ? some(DateTime.parse(json['start']))
          : none(),
      end: json.containsKey('end') ? some(DateTime.parse(json['end'])) : none(),
      summary: json.containsKey('summary') ? some(json['summary']) : none(),
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'name': name,
      'activity': describeEnum(activity),
      'units': (units as UnitsModel).toString(),
      'description': description.getOrElse(() => ''),
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
