import 'package:bodysculpting/features/workout/domain/entities/set.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ExerciseSet extends Equatable {
  final String exerciseId;
  final String exerciseName;
  final int targetWeight;
  final List<Set> sets;

  @override
  List<Object> get props => [exerciseId, exerciseName, sets];

  ExerciseSet({
    @required this.exerciseId,
    @required this.exerciseName,
    @required this.targetWeight,
    @required this.sets,
  });

  // TODO: write a test for this
  ExerciseSet toggleRep(int repIndex) {
    final List<Set> updatedSets = sets
        .asMap()
        .map((index, set) {
          final Option<int> reps = (index == repIndex)
              ? set.reps.fold(
                  () => some(set.targetReps),
                  (r) => (r - 1 >= 0) ? some(r - 1) : none(),
                )
              : set.reps;
          return MapEntry(
            index,
            Set(
              targetReps: set.targetReps,
              targetRest: set.targetRest,
              reps: reps,
              weight: (index == repIndex) ? some(this.targetWeight) : set.weight,
            ),
          );
        })
        .values
        .toList();

    return ExerciseSet(
      exerciseId: this.exerciseId,
      exerciseName: this.exerciseName,
      targetWeight: this.targetWeight,
      sets: updatedSets,
    );
  }

  // TODO: write a test for this
  ExerciseSet updateTargetWeight(int weight) {
    return ExerciseSet(
      exerciseId: this.exerciseId,
      exerciseName: this.exerciseName,
      targetWeight: weight,
      sets: this.sets,
    );
  }
}
