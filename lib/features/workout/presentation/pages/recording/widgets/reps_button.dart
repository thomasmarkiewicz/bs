import 'package:bodysculpting/features/workout/domain/entities/rep.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class RepsButton extends StatelessWidget {
  final Option<Rep> set;
  final VoidCallback onPressed;

  const RepsButton({
    Key key,
    @required this.set,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = set.isNone()
        ? Icon(
            Icons.clear,
            color: Colors.grey.shade400,
            size: 30.0,
          )
        : _getRepsText(context);

    final color = set.fold(
      () => Theme.of(context).disabledColor,
      (s) => s.reps.isNone() ? Theme.of(context).buttonColor : Colors.redAccent,
    );

    //final color = set.isNone() ? Colors.grey.shade50 :  Colors.grey.shade200;
    final elevation = set.isNone() ? 0.0 : 1.0;

    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 16),
      alignment: Alignment.center,
      child: new SizedBox(
        child: RawMaterialButton(
          onPressed: set.isSome() ? this.onPressed : null,
          shape: new CircleBorder(),
          child: child,
          elevation: elevation,
          fillColor: color,
          padding: const EdgeInsets.all(2.0),
          constraints: BoxConstraints(
            minWidth: 50,
            minHeight: 50,
          ),
        ),
      ),
    );
  }

  Widget _getRepsText(BuildContext context) {
    final rep = set.getOrElse(() => Rep(
          targetReps: 0,
          targetRest: 0,
        ));

    final repCount = rep.reps.getOrElse(() => rep.targetReps);

    return Text(repCount.toString(),
        style: TextStyle(
          color: rep.reps.isNone() ? Colors.grey.shade700 : Colors.white,
          fontSize: 20,
        ));
  }
}
