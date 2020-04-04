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
        } else if (state is Finished) {
          //return _buildSupersetsView(context: context, workout: state.workout);
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
        ],
      ),
    );
  }
}
