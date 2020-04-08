import 'package:bodysculpting/features/workout/domain/entities/units.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_template_repository.dart';
import 'package:bodysculpting/features/workout/domain/usecases/get_workout_templates.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockWorkoutTemplateRepository extends Mock
    implements AbstractWorkoutTemplateRepository {}

void main() {
  MockWorkoutTemplateRepository mockRepository;
  GetWorkoutTemplates getWorkoutTemplates;

  setUp(() {
    mockRepository = MockWorkoutTemplateRepository();
    getWorkoutTemplates = GetWorkoutTemplates(mockRepository);
  });

  final tActivity = Activity.lift;
  final tWorkoutTemplates = [
    Workout(
      name: 'Barbbell Lifts 3x10 A',
      activity: Activity.lift,
      description: some('Squat, bench, deadlift'),
      units: Units(weight: 'lb', distance: 'mi'),
      supersets: null,
    ),
  ];

  test('gets workout templates from the repository', () async {
    // setup
    when(mockRepository.getWorkoutTemplates(any))
        .thenAnswer((_) async => Right(tWorkoutTemplates));

    // test
    final result = await getWorkoutTemplates(Params(activity: tActivity));

    // check
    expect(result, Right(tWorkoutTemplates));
    verify(mockRepository.getWorkoutTemplates(tActivity));
    verifyNoMoreInteractions(mockRepository);
  });
}
