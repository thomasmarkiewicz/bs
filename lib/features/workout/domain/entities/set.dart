import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Set extends Equatable {
  final int targetReps;
  final int targetRest;
  final Option<int> reps;
  final Option<int> weight;

  @override
  List<Object> get props => [targetReps, targetRest, reps, weight];

  Set({
    @required this.targetReps,
    @required this.targetRest,
    Option<int> reps,
    Option<int> weight,
  })  : this.reps = reps ?? none(),
        this.weight = weight ?? none();
}
