import 'package:bodysculpting/features/workout/domain/entities/workout_base.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'exercise_set.dart';

// A workout is identified by its 'start' DateTime (PK)
// There can exist only one workout that starts at a specific time
class Workout extends WorkoutSummary {
  final List<List<ExerciseSet>> supersets;

  @override
  List<Object> get props => [supersets];

  Workout({
    @required String name,
    @required Activity activity,
    Option<String> description,
    Option<DateTime> start,
    Option<DateTime> end,
    Option<String> summary,
    @required this.supersets,
  }) : super(
          name: name,
          activity: activity,
          description: description,
          start: start,
          end: end,
          summary: summary,
        );

  Workout started() {
    return Workout(
      name: this.name,
      activity: this.activity,
      description: this.description,
      start: some(DateTime.now()),
      end: this.end,
      summary: this.summary,
      supersets: supersets,
    );
  }

  Workout finished() {
    return Workout(
      name: this.name,
      activity: this.activity,
      description: this.description,
      start: this.start,
      end: some(DateTime.now()),
      summary: this.summary,
      supersets: supersets,
    );
  }

  // TODO: write a test for this
  Workout updateReps({
    @required int supersetIndex,
    @required int exerciseSetIndex,
    @required int repIndex,
  }) {
    final supersets = List<List<ExerciseSet>>();
    if (this.supersets != null) {
      this.supersets.asMap().forEach((ii, ss) {
        if (ii == supersetIndex) {
          final superset = List.of(ss
              .asMap()
              .map((i, s) => (i == exerciseSetIndex)
                  ? MapEntry(i, s.toggleRep(repIndex))
                  : MapEntry(i, s))
              .values);
          supersets.add(superset);
        } else {
          supersets.add(ss);
        }
      });
    }

    return Workout(
      name: this.name,
      activity: this.activity,
      description: this.description,
      start: this.start.orElse(() => some(DateTime.now())),
      end: this.end,
      summary: this.summary,
      supersets: supersets,
    );
  }
}
