import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/core/usecases/usecase.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_template_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetWorkoutTemplates implements Usecase<List<Workout>, Params> {
  final AbstractWorkoutTemplateRepository repository;

  GetWorkoutTemplates(this.repository);

  @override
  Future<Either<Failure, List<Workout>>> call(Params params) async {
    return await repository.getWorkoutTemplates(params.activity);
  }
}

class Params extends Equatable {
  final Activity activity;

  @override
  List<Object> get props => [activity];

  Params({@required this.activity});
}
