import 'dart:async';
import 'package:bodysculpting/features/workout/domain/usecases/get_workout.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bodysculpting/features/workout/domain/usecases/get_workout_summaries.dart';
import './bloc.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final GetWorkoutSummaries getWorkoutSummaries;
  final GetWorkout getWorkout;

  WorkoutBloc({
    @required GetWorkoutSummaries getWorkoutSummaries,
    @required GetWorkout getWorkout,
  })  : assert(getWorkoutSummaries != null),
        assert(getWorkout != null),
        this.getWorkoutSummaries = getWorkoutSummaries,
        this.getWorkout = getWorkout;

  @override
  WorkoutState get initialState => Initial();

  @override
  Stream<WorkoutState> mapEventToState(
    WorkoutEvent event,
  ) async* {
    if (event is Refresh) {
      yield* _refresh(event);
    } else if (event is WorkoutSelected) {
      yield* _workoutSelected(event);
    } else if (event is ActivitySelected) {
      yield* _activitySelected(event);
    }
  }

  Stream<WorkoutState> _refresh(Refresh event) async* {
    final result = await getWorkoutSummaries(
      SummaryParams(
        start: DateTime.now().subtract(Duration(days: 365)),
        end: DateTime.now(),
      ),
    );
    yield result.fold(
      (failure) => state, // TODO: indicate failure somehow
      (summaries) => Ready(
          summaries), // TODO: NEXT - gets here but workout_page doesn't see this state change, why???
    );
  }

  Stream<WorkoutState> _workoutSelected(WorkoutSelected event) async* {
    final result = await getWorkout(
      WorkoutParams(
        start: event.workoutSummary.start.getOrElse(() => DateTime.now()),
        end: event.workoutSummary.end,
      ),
    );
    yield result.fold(
      (failure) => state, // TODO: indicate failure somehow
      (workout) => Final(workout),
    );
  }
}

Stream<WorkoutState> _activitySelected(ActivitySelected event) async* {
  yield Adding(event.activity);
}
