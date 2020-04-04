import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';

abstract class AbstractWorkoutTemplatesLocalDataSource {
  Future<List<WorkoutModel>> getWorkoutTemplates(Activity activity);
}
