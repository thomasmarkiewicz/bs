import 'package:bodysculpting/features/workout/domain/entities/exercise.dart';
import 'package:meta/meta.dart';

class ExerciseModel extends Exercise {
  ExerciseModel({
    @required String id,
    @required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
    };
  }
}
