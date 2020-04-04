import 'package:bodysculpting/core/error/exceptions.dart';
import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/features/workout/data/datasources/abstract_workout_templates_local_data_source.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_template_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class WorkoutTemplateRepository implements AbstractWorkoutTemplateRepository {
  final AbstractWorkoutTemplatesLocalDataSource localDataSource;

  WorkoutTemplateRepository({@required this.localDataSource});

  @override
  Future<Either<Failure, List<Workout>>> getWorkoutTemplates(
    Activity activity,
  ) async {
    try {
      final result = await localDataSource.getWorkoutTemplates(activity);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
