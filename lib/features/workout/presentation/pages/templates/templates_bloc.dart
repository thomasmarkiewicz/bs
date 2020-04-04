import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/usecases/get_workout_templates.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'templates_event.dart';
part 'templates_state.dart';

const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_ACTIVITY_FAILURE_MESSAGE =
    'Invalid Activity - must be a one of: lift, swim, bike, run, other';

class TemplatesBloc extends Bloc<TemplatesEvent, TemplatesState> {
  final GetWorkoutTemplates getWorkoutTemplates;

  TemplatesBloc({@required GetWorkoutTemplates getWorkoutTemplates})
      : assert(getWorkoutTemplates != null),
        this.getWorkoutTemplates = getWorkoutTemplates;

  @override
  TemplatesState get initialState => Empty();

  @override
  Stream<TemplatesState> mapEventToState(
    TemplatesEvent event,
  ) async* {
    if (event is GetTemplates) {
      yield* _getWorkoutTemplates(event);
    }
  }

  Stream<TemplatesState> _getWorkoutTemplates(GetTemplates event) async* {
    yield Loading();
    final result = await getWorkoutTemplates(Params(activity: event.activity));
    yield result.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (templates) => Loaded(templates),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
