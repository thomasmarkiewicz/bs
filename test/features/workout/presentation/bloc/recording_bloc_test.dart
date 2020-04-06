import 'package:bloc_test/bloc_test.dart';
import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/features/workout/domain/entities/exercise_set.dart';
import 'package:bodysculpting/features/workout/domain/entities/rep.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_base.dart';
import 'package:bodysculpting/features/workout/domain/usecases/create_workout.dart';
import 'package:bodysculpting/features/workout/domain/usecases/update_workout_reps.dart';
import 'package:bodysculpting/features/workout/presentation/pages/recording/recording_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCreateWorkout extends Mock implements CreateWorkout {}

class MockUpdateWorkoutReps extends Mock implements UpdateWorkoutReps {}

void main() {
  RecordingBloc bloc;
  MockCreateWorkout mockCreateWorkout;
  MockUpdateWorkoutReps mockUpdateWorkoutReps;

  final testWorkout = Workout(
    activity: Activity.lift,
    name: 'Barbbell Lifts 3x10 A',
    description: some('Squat, Bench, Press'),
    start: some(DateTime(2020, 4, 25, 17, 30, 00)),
    end: some(DateTime(2020, 4, 25, 18, 00, 00)),
    summary: some("Optional summary"),
    supersets: [
      [
        ExerciseSet(exerciseId: '1', exerciseName: 'Squats', sets: [
          Rep(
              targetReps: 10,
              targetRest: 180,
              targetWeight: 135,
              reps: some(10),
              weight: some(135)),
          Rep(
              targetReps: 10,
              targetRest: 180,
              targetWeight: 135,
              reps: some(10),
              weight: some(135)),
          Rep(
              targetReps: 10,
              targetRest: 180,
              targetWeight: 135,
              reps: some(10),
              weight: some(135)),
        ])
      ],
      [
        ExerciseSet(exerciseId: '1', exerciseName: 'Squats', sets: [
          Rep(
              targetReps: 10,
              targetRest: 180,
              targetWeight: 135,
              reps: some(9),
              weight: some(135)),
          Rep(
              targetReps: 10,
              targetRest: 180,
              targetWeight: 135,
              reps: some(9),
              weight: some(135)),
          Rep(
              targetReps: 10,
              targetRest: 180,
              targetWeight: 135,
              reps: some(8),
              weight: some(130)),
        ]),
        ExerciseSet(exerciseId: '2', exerciseName: 'Bench Press', sets: [
          Rep(
            targetReps: 10,
            targetRest: 180,
            targetWeight: 135,
            reps: none(),
            weight: none(),
          ),
          Rep(
            targetReps: 10,
            targetRest: 180,
            targetWeight: 135,
            reps: none(),
            weight: none(),
          ),
          Rep(
            targetReps: 10,
            targetRest: 180,
            targetWeight: 135,
            reps: none(),
            weight: none(),
          ),
        ]),
      ]
    ],
  );

  setUp(() {
    mockCreateWorkout = MockCreateWorkout();
    mockUpdateWorkoutReps = MockUpdateWorkoutReps();
    bloc = RecordingBloc(
        createWorkout: mockCreateWorkout,
        updateWorkoutReps: mockUpdateWorkoutReps);
  });

  test('initial state should be Initial', () {
    expect(bloc.initialState, Initial());
  });

  group('ChangeTemplate', () {
    blocTest(
      'should prepare a new Workout and transition to Ready state',
      build: () async {
        return bloc;
      },
      act: (bloc) => bloc.add(ChangeTemplate(template: testWorkout)),
      verify: (RecordingBloc bloc) {
        expect(bloc.state, Ready(testWorkout));
        return;
      },
    );
  });

  group('RecordReps', () {
    blocTest(
      'should call concrete usecase to create a new Workout',
      build: () async {
        when(mockCreateWorkout(any))
            .thenAnswer((_) async => Right(testWorkout));
        when(mockUpdateWorkoutReps(any))
            .thenAnswer((_) async => Right(testWorkout));
        return bloc;
      },
      act: (RecordingBloc bloc) async {
        bloc.add(ChangeTemplate(template: testWorkout));
        bloc.add(RecordReps(
          supersetIndex: 0,
          exerciseSetIndex: 0,
          repIndex: 0,
        ));
        return;
      },
      /*
      expect: [
        Ready(testWorkout),
        Active(any),
      ],
      */
      verify: (RecordingBloc bloc) {
        /*
        expect(
          some(9),
          (bloc.state as Active).workout.supersets[0][0].sets[0].reps,
        );
        */

        verify(mockUpdateWorkoutReps(UpdateRepsParams(
          workout: testWorkout,
          supersetIndex: 0,
          exerciseSetIndex: 0,
          repIndex: 0,
        )));

        return;
      },
    );
  });
}
