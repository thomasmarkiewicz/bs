import 'package:bodysculpting/features/workout/domain/entities/exercise_set.dart';
import 'package:bodysculpting/features/workout/domain/entities/units.dart';
import 'package:bodysculpting/features/workout/presentation/pages/recording/widgets/reps_button.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class SetTile extends StatelessWidget {
  final Units units;
  final ExerciseSet exerciseSet;
  final Function(int) onRepPressed;
  final Function(int) onTargetWeightChanged;

  const SetTile({
    Key key,
    @required this.units,
    @required this.exerciseSet,
    this.onRepPressed,
    this.onTargetWeightChanged,
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
            DropdownButton<int>(
                style: buttonTextStyle,
                value: exerciseSet.targetWeight,
                items: List<DropdownMenuItem<int>>.generate(
                  100,
                  (i) => DropdownMenuItem<int>(
                    value: i * 5,
                    child: Text("${i * 5} ${units.weight}"),
                  ),
                ),
                onChanged: (value) => this.onTargetWeightChanged(value),
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

  List<DropdownMenuItem<int>> _weightItems() =>
      List<DropdownMenuItem<int>>.generate(
        100,
        (i) => DropdownMenuItem<int>(
          value: i * 5,
          child: Text("${i * 5} ${units.weight}"),
        ),
      );
}
