import 'package:bodysculpting/features/workout/domain/entities/units.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum Activity { swim, bike, run, lift, other }

class WorkoutSummary extends Equatable {
  final String name;
  final Activity activity;
  final Units units;
  final Option<String> description;
  final Option<DateTime> start; // primary-key
  final Option<DateTime> end;
  final Option<String> summary;

  @override
  List<Object> get props =>
      [name, activity, units, description, start, end, summary];

  WorkoutSummary({
    @required this.name,
    @required this.activity,
    @required this.units,
    Option<String> description,
    Option<DateTime> start,
    Option<DateTime> end,
    Option<String> summary,
  })  : this.description = description ?? none(),
        this.start = start ?? none(),
        this.end = end ?? none(),
        this.summary = summary ?? none();

  bool isActive() => start.isSome() && end.isNone();
  bool isFinished() => start.isSome() && end.isSome();
}
