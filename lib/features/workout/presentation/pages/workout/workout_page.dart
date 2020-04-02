import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/presentation/pages/recording/recording_page.dart';
import 'package:bodysculpting/features/workout/presentation/pages/workout/widgets/add_workout_fab.dart';
import 'package:bodysculpting/features/workout/presentation/pages/workout/widgets/workout_summary_tile.dart';
import 'package:bodysculpting/features/workout/presentation/pages/workout/workout_bloc.dart';
import 'package:bodysculpting/features/workout/presentation/pages/workout/workout_event.dart';
import 'package:bodysculpting/features/workout/presentation/pages/workout/workout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<WorkoutBloc>();
        bloc.add(Refresh());
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Body Sculpting IO'),
        ),
        body: SingleChildScrollView(
          child: _buildBody(),
        ),
        floatingActionButton: AddWorkoutFloatingActionButton(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocListener<WorkoutBloc, WorkoutState>(
      listener: (context, state) {
        if (state is Final) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecordingPage(template: state.workout),
            ),
          ).then((_) {
            BlocProvider.of<WorkoutBloc>(context).add(
              Refresh(),
            );
          });
        }
      },
      child: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state is Initial) {
            return _buildWorkoutSummaryList(
              context: context,
              summaries: state.workoutSummaries,
            );
          } else if (state is Ready) {
            return _buildWorkoutSummaryList(
              context: context,
              summaries: state.workoutSummaries,
            );
          } else if (state is Final) {
            return _buildWorkoutSummaryList(
              context: context,
              summaries: List<WorkoutSummary>(),
            );
          } else {
            return Column();
          }
        },
      ),
    );
  }

  Widget _buildWorkoutSummaryList({
    @required BuildContext context,
    List<WorkoutSummary> summaries,
  }) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: summaries.length,
            itemBuilder: (BuildContext context, int index) {
              return WorkoutSummaryTile(
                workoutSummary: summaries[index],
                onTap: () {
                  BlocProvider.of<WorkoutBloc>(context).add(
                    WorkoutSelected(summaries[index]),
                  );
                },
              );
            },
          ),
          Visibility(
            visible: summaries.length == 0,
            child: Text("It's loneyly here, please add some workouts!!!"),
          ),
        ],
      ),
    );
  }
}
