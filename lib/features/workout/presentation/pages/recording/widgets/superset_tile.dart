import 'package:bodysculpting/features/workout/domain/entities/exercise_set.dart';
import 'package:bodysculpting/features/workout/domain/entities/units.dart';
import 'package:bodysculpting/features/workout/presentation/pages/recording/widgets/set_tile.dart';
import 'package:flutter/material.dart';

class SupersetTile extends StatelessWidget {
  final Units units;
  final List<ExerciseSet> superset;
  final Function(int, int) onExerciseSetRepPressed;
  final Function(int ,int) onTargetWeightChanged;
  const SupersetTile({
    Key key,
    @required this.units,
    @required this.superset,
    this.onExerciseSetRepPressed,
    this.onTargetWeightChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.white70,
      child: Container(
        height: 128.0 * superset.length,
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: superset.length,
          itemBuilder: (BuildContext context, int index) {
            return SetTile(
              units: this.units,
              exerciseSet: superset[index],
              onRepPressed: (repIndex) {
                // 'repIndex' button pressed
                // in exerciseSet 'index'
                // in superset 'supersetIndex'
                this.onExerciseSetRepPressed(index, repIndex);
              },
              onTargetWeightChanged: (value) => this.onTargetWeightChanged(index, value),
            );
          },
        ),
      ),
    );
  }
}
