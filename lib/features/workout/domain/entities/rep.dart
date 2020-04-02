import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Rep extends Equatable {
  final int targetReps;
  final int targetRest;
  final int targetWeight;
  final Option<int> reps;
  final Option<int> weight;

  @override
  List<Object> get props => [targetReps, targetRest, targetWeight, reps, weight];

  Rep({
    @required this.targetReps,
    @required this.targetRest,
    @required this.targetWeight,
    Option<int> reps,
    Option<int> weight,
  }) : this.reps = reps ?? none(),
       this.weight = weight ?? none();
}
