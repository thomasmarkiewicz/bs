import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/usecases/create_workout.dart';
import 'package:bodysculpting/features/workout/domain/usecases/finish_workout.dart';
import 'package:bodysculpting/features/workout/domain/usecases/update_target_weight.dart';
import 'package:bodysculpting/features/workout/domain/usecases/update_workout_reps.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'recording_event.dart';
part 'recording_state.dart';

class RecordingBloc extends Bloc<RecordingEvent, RecordingState> {
  final CreateWorkout createWorkout;
  final UpdateWorkoutReps updateWorkoutReps;
  final FinishWorkout finishWorkout;
  final UpdateTargetWeight updateTargetWeight;

  RecordingBloc({
    @required CreateWorkout createWorkout,
    @required UpdateWorkoutReps updateWorkoutReps,
    @required FinishWorkout finishWorkout,
    @required UpdateTargetWeight updateTargetWeight,
  })  : assert(createWorkout != null),
        assert(updateWorkoutReps != null),
        assert(finishWorkout != null),
        assert(updateTargetWeight != null),
        this.createWorkout = createWorkout,
        this.updateWorkoutReps = updateWorkoutReps,
        this.finishWorkout = finishWorkout,
        this.updateTargetWeight = updateTargetWeight;

  @override
  RecordingState get initialState => Initial();

  @override
  Stream<RecordingState> mapEventToState(
    RecordingEvent event,
  ) async* {
    if (event is ChangeTemplate) {
      yield* _changeTemplate(event);
    } else if (event is RecordReps) {
      yield* _recordReps(event);
    } else if (event is WorkoutFinished) {
      yield* _finishWorkout();
    } else if (event is TargetWeightChanged) {
      yield* _targetWeightChanged(event);
    }
  }

  Stream<RecordingState> _changeTemplate(ChangeTemplate event) async* {
    // template can only be changed if the workout is not started

    if (this.state is Initial || this.state is Ready) {
      final workout = event.template;
      // TODO
      // - retrieve previous workout and pre-populate target weights
      if (workout.isActive()) {
        yield Active(workout);
      } else {
        yield Ready(workout);
      }
    } else {
      // TODO: how does the UI know that this failed?
      yield this.state;
    }
  }

  Stream<RecordingState> _recordReps(RecordReps event) async* {
    final state = this.state;
    if (state is Ready) {
      final result = await createWorkout(Params(workout: state.workout));
      yield result.fold(
        (failure) => state, // TODO: indicate failure somehow
        (workout) => Active(workout),
      );
      if (result.isRight()) {
        //yield Updating(state.workout);
        yield await _updateWorkoutReps(state.workout, event);
      }
    } else if (state is Active) {
      //yield Updating(state.workout);
      yield await _updateWorkoutReps(state.workout, event);
    } else {
      // TODO: error - cannot record reps on a workout that is not active
    }
  }

  Future<RecordingState> _updateWorkoutReps(
    Workout workout,
    RecordReps event,
  ) async {
    final updateResult = await updateWorkoutReps(UpdateRepsParams(
      workout: workout,
      supersetIndex: event.supersetIndex,
      exerciseSetIndex: event.exerciseSetIndex,
      repIndex: event.repIndex,
    ));
    return updateResult.fold(
      (failure) => state, // TODO: indicate failure somehow
      (workout) => Active(workout),
    );
  }

  Stream<RecordingState> _finishWorkout() async* {
    final state = this.state;
    if (state is Active) {
      final result =
          await finishWorkout(FinishWorkoutParams(workout: state.workout));
      yield result.fold(
        (failure) => state, // TODO: indicate failure somehow
        (workout) => Finished(workout),
      );
    }
  }

  Stream<RecordingState> _targetWeightChanged(
    TargetWeightChanged event,
  ) async* {
    final state = this.state;
    if (state is Ready) {
      final result = await createWorkout(Params(workout: state.workout));
      yield result.fold(
        (failure) => state, // TODO: indicate failure somehow
        (workout) => Active(workout),
      );
      if (result.isRight()) {
        yield Updating(state.workout);
        yield await _updateTargetWeight(state.workout, event);
      }
    } else if (state is Active) {
      yield Updating(state.workout);
      yield await _updateTargetWeight(state.workout, event);
    } else {
      // TODO: error - cannot record reps on a workout that is not active
    }
  }

  Future<RecordingState> _updateTargetWeight(
    Workout workout,
    TargetWeightChanged event,
  ) async {
    final updateResult =
        await updateTargetWeight(TargetWeightParams(
      workout: workout,
      supersetIndex: event.supersetIndex,
      exerciseSetIndex: event.exerciseSetIndex,
      weight: event.value,
    ));
    return updateResult.fold(
      (failure) => Active(workout), // TODO: indicate failure somehow
      (workout) => Active(workout),
    );
  }
}
