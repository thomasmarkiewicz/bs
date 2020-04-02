import 'package:bodysculpting/core/error/failures.dart';
import 'package:bodysculpting/core/usecases/usecase.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/domain/repositories/abstract_workout_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetWorkoutSummaries
    implements Usecase<List<WorkoutSummary>, SummaryParams> {
  final AbstractWorkoutRepository repository;

  GetWorkoutSummaries(this.repository);

  @override
  Future<Either<Failure, List<WorkoutSummary>>> call(
      SummaryParams params) async {
    return await repository.getWorkoutSummaries(
      start: params.start,
      end: params.end,
    );
  }
}

class SummaryParams extends Equatable {
  final DateTime start;
  final DateTime end;

  @override
  List<Object> get props => [start, end];

  SummaryParams({@required this.start, @required this.end});
}
