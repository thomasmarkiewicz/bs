import 'package:bodysculpting/features/workout/domain/entities/exercise_set.dart';
import 'package:bodysculpting/features/workout/domain/entities/units.dart';
import 'package:bodysculpting/features/workout/presentation/pages/recording/widgets/reps_button.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class SetTile extends StatelessWidget {
  final Units units;
  final ExerciseSet exerciseSet;
  final Function(int) onRepPressed;

  const SetTile({
    Key key,
    @required this.units,
    @required this.exerciseSet,
    this.onRepPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l = exerciseSet.sets.length;
    final textStyle =
        DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.2);
    final buttonTextStyle = DefaultTextStyle.of(context)
        .style
        .apply(fontSizeFactor: 1.2, color: Colors.lightBlueAccent);
    return Container(
        child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: Text(
              exerciseSet.exerciseName,
              style: textStyle,
            )),
            FlatButton(
              child: SizedBox(
                width: 60,
                child: Text(
                  "${exerciseSet.targetWeight.toString()} ${units.weight}",
                  style: buttonTextStyle,
                  textAlign: TextAlign.right,
                ),
              ),
              onPressed: () {
                print('TODO');
              },
            ),
          ],
        ),
        Row(
          // TODO: can this be refactored into a ListBuilder?
          children: <Widget>[
            Expanded(
              child: RepsButton(
                set: l > 0 ? some(exerciseSet.sets[0]) : none(),
                onPressed: () => this.onRepPressed(0),
              ),
            ),
            Expanded(
              child: RepsButton(
                set: l > 1 ? some(exerciseSet.sets[1]) : none(),
                onPressed: () => this.onRepPressed(1),
              ),
            ),
            Expanded(
              child: RepsButton(
                set: l > 2 ? some(exerciseSet.sets[2]) : none(),
                onPressed: () => this.onRepPressed(2),
              ),
            ),
            Expanded(
              child: RepsButton(
                set: l > 3 ? some(exerciseSet.sets[3]) : none(),
                onPressed: () => this.onRepPressed(3),
              ),
            ),
            Expanded(
              child: RepsButton(
                set: l > 4 ? some(exerciseSet.sets[4]) : none(),
                onPressed: () => this.onRepPressed(4),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
