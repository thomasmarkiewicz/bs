import 'package:bodysculpting/features/workout/data/repositories/workout_template_repository.dart';
import 'package:bodysculpting/features/workout/domain/usecases/finish_workout.dart';
import 'package:bodysculpting/features/workout/domain/usecases/get_workout_summaries.dart';
import 'package:get_it/get_it.dart';

import 'features/workout/data/datasources/abstract_json_local_data_source.dart';
import 'features/workout/data/datasources/abstract_workout_local_data_source.dart';
import 'features/workout/data/datasources/abstract_workout_templates_local_data_source.dart';
import 'features/workout/data/datasources/json_local_data_source.dart';
import 'features/workout/data/datasources/workout_local_data_source.dart';
import 'features/workout/data/datasources/workout_templates_local_data_source.dart';
import 'features/workout/data/repositories/workout_repository.dart';
import 'features/workout/domain/repositories/abstract_workout_repository.dart';
import 'features/workout/domain/repositories/abstract_workout_template_repository.dart';
import 'features/workout/domain/usecases/create_workout.dart';
import 'features/workout/domain/usecases/get_workout.dart';
import 'features/workout/domain/usecases/get_workout_templates.dart';
import 'features/workout/domain/usecases/update_target_weight.dart';
import 'features/workout/domain/usecases/update_workout_reps.dart';
import 'features/workout/presentation/pages/recording/recording_bloc.dart';
import 'features/workout/presentation/pages/templates/templates_bloc.dart';
import 'features/workout/presentation/pages/workout/workout_bloc.dart';

final sl = GetIt.instance;

// called in main.dart
Future<void> init() async {
  await blocs();
  await usecases();
  await repositories();
  await datasources();
  await core();
}

// Register blocks as factories
Future<void> blocs() async {
  sl.registerFactory(() => WorkoutBloc(
        getWorkoutSummaries: sl(),
        getWorkout: sl(),
      ));

  sl.registerFactory(
    () => TemplatesBloc(
      getWorkoutTemplates: sl(),
    ),
  );

  sl.registerFactory(() => RecordingBloc(
        createWorkout: sl(),
        updateWorkoutReps: sl(),
        finishWorkout: sl(),
        updateTargetWeight: sl(),
      ));
}

// Singletons
Future<void> usecases() async {
  sl.registerLazySingleton(() => GetWorkoutTemplates(sl()));
  sl.registerLazySingleton(() => CreateWorkout(sl()));
  sl.registerLazySingleton(() => UpdateWorkoutReps(sl()));
  sl.registerLazySingleton(() => FinishWorkout(sl()));
  sl.registerLazySingleton(() => GetWorkoutSummaries(sl()));
  sl.registerLazySingleton(() => GetWorkout(sl()));
  sl.registerLazySingleton(() => UpdateTargetWeight(sl()));
}

// Singletons
Future<void> repositories() async {
  sl.registerLazySingleton<AbstractWorkoutTemplateRepository>(
    () => WorkoutTemplateRepository(localDataSource: sl()),
  );

  sl.registerLazySingleton<AbstractWorkoutRepository>(
    () => WorkoutRepository(localDataSource: sl()),
  );
}

// Singletons
Future<void> datasources() async {
  sl.registerLazySingleton<AbstractWorkoutTemplatesLocalDataSource>(
      () => WorkoutTemplatesLocalDataSource(sl()));

  sl.registerLazySingleton<AbstractWorkoutLocalDataSource>(
      () => WorkoutLocalDataSource(sl()));

  sl.registerLazySingleton<AbstractJsonLocalDataSource>(
      () => JsonLocalDataSource());
}

Future<void> core() async {
  // TODO: don't need it yet, but will soon...
  // sl.registerLazySingleton(() => InputConverter());
}
