import 'package:bodysculpting/features/workout/domain/entities/workout.dart';
import 'package:bodysculpting/features/workout/domain/entities/workout_summary.dart';
import 'package:bodysculpting/features/workout/presentation/pages/recording/recording_page.dart';
import 'package:bodysculpting/features/workout/presentation/pages/templates/templates_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bodysculpting/injection_container.dart';

class TemplatesPage extends StatelessWidget {
  final Activity activity;
  const TemplatesPage({Key key, this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<TemplatesBloc>();
        bloc.add(GetTemplates(activity));
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select a workout'),
        ),
        body: _buildTemplatesList(),
      ),
    );
  }

  Widget _buildTemplatesList() {
    return BlocBuilder<TemplatesBloc, TemplatesState>(
      builder: (context, state) {
        if (state is Loaded) {
          return TemplatesList(templates: state.workoutTemplates);
        } else {
          return Column();
        }
      },
    );
  }
}

class TemplatesList extends StatelessWidget {
  final List<Workout> templates;
  TemplatesList({Key key, this.templates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: templates.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(templates[index].name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecordingPage(template: templates[index]),
              ),
            ).then((_) {
              Navigator.pop(context);
            });
          },
        );
      },
    ));
  }
}
