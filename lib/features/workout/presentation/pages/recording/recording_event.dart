part of 'recording_bloc.dart';

abstract class RecordingEvent extends Equatable {
  const RecordingEvent();
}

class ChangeTemplate extends RecordingEvent {
  final Workout template;

  @override
  List<Object> get props => [template];

  ChangeTemplate({@required this.template});
}

class RecordReps extends RecordingEvent {
  final int supersetIndex;
  final int exerciseSetIndex;
  final int repIndex;

  @override
  List<Object> get props => [supersetIndex, exerciseSetIndex, repIndex];

  RecordReps({
    @required this.supersetIndex,
    @required this.exerciseSetIndex,
    @required this.repIndex,
  });
}

class TargetWeightChanged extends RecordingEvent {
  final int supersetIndex;
  final int exerciseSetIndex;
  final int value;

  TargetWeightChanged({
    @required this.supersetIndex,
    @required this.exerciseSetIndex,
    @required this.value,
  });

  @override
  List<Object> get props => [supersetIndex, exerciseSetIndex, value];
}

class WorkoutFinished extends RecordingEvent {
  @override
  List<Object> get props => null;
}

class WorkoutDeleted extends RecordingEvent {
  @override
  List<Object> get props => null;
}
