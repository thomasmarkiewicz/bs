import 'package:bodysculpting/features/workout/domain/entities/workout_base.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/presentation/pages/templates/templates_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';

class AddWorkoutFloatingActionButton extends StatelessWidget {
  const AddWorkoutFloatingActionButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutBloc, WorkoutState>(builder: (context, state) {
      if (state is Initial) {
        return _buildFab(context);
      } else if (state is Ready) {
        final visible = state.workoutSummaries.length > 0 &&
            state.workoutSummaries[0].isFinished();
        return visible
            ? _buildFab(context)
            : _buildContinueFab(context, state.workoutSummaries[0]);
      } else if (state is Final) {
        final visible = state.workout.isFinished();
        return visible
            ? _buildFab(context)
            : _buildContinueFab(context, state.workout);
      } else {
        return _buildFab(context);
      }
    });
  }

  Widget _buildContinueFab(BuildContext context, WorkoutSummary summary) {
    return FloatingActionButton.extended(
        label: Text('Continue workout'),
        icon: Icon(Icons.arrow_upward),
        foregroundColor: Colors.white,
        tooltip: 'Continue workout',
        onPressed: () {
          BlocProvider.of<WorkoutBloc>(context).add(
            WorkoutSelected(summary),
          );
        });
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text('New workout'),
      icon: Icon(Icons.add),
      foregroundColor: Colors.white,
      tooltip: 'Add new workout',
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 224,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.ac_unit),
                    title: Text('Lift'),
                    onTap: () => _onActivityTapped(context, Activity.lift),
                  ),
                  ListTile(
                    leading: Icon(Icons.accessibility_new),
                    title: Text('Swim'),
                    onTap: () => _onActivityTapped(context, Activity.swim),
                    enabled: false,
                  ),
                  ListTile(
                    leading: Icon(Icons.assessment),
                    title: Text('Bike'),
                    onTap: () => _onActivityTapped(context, Activity.bike),
                    enabled: false,
                  ),
                  ListTile(
                    leading: Icon(Icons.radio),
                    title: Text('Run'),
                    onTap: () => _onActivityTapped(context, Activity.run),
                    enabled: false,
                  )
                ],
              ),
            );
          },
        ).then((_) {
          BlocProvider.of<WorkoutBloc>(context).add(
            Refresh(),
          );
        });
      },
    );
  }

  _onActivityTapped(BuildContext context, Activity activity) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TemplatesPage(activity: activity),
      ),
    ).then((_) {
      Navigator.pop(context);
    });
  }
}
