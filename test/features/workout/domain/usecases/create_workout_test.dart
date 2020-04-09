import 'package:bodysculpting/features/workout/domain/entities/units.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_repository.dart';
import 'package:bodysculpting/features/workout/domain/usecases/create_workout.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockWorkoutRepository extends Mock implements AbstractWorkoutRepository {}

void main() {
  MockWorkoutRepository mockRepository;
  CreateWorkout createWorkout;

  setUp(() {
    mockRepository = MockWorkoutRepository();
    createWorkout = CreateWorkout(mockRepository);
  });

  final tWorkout = Workout(
    start: some(DateTime.now()),
    end: none(),
    summary: none(),
    units: Units(weight: 'lb', distance: 'mi'),
    activity: Activity.lift,
    name: 'Barbbell Lifts 3x10 A',
    description: some('Squat, bench, deadlift'),
    supersets: null,
  );

  test('creates a workout via the repository', () async {
    // setup
    when(mockRepository.createWorkout(any))
        .thenAnswer((_) async => Right(tWorkout));

    // test
    final result = await createWorkout(Params(workout: tWorkout));

    // check
    expect(result, Right(tWorkout));
    verify(mockRepository.createWorkout(tWorkout));
    verifyNoMoreInteractions(mockRepository);
  });
}
