import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kaban_frontend/example.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  static const String name = 'Project';
  static const String path = '/project';

  @override
  Widget build(BuildContext context) {
    return Example();
  }
}
