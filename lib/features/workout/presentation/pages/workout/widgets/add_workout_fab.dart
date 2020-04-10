import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
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
        final showAddFab = state.workoutSummaries.length == 0 ||
            (state.workoutSummaries.length > 0 &&
                state.workoutSummaries[0].isFinished());
        return showAddFab
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
    final workoutPageContext = context;
    return FloatingActionButton.extended(
      label: Text('New workout', key: Key('new-workout-fab-label')),
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
                    onTap: () => _onActivityTapped(
                      bottomSheetContext: context,
                      workoutPageContext: workoutPageContext,
                      activity: Activity.lift,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.accessibility_new),
                    title: Text('Swim'),
                    onTap: () => _onActivityTapped(
                      bottomSheetContext: context,
                      workoutPageContext: workoutPageContext,
                      activity: Activity.swim,
                    ),
                    enabled: false,
                  ),
                  ListTile(
                    leading: Icon(Icons.assessment),
                    title: Text('Bike'),
                    onTap: () => _onActivityTapped(
                      bottomSheetContext: context,
                      workoutPageContext: workoutPageContext,
                      activity: Activity.bike,
                    ),
                    enabled: false,
                  ),
                  ListTile(
                    leading: Icon(Icons.radio),
                    title: Text('Run'),
                    onTap: () => _onActivityTapped(
                      bottomSheetContext: context,
                      workoutPageContext: workoutPageContext,
                      activity: Activity.run,
                    ),
                    enabled: false,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  _onActivityTapped({
    @required BuildContext bottomSheetContext,
    @required BuildContext workoutPageContext,
    @required Activity activity,
  }) {
    BlocProvider.of<WorkoutBloc>(workoutPageContext).add(
      ActivitySelected(activity),
    );
    Navigator.pop(bottomSheetContext);
  }
}
