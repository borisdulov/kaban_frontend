import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/board/ui/widget/board_widget.dart';
import 'package:kaban_frontend/feature/board/data/model/project_mock_model.dart';
import 'package:kaban_frontend/feature/board/ui/widget/app_bar_widget.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  static const String name = 'Project';
  static const String path = '/project';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(project: ProjectMockModel.random()),
      body: BoardWidget(),
    );
  }
}
