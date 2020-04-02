import 'package:bodysculpting/features/workout/domain/entities/workout_base.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class WorkoutSummary extends WorkoutBase {
  final Option<DateTime> start; // primary-key
  final Option<DateTime> end;
  final Option<String> summary;

  @override
  List<Object> get props => [start, end, summary];

  WorkoutSummary({
    @required String name,
    @required Activity activity,
    Option<String> description,
    Option<DateTime> start,
    Option<DateTime> end,
    Option<String> summary,
  })  : this.start = start ?? none(),
        this.end = end ?? none(),
        this.summary = summary ?? none(),
        super(name: name, activity: activity, description: description);

  bool isActive() => start.isSome() && end.isNone();
  bool isFinished() => start.isSome() && end.isSome();
}
