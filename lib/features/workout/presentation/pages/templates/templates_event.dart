part of 'templates_bloc.dart';

abstract class TemplatesEvent extends Equatable {
  const TemplatesEvent();
}

class GetTemplates extends TemplatesEvent {
  final Activity activity;

  @override
  List<Object> get props => [activity];

  GetTemplates(this.activity);
}
