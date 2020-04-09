import 'dart:io';

import 'package:bodysculpting/features/workout/data/models/document_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_summary_model.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

abstract class AbstractJsonLocalDataSource {
  Future<File> writeDocument(DocumentModel document);
  Future<DocumentModel> readDocument();
  Future<WorkoutModel> writeWorkout(WorkoutModel workout);
  Future<WorkoutModel> readWorkout({
    @required DateTime start,
    @required Option<DateTime> end,
  });
  Future<WorkoutModel> deleteWorkout({
    @required DateTime start,
    @required DateTime end,
  });
  Future<bool> workoutExists({@required DateTime start});
  Future<List<WorkoutSummaryModel>> readWorkoutSummaries({
    @required DateTime start,
    @required DateTime end,
  });
}
