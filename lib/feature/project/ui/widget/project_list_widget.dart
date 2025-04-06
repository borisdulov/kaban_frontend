import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/project/bloc/project_list/project_list_bloc.dart';
import 'package:kaban_frontend/feature/project/bloc/project_list/project_list_state.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/project/ui/widget/add_project_card.dart';
import 'package:kaban_frontend/feature/project/ui/widget/project_card.dart';

class ProjectListWidget extends StatelessWidget {
  const ProjectListWidget({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectListCubit, ProjectListState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppSize.p40),
          child: Card(
            color: context.colorScheme.surfaceContainerLow,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 640),
              child: Padding(
                padding: const EdgeInsets.all(AppSize.p16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Projects', style: TextStyle(fontSize: AppSize.p24)),
                    SizedBox(height: AppSize.p32),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton.icon(
                          //TODO сделать кнопку добавления нового проекта
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: context.colorScheme.secondary,
                            iconColor: context.colorScheme.secondary,
                          ),
                          icon: Icon(Icons.add_circle_outline),
                          label: Text(
                            'Add new project',
                            style: TextStyle(fontSize: AppSize.p16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.p16),
                    Wrap(
                      spacing: AppSize.p4,
                      runSpacing: AppSize.p4,
                      children: [
                        ProjectCard(project: project),
                        ProjectCard(project: project),
                        ProjectCard(project: project),
                        AddProjectCard(
                          onPressed:
                              () => context
                                  .read<ProjectListCubit>()
                                  .createProject(project),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
