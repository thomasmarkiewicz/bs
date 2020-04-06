import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/presentation/pages/recording/recording_bloc.dart';
import 'package:bodysculpting/features/workout/presentation/pages/recording/widgets/superset_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bodysculpting/injection_container.dart';

class RecordingPage extends StatelessWidget {
  final Workout template;
  const RecordingPage({Key key, this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<RecordingBloc>();
        bloc.add(ChangeTemplate(template: template));
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${template.name}'),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RecordingBloc, RecordingState>(
      builder: (context, state) {
        if (state is Ready) {
          return _buildSupersetsView(context: context, workout: state.workout);
        } else if (state is Active) {
          return _buildSupersetsView(context: context, workout: state.workout);
        } else if (state is Updating) {
          return _buildSupersetsView(context: context, workout: state.workout);
        } else if (state is Finished) {
          Navigator.pop(context);
          return _buildSupersetsView(context: context, workout: state.workout);
        } else if (state is Archived) {
          return _buildSupersetsView(context: context, workout: state.workout);
        } else if (state is Deleted) {
          Navigator.pop(context);
          return _buildSupersetsView(context: context, workout: state.workout);
        } else {
          return Column();
        }
      },
    );
  }

  Widget _buildSupersetsView({
    @required BuildContext context,
    @required Workout workout,
  }) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: workout.supersets.length,
            itemBuilder: (BuildContext context, int index) {
              return SupersetTile(
                units: workout.units,
                superset: workout.supersets[index],
                onExerciseSetRepPressed: (exerciseSetIndex, repIndex) {
                  BlocProvider.of<RecordingBloc>(context).add(
                    RecordReps(
                      supersetIndex: index,
                      exerciseSetIndex: exerciseSetIndex,
                      repIndex: repIndex,
                    ),
                  );
                },
                onTargetWeightChanged: (exerciseSetIndex, value) {
                  BlocProvider.of<RecordingBloc>(context).add(
                    TargetWeightChanged(
                      supersetIndex: index,
                      exerciseSetIndex: exerciseSetIndex,
                      value: value,
                    ),
                  );
                },
              );
            },
          ),
          Visibility(
            visible: workout.isActive(),
            child: FlatButton(
              child: Text('Finish'),
              onPressed: () {
                BlocProvider.of<RecordingBloc>(context).add(WorkoutFinished());
              },
            ),
          ),
          Visibility(
            visible: workout.isFinished(),
            child: FlatButton(
              child: Text('Delete'),
              onPressed: () => _showConfirmDeleteDialog(context),
            ),
          ),
        ],
      ),
    );
  }

  _showConfirmDeleteDialog(BuildContext context) {
    final outerContext = context;
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete this workout?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You will loose it, forever!'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Keep'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<RecordingBloc>(outerContext).add(
                  WorkoutDeleted(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
