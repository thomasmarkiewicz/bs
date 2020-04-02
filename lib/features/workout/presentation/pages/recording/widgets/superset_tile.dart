import 'package:bodysculpting/features/workout/domain/entities/exercise_set.dart';
import 'package:bodysculpting/features/workout/presentation/pages/recording/widgets/set_tile.dart';
import 'package:flutter/material.dart';

class SupersetTile extends StatelessWidget {
  final List<ExerciseSet> superset;
  final Function(int, int) onExerciseSetRepPressed;
  const SupersetTile({
    Key key,
    @required this.superset,
    this.onExerciseSetRepPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.white70,
      child: Container(
        height: 100.0 * superset.length,
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: superset.length,
          itemBuilder: (BuildContext context, int index) {
            return SetTile(
              exerciseSet: superset[index],
              onRepPressed: (repIndex) {
                // 'repIndex' button pressed
                // in exerciseSet 'index'
                // in superset 'supersetIndex'
                this.onExerciseSetRepPressed(index, repIndex);
              },
            );
          },
        ),
      ),
    );
  }
}
