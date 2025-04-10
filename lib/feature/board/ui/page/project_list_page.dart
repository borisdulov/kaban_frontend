import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/board/data/model/project_mock_model.dart';
import 'package:kaban_frontend/feature/board/ui/widget/app_bar_widget.dart';
import 'package:kaban_frontend/feature/board/ui/widget/project_list_widget.dart';

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({super.key});

  static const String name = 'ProjectList';
  static const String path = '/projectList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(project: ProjectMockModel.random()),
      body: ProjectListWidget(),
    );
  }
}
