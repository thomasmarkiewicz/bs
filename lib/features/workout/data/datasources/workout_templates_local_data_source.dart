import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_base.dart';

import 'abstract_json_local_data_source.dart';
import 'abstract_workout_templates_local_data_source.dart';

class WorkoutTemplatesLocalDataSource
    implements AbstractWorkoutTemplatesLocalDataSource {
  final AbstractJsonLocalDataSource jsonLocalDataSource;

  WorkoutTemplatesLocalDataSource(this.jsonLocalDataSource);

  Future<List<WorkoutModel>> getWorkoutTemplates(
      Activity activity) async {
    final document = await jsonLocalDataSource.readDocument();
    final workoutTemplates =
        document.workoutTemplates.where((t) => t.activity == activity).toList();
    return workoutTemplates;
  }
}
