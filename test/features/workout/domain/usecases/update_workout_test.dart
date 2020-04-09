import 'package:bodysculpting/features/workout/domain/entities/exercise_set.dart';
import 'package:bodysculpting/features/workout/domain/entities/set.dart';
import 'package:bodysculpting/features/workout/domain/entities/units.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_repository.dart';
import 'package:bodysculpting/features/workout/domain/usecases/update_workout_reps.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockWorkoutRepository extends Mock implements AbstractWorkoutRepository {}

void main() {
  MockWorkoutRepository mockRepository;
  UpdateWorkoutReps updateWorkoutReps;

  setUp(() {
    mockRepository = MockWorkoutRepository();
    updateWorkoutReps = UpdateWorkoutReps(mockRepository);
  });

  final tWorkoutBefore = Workout(
    start: some(DateTime.now()),
    end: none(),
    summary: none(),
    activity: Activity.lift,
    name: 'Barbbell Lifts 3x10 A',
    description: some('Squat, bench, deadlift'),
    units: Units(weight: 'lb', distance: 'mi'),
    supersets: [
      [
        ExerciseSet(
            exerciseId: "1",
            exerciseName: "Test",
            targetWeight: 45,
            sets: [Set(targetReps: 5, targetRest: 180)])
      ]
    ],
  );

  final tWorkoutAfter = Workout(
    activity: tWorkoutBefore.activity,
    start: tWorkoutBefore.start,
    end: tWorkoutBefore.end,
    summary: tWorkoutBefore.summary,
    name: tWorkoutBefore.name,
    description: tWorkoutBefore.description,
    units: Units(weight: 'lb', distance: 'mi'),
    supersets: [
      [
        ExerciseSet(
            exerciseId: "1",
            exerciseName: "Test",
            targetWeight: 45,
            sets: [Set(targetReps: 5, targetRest: 180, reps: some(5))])
      ]
    ],
  );

  test('update a workout via the repository', () async {
    // setup
    when(mockRepository.updateWorkout(any))
        .thenAnswer((_) async => Right(tWorkoutAfter));

    // test
    final result = await updateWorkoutReps(UpdateRepsParams(
      workout: tWorkoutBefore,
      supersetIndex: 0,
      exerciseSetIndex: 0,
      repIndex: 0,
    ));

    // check
    expect(result, Right(tWorkoutAfter));
    verify(mockRepository.updateWorkout(tWorkoutAfter));
    verifyNoMoreInteractions(mockRepository);
  });
}
