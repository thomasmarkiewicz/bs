part of 'templates_bloc.dart';

abstract class TemplatesState extends Equatable {
  const TemplatesState();
}

class Empty extends TemplatesState {
  @override
  List<Object> get props => [];
}

class Loading extends TemplatesState {
  @override
  List<Object> get props => [];
}

class Loaded extends TemplatesState {
  final List<Workout> workoutTemplates;

  @override
  List<Object> get props => [workoutTemplates];

  Loaded(this.workoutTemplates);
}

class Error extends TemplatesState {
  final String message;

  @override
  List<Object> get props => [message];

  Error({@required this.message});
}
