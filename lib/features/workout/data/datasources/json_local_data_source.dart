import 'dart:convert';
import 'dart:io';

import 'package:bodysculpting/features/workout/data/datasources/abstract_json_local_data_source.dart';
import 'package:bodysculpting/features/workout/data/models/document_model.dart';
import 'package:bodysculpting/features/workout/data/models/exercise_model.dart';
import 'package:bodysculpting/features/workout/data/models/exercise_set_model.dart';
import 'package:bodysculpting/features/workout/data/models/rep_model.dart';
import 'package:bodysculpting/features/workout/data/models/units_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_model.dart';
import 'package:bodysculpting/features/workout/data/models/workout_summary_model.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

const String LOCAL_DOCUMENT_FILE_NAME = "bodysculpting.json";
const String LOCAL_WORKOUTS_DIRECTORY = "workouts";

class JsonLocalDataSource implements AbstractJsonLocalDataSource {
  Future<String> get _localPath async {
    //final directory = await getApplicationDocumentsDirectory();
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$LOCAL_DOCUMENT_FILE_NAME');
  }

  Future<String> get _localWorkoutsPath async {
    final path = await _localPath;
    return '$path/$LOCAL_WORKOUTS_DIRECTORY';
  }

  // TODO: Reconsider this approach
  //       I fear this DocumentModel object is taking up memory when app is running unnecessarily.
  //       It would be better if it was distributed as a json asset file somehow
  //       Also probably want to split out exercises+workouttemplates into its own folder
  //       so new templates can be downloaded and added without replacing this entire file.
  //       Also saving workout recordings probably needs to go into its own list of files as well.
  DocumentModel get _defaultDocumentModel => DocumentModel(
        version: "0.0.1",
        syncCounter: 0,
        exercises: [
          // StrongLifts
          ExerciseModel(id: "0537cd19644c", name: "Squats"),
          ExerciseModel(id: "33871bf6de60", name: "Bench Press"),
          ExerciseModel(id: "7eef10e8aaed", name: "Shoulder Press"),
          ExerciseModel(id: "056672996981", name: "Rows"),
          ExerciseModel(id: "ca1240b16dab", name: "Deadlifts"),

          // Body Sculpting
          ExerciseModel(id: "3e904e0972c4", name: "Dumbbell Rows (one arm)"),
          ExerciseModel(id: "490d6d0ec5f0", name: "Dumbbell Rows (two arms)"),
          ExerciseModel(id: "19b420dafb22", name: "Push-ups"),
          ExerciseModel(id: "4bfc6352fcfb", name: "Dumbbell Flys (flat)"),
          ExerciseModel(id: "fcea91c905fa", name: "Dumbbell Curls"),
          ExerciseModel(
              id: "4cab4ad2ce41", name: "Dumbbell Extensions (lying)"),
          ExerciseModel(
              id: "3febf26fdef2", name: "Dumbbell Extensions (overhead)"),
          ExerciseModel(id: "ebe07cb7b8a4", name: "Dumbbell Hammer Curls"),
          ExerciseModel(id: "69ff1785ec1b", name: "Dumbbell Squats"),
          ExerciseModel(id: "7d6b7ce13c84", name: "Dumbbell Lunges"),
          ExerciseModel(id: "69ff1785ec1b", name: "Dumbbell Squats (ballet)"),
          ExerciseModel(id: "ca181a7a5d84", name: "Dumbbell Deadlifts"),
          ExerciseModel(id: "bb69814ba53a", name: "Dumbbell Shoulder Press"),
          ExerciseModel(
              id: "1f73be506740", name: "Dumbbell Calf Raises (one leg)"),
          ExerciseModel(
              id: "dfcf16f15339", name: "Dumbbell Calf Raises (two legs)"),
          ExerciseModel(
              id: "b9191529d1cc", name: "Dumbbell Bent Over Lateral Raises"),
        ],
        workoutTemplates: [
          WorkoutModel(
            activity: Activity.lift,
            name: "StrongLifts 5x5 A",
            description: some("Squat, Bench, Deadlift"),
            units: UnitsModel(
              weight: "lb",
              distance: "mi",
            ),
            supersets: [
              [
                ExerciseSetModel(
                  exerciseId: "0537cd19644c",
                  exerciseName: "Squats",
                  targetWeight: 45,
                  sets: [
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180)
                  ],
                ),
              ],
              [
                ExerciseSetModel(
                  exerciseId: "33871bf6de60",
                  exerciseName: "Bench Press",
                  targetWeight: 45,
                  sets: [
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180)
                  ],
                ),
              ],
              [
                ExerciseSetModel(
                  exerciseId: "ca1240b16dab",
                  exerciseName: "Deadlifts",
                  targetWeight: 45,
                  sets: [RepModel(targetReps: 5, targetRest: 180)],
                ),
              ],
            ],
          ),
          WorkoutModel(
            activity: Activity.lift,
            name: "StrongLifts 5x5 B",
            description: some("Squat, Shoulder Press, Rows"),
            units: UnitsModel(
              weight: "lb",
              distance: "mi",
            ),
            supersets: [
              [
                ExerciseSetModel(
                  exerciseId: "0537cd19644c",
                  exerciseName: "Squats",
                  targetWeight: 45,
                  sets: [
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                  ],
                ),
              ],
              [
                ExerciseSetModel(
                  exerciseId: "7eef10e8aaed",
                  exerciseName: "Shoulder Press",
                  targetWeight: 45,
                  sets: [
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180)
                  ],
                ),
              ],
              [
                ExerciseSetModel(
                  exerciseId: "056672996981",
                  exerciseName: "Rows",
                  targetWeight: 45,
                  sets: [
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180),
                    RepModel(targetReps: 5, targetRest: 180)
                  ],
                ),
              ],
            ],
          ),
          WorkoutModel(
            activity: Activity.lift,
            name: "Body Sculpting - Break In #1 - A",
            description: some("Dumbbell starting routine"),
            units: UnitsModel(
              weight: "lb",
              distance: "mi",
            ),
            supersets: [
              [
                ExerciseSetModel(
                  exerciseId: "3e904e0972c4",
                  exerciseName: "Dumbbell Rows (one arm)",
                  targetWeight: 20,
                  sets: [
                    RepModel(targetReps: 15, targetRest: 90),
                    RepModel(targetReps: 15, targetRest: 90),
                  ],
                ),
                ExerciseSetModel(
                  exerciseId: "19b420dafb22",
                  exerciseName: "Push-ups",
                  targetWeight: 0,
                  sets: [
                    RepModel(targetReps: 15, targetRest: 9),
                    RepModel(targetReps: 15, targetRest: 9),
                  ],
                ),
              ],
              [
                ExerciseSetModel(
                  exerciseId: "490d6d0ec5f0",
                  exerciseName: "Dumbbell Rows (two arms)",
                  targetWeight: 20,
                  sets: [
                    RepModel(targetReps: 15, targetRest: 90),
                    RepModel(targetReps: 15, targetRest: 90),
                  ],
                ),
                ExerciseSetModel(
                  exerciseId: "4bfc6352fcfb",
                  exerciseName: "Dumbbell Flys (flat)",
                  targetWeight: 10,
                  sets: [
                    RepModel(targetReps: 15, targetRest: 90),
                    RepModel(targetReps: 15, targetRest: 90),
                  ],
                ),
              ],
              [
                ExerciseSetModel(
                  exerciseId: "fcea91c905fa",
                  exerciseName: "Dumbbell Curls",
                  targetWeight: 10,
                  sets: [
                    RepModel(targetReps: 15, targetRest: 90),
                    RepModel(targetReps: 15, targetRest: 90),
                  ],
                ),
                ExerciseSetModel(
                  exerciseId: "4cab4ad2ce41",
                  exerciseName: "Dumbbell Extensions (lying)",
                  targetWeight: 10,
                  sets: [
                    RepModel(targetReps: 15, targetRest: 90),
                    RepModel(targetReps: 15, targetRest: 90),
                  ],
                ),
              ],
              [
                ExerciseSetModel(
                  exerciseId: "ebe07cb7b8a4",
                  exerciseName: "Dumbbell Hammer Curls",
                  targetWeight: 10,
                  sets: [
                    RepModel(targetReps: 15, targetRest: 90),
                    RepModel(targetReps: 15, targetRest: 90),
                  ],
                ),
                ExerciseSetModel(
                  exerciseId: "3febf26fdef2",
                  exerciseName: "Dumbbell Extensions (overhead)",
                  targetWeight: 10,
                  sets: [
                    RepModel(targetReps: 15, targetRest: 90),
                    RepModel(targetReps: 15, targetRest: 90),
                  ],
                ),
              ],
            ],
          ),
          WorkoutModel(
            activity: Activity.lift,
            name: "Body Sculpting #1",
            description: some("Weeks 5 & 6 - Day 1"),
            units: UnitsModel(
              weight: "lb",
              distance: "mi",
            ),
            supersets: [
              [
                ExerciseSetModel(
                  exerciseId: "3e904e0972c4",
                  exerciseName: "Dumbbell Rows (one arm)",
                  targetWeight: 20,
                  sets: [
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                  ],
                ),
                ExerciseSetModel(
                  exerciseId: "19b420dafb22",
                  exerciseName: "Push-ups",
                  targetWeight: 0,
                  sets: [
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                  ],
                ),
                ExerciseSetModel(
                  exerciseId: "490d6d0ec5f0",
                  exerciseName: "Dumbbell Rows (two arms)",
                  targetWeight: 20,
                  sets: [
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                  ],
                ),
                ExerciseSetModel(
                  exerciseId: "4bfc6352fcfb",
                  exerciseName: "Dumbbell Flys (flat)",
                  targetWeight: 10,
                  sets: [
                    RepModel(targetReps: 8, targetRest: 60),
                    RepModel(targetReps: 8, targetRest: 60),
                    RepModel(targetReps: 8, targetRest: 60),
                    RepModel(targetReps: 8, targetRest: 60),
                  ],
                ),
              ],
              [
                ExerciseSetModel(
                  exerciseId: "fcea91c905fa",
                  exerciseName: "Dumbbell Curls",
                  targetWeight: 10,
                  sets: [
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                  ],
                ),
                ExerciseSetModel(
                  exerciseId: "4cab4ad2ce41",
                  exerciseName: "Dumbbell Extensions (lying)",
                  targetWeight: 10,
                  sets: [
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                  ],
                ),
                ExerciseSetModel(
                  exerciseId: "ebe07cb7b8a4",
                  exerciseName: "Dumbbell Hammer Curls",
                  targetWeight: 10,
                  sets: [
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                    RepModel(targetReps: 8, targetRest: 0),
                  ],
                ),
                ExerciseSetModel(
                  exerciseId: "3febf26fdef2",
                  exerciseName: "Dumbbell Extensions (overhead)",
                  targetWeight: 10,
                  sets: [
                    RepModel(targetReps: 8, targetRest: 60),
                    RepModel(targetReps: 8, targetRest: 60),
                    RepModel(targetReps: 8, targetRest: 60),
                    RepModel(targetReps: 8, targetRest: 60),
                  ],
                ),
              ],
            ],
          ),
          /*
          WorkoutModel(
            activity: Activity.lift,
            name: "Madcow 5x5 A",
            description: some("Squat, Bench, Deadlift"),
            supersets: [
              [
                ExerciseSetModel(
                  exerciseId: "0537cd19644c",
                  exerciseName: "Squats",
                  sets: [
                    // Note: to support this each set needs a percentage of a target final weight being lifted
                    //       how can UI display that concisely w/o degrading exparience of other workouts?
                    SetMetaDataModel(reps: 5, weight: 0.6, rest: 180),
                    SetMetaDataModel(reps: 5, weight: 0.7, rest: 180),
                    SetMetaDataModel(reps: 5, weight: 0.8, rest: 180),
                    SetMetaDataModel(reps: 5, weight: 0.9, rest: 180),
                    SetMetaDataModel(reps: 5, weight: 1.0, rest: 180)
                  ],
                ),
              ],
              [
                ExerciseSetModel(
                  exerciseId: "33871bf6de60",
                  exerciseName: "Bench Press",
                  sets: [
                    SetMetaDataModel(reps: 5, rest: 180),
                    SetMetaDataModel(reps: 5, rest: 180),
                    SetMetaDataModel(reps: 5, rest: 180),
                    SetMetaDataModel(reps: 5, rest: 180),
                    SetMetaDataModel(reps: 5, rest: 180)
                  ],
                ),
              ],
              [
                ExerciseSetModel(
                  exerciseId: "ca1240b16dab",
                  exerciseName: "Deadlifts",
                  sets: [SetMetaDataModel(reps: 5, rest: 180)],
                ),
              ],
            ],
          ), */
        ],
      );

  Future<File> writeDocument(DocumentModel documentModel) async {
    final file = await _localFile;
    final encoder = JsonEncoder.withIndent("    ");
    return file.writeAsString(encoder.convert(documentModel));
  }

  Future<DocumentModel> readDocument() async {
    final file = await _localFile;
    try {
      String contents = await file.readAsString();
      return Future.value(DocumentModel.fromJson(jsonDecode(contents)));
    } on FileSystemException {
      writeDocument(_defaultDocumentModel);
      return Future.value(_defaultDocumentModel);
    }
  }

  @override
  Future<WorkoutModel> readWorkout(
      {DateTime start, Option<DateTime> end}) async {
    final file = await end.fold(
      () => _activeWorkoutFile(),
      (_) => _finishedWorkoutFile(start),
    );

    String contents = await file.readAsString();
    final workout = Future.value(WorkoutModel.fromJson(jsonDecode(contents)));
    return workout;
  }

  @override
  Future<WorkoutModel> writeWorkout(WorkoutModel workout) async {
    final file = await workout.end.fold(
      () => _activeWorkoutFile(),
      (_) => _finishedWorkoutFile(
        workout.start.getOrElse(() => throw FileSystemException()),
      ),
    );
    final encoder = JsonEncoder.withIndent("    ");
    await file.create(recursive: true);
    await file.writeAsString(encoder.convert(workout));

    // if we wrote a finished workout, delete active workout if it has the same start
    if (workout.isFinished()) {
      final activeFile = await _activeWorkoutFile();
      if (await activeFile.exists()) {
        String contents = await activeFile.readAsString();
        final activeWorkout = WorkoutModel.fromJson(jsonDecode(contents));
        if (activeWorkout.start == workout.start) {
          activeFile.delete();
        }
      }
    }

    return workout;
  }

  @override
  Future<WorkoutModel> deleteWorkout({DateTime start, DateTime end}) async {
    final finishedFile = await _finishedWorkoutFile(start);
    if (await finishedFile.exists()) {
      String contents = await finishedFile.readAsString();
      final workout = Future.value(WorkoutModel.fromJson(jsonDecode(contents)));
      await finishedFile.delete();
      return workout;
    } else {
      throw FileSystemException(); // workout to be deleted doesn't exit
    }
  }

  @override
  Future<bool> workoutExists({DateTime start}) async {
    final activeFile = await _activeWorkoutFile();
    final finishedFile = await _finishedWorkoutFile(start);
    return (await activeFile.exists()) || await finishedFile.exists();
  }

  Future<File> _finishedWorkoutFile(DateTime start) async {
    final year = start.year;
    final dateTime = DateFormat('yyyyMMdd-kkmmss').format(start);
    final workoutsDir = await _localWorkoutsPath;
    final workoutFile = File('$workoutsDir/$year/${dateTime}_workout.json');
    return workoutFile;
  }

  Future<File> _activeWorkoutFile() async {
    final workoutsDir = await _localWorkoutsPath;
    final workoutFile = File('$workoutsDir/active_workout.json');
    return workoutFile;
  }

  @override
  Future<List<WorkoutSummaryModel>> readWorkoutSummaries(
      {DateTime start, DateTime end}) async {
    // TODO: implement readWorkoutSummaries
    /*
    get active workout summary

    get list of all years betwee start:end dates and for each
      get a list of all file names in the year subfolders
      filter out those outside of start:end range
      read in each remaining file into a WorkoutSummaryModel appending to the growing list

    return the list of workout summaries
    */

    final workoutsDir = await _localWorkoutsPath;

    var summaries = List<WorkoutSummaryModel>();

    final activeWorkoutFile = await _activeWorkoutFile();
    if (await activeWorkoutFile.exists()) {
      String contents = await activeWorkoutFile.readAsString();
      final summary = WorkoutSummaryModel.fromJson(jsonDecode(contents));
      summaries.add(summary);
    }

    final count = end.year - start.year + 1;
    var years = new List<int>.generate(
      count,
      (i) => start.year + i,
    );

    for (final year in years) {
      final dir = Directory('$workoutsDir/$year');
      if (await dir.exists()) {
        var files = dir.listSync();
        for (final entity in files) {
          //files.forEach((entity) async {
          if (entity is File) {
            String contents = await (entity as File).readAsString();
            final summary = WorkoutSummaryModel.fromJson(jsonDecode(contents));
            if (summary.start.isSome() &&
                summary.end.isSome() &&
                summary.start
                        .getOrElse(() => DateTime.now())
                        .compareTo(start) >=
                    1 &&
                summary.end.getOrElse(() => DateTime.now()).compareTo(end) <=
                    0) {
              summaries.add(summary);
            }
          }
        }
      }
    }

    return summaries;
  }
}
