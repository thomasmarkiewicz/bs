import 'package:bloc_test/bloc_test.dart';
import 'package:bodysculpting/features/workout/data/models/units_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/exercise_set.dart';
import 'package:bodysculpting/features/workout/domain/entities/set.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/usecases/create_workout.dart';
import 'package:bodysculpting/features/workout/domain/usecases/deleteWorkout.dart';
import 'package:bodysculpting/features/workout/domain/usecases/finish_workout.dart';
import 'package:bodysculpting/features/workout/domain/usecases/update_target_weight.dart';
import 'package:bodysculpting/features/workout/domain/usecases/update_workout_reps.dart';
import 'package:bodysculpting/features/workout/presentation/pages/recording/recording_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCreateWorkout extends Mock implements CreateWorkout {}

class MockUpdateWorkoutReps extends Mock implements UpdateWorkoutReps {}

class MockFinishWorkout extends Mock implements FinishWorkout {}

class MockUpdateTargetWeight extends Mock implements UpdateTargetWeight {}

class MockDeleteWorkout extends Mock implements DeleteWorkout {}

void main() {
  RecordingBloc bloc;
  MockCreateWorkout mockCreateWorkout;
  MockUpdateWorkoutReps mockUpdateWorkoutReps;
  MockFinishWorkout mockFinishWorkout;
  MockUpdateTargetWeight mockUpdateTargetWeight;
  MockDeleteWorkout mockDeleteWorkout;

  final testWorkout = Workout(
    activity: Activity.lift,
    name: 'Barbbell Lifts 3x10 A',
    description: some('Squat, Bench, Press'),
    units: UnitsModel(weight: "lb", distance: "km"),
    start: some(DateTime(2020, 4, 25, 17, 30, 00)),
    end: some(DateTime(2020, 4, 25, 18, 00, 00)),
    summary: some("Optional summary"),
    supersets: [
      [
        ExerciseSet(
            exerciseId: '1',
            exerciseName: 'Squats',
            targetWeight: 135,
            sets: [
              Set(
                targetReps: 10,
                targetRest: 180,
                reps: some(10),
                weight: some(135),
              ),
              Set(
                targetReps: 10,
                targetRest: 180,
                reps: some(10),
                weight: some(135),
              ),
              Set(
                targetReps: 10,
                targetRest: 180,
                reps: some(10),
                weight: some(135),
              ),
            ])
      ],
      [
        ExerciseSet(
            exerciseId: '1',
            exerciseName: 'Squats',
            targetWeight: 135,
            sets: [
              Set(
                targetReps: 10,
                targetRest: 180,
                reps: some(9),
                weight: some(135),
              ),
              Set(
                targetReps: 10,
                targetRest: 180,
                reps: some(9),
                weight: some(135),
              ),
              Set(
                targetReps: 10,
                targetRest: 180,
                reps: some(8),
                weight: some(130),
              ),
            ]),
        ExerciseSet(
          exerciseId: '2',
          exerciseName: 'Bench Press',
          targetWeight: 135,
          sets: [
            Set(
              targetReps: 10,
              targetRest: 180,
              reps: none(),
              weight: none(),
            ),
            Set(
              targetReps: 10,
              targetRest: 180,
              reps: none(),
              weight: none(),
            ),
            Set(
              targetReps: 10,
              targetRest: 180,
              reps: none(),
              weight: none(),
            ),
          ],
        ),
      ]
    ],
  );

  setUp(() {
    mockCreateWorkout = MockCreateWorkout();
    mockUpdateWorkoutReps = MockUpdateWorkoutReps();
    mockFinishWorkout = MockFinishWorkout();
    mockUpdateTargetWeight = MockUpdateTargetWeight();
    mockDeleteWorkout = MockDeleteWorkout();

    bloc = RecordingBloc(
      createWorkout: mockCreateWorkout,
      updateWorkoutReps: mockUpdateWorkoutReps,
      finishWorkout: mockFinishWorkout,
      updateTargetWeight: mockUpdateTargetWeight,
      deleteWorkout: mockDeleteWorkout,
    );
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
