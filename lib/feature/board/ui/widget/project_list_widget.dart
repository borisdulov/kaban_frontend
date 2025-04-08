import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/project_list_bloc.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/project_list_state.dart';
import 'package:kaban_frontend/feature/board/ui/widget/add_project_card.dart';
import 'package:kaban_frontend/feature/board/ui/widget/project_card.dart';

class ProjectListWidget extends StatelessWidget {
  const ProjectListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectListCubit, ProjectListState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(AppSize.p40),
          child: Card(
            elevation: 0,
            color: context.colorScheme.surfaceContainerLow,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 640),
              child: Padding(
                padding: const EdgeInsets.all(AppSize.p16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Boards', style: TextStyle(fontSize: AppSize.p24)),
                    SizedBox(height: AppSize.p32),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton.icon(
                          onPressed: context.boardListCubit.createProject,
                          style: TextButton.styleFrom(
                            foregroundColor: context.colorScheme.secondary,
                            iconColor: context.colorScheme.secondary,
                          ),
                          icon: Icon(Icons.add),
                          label: Text(
                            'Add new project',
                            style: TextStyle(fontSize: AppSize.p16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.p16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: AppSize.p4,
                          runSpacing: AppSize.p4,
                          children: [
                            ...state.boards.map(
                              (board) => BoardCard(board: board),
                            ),
                            AddProjectCard(
                              onPressed: context.boardListCubit.createProject,
                            ),
                          ],
                        ),
                      ),
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
