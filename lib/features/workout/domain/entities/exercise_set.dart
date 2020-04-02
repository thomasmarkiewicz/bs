import 'package:bodysculpting/features/workout/domain/entities/rep.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ExerciseSet extends Equatable {
  final String exerciseId;
  final String exerciseName;
  final List<Rep> sets;

  @override
  List<Object> get props => [exerciseId, exerciseName, sets];

  ExerciseSet({
    @required this.exerciseId,
    @required this.exerciseName,
    @required this.sets,
  });

  // TODO: write a test for this
  ExerciseSet toggleRep(int repIndex) {
    final List<Rep> updatedSets = sets
        .asMap()
        .map((index, rep) {
          final Option<int> reps = (index == repIndex)
              ? rep.reps.fold(
                  () => some(rep.targetReps),
                  (r) => (r - 1 >= 0) ? some(r - 1) : none(),
                )
              : rep.reps;
          return MapEntry(
            index,
            Rep(
              targetReps: rep.targetReps,
              targetRest: rep.targetRest,
              targetWeight: rep.targetWeight,
              reps: reps,
            ),
          );
        })
        .values
        .toList();

    return ExerciseSet(
      exerciseId: this.exerciseId,
      exerciseName: this.exerciseName,
      sets: updatedSets,
    );
  }
}
