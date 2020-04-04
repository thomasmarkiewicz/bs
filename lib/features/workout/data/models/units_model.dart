import 'package:bodysculpting/features/workout/domain/entities/units.dart';
import 'package:meta/meta.dart';

class UnitsModel extends Units {
  UnitsModel({
    @required String weight,
    @required String distance,
  }) : super(
          weight: weight,
          distance: distance,
        );

  factory UnitsModel.from(Units units) {
    return UnitsModel(
      weight: units.weight,
      distance: units.distance,
    );
  }

  factory UnitsModel.fromJson(Map<String, dynamic> json) {
    return UnitsModel(
      weight: json['weight'],
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = {
      'weight': weight,
      'distance': distance,
    };

    return map;
  }
}
