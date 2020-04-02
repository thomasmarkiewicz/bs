import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum Activity { swim, bike, run, lift, other }

class WorkoutBase extends Equatable {
  final String name;
  final Activity activity;
  final Option<String> description;

  @override
  List<Object> get props => [name, activity, description];

  WorkoutBase({
    @required this.name,
    @required this.activity,
    Option<String> description,
  }) : this.description = description ?? none();
}
