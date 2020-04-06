part of 'recording_bloc.dart';

abstract class RecordingState extends Equatable {
  const RecordingState();
}

class Initial extends RecordingState {
  @override
  List<Object> get props => [];
}

class Ready extends RecordingState {
  final Workout workout;

  @override
  List<Object> get props => [workout];

  Ready(this.workout);
}

class Active extends RecordingState {
  final Workout workout;

  @override
  List<Object> get props => [workout];

  Active(this.workout);
}

class Updating extends RecordingState {
  final Workout workout;

  @override
  List<Object> get props => [workout];

  Updating(this.workout);
}

class Finished extends RecordingState {
  final Workout workout;

  @override
  List<Object> get props => [workout];

  Finished(this.workout);
}

class Archived extends RecordingState {
  final Workout workout;

  @override
  List<Object> get props => [workout];

  Archived(this.workout);
}

class Deleted extends RecordingState {
  final Workout workout;

  @override
  List<Object> get props => [workout];

  Deleted(this.workout);
}
