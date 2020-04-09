import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:flutter/material.dart';

// TODO: Add animated background to a tile showing workout in progress
//  see: https://medium.com/@felixblaschke/fancy-background-animations-in-flutter-4163d50f5c37

class WorkoutSummaryTile extends StatelessWidget {
  final WorkoutSummary workoutSummary;
  final VoidCallback onTap;
  const WorkoutSummaryTile({
    Key key,
    @required this.workoutSummary,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle =
        workoutSummary.isActive() ? TextStyle(color: Colors.white) : null;
    final TextStyle textStyle =
        workoutSummary.isActive() ? TextStyle(color: Colors.white70) : null;
    return Card(
      color: workoutSummary.isActive()
          ? Theme.of(context).accentColor
          : Theme.of(context).cardColor,
      child: ListTile(
        //leading: FlutterLogo(size: 72.0),
        title: Text(workoutSummary.name, style: titleStyle),
        subtitle: Text(
          workoutSummary.description.getOrElse(() => "") +
              "\n" +
              workoutSummary.start
                  .getOrElse(() => DateTime.now())
                  .toIso8601String(),
          style: textStyle,
        ),
        //trailing: Icon(Icons.more_vert),
        isThreeLine: true,
        onTap: this.onTap,
      ),
    );
  }
}
