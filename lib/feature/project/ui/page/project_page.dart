import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/project/ui/widget/category_widget.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  static const String name = 'Project';
  static const String path = '/project';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Project'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 16),
              Category(
                title: 'Backlog',
                color: const Color(0xFFFFA200),
                onAddTask: () {},
                onMoreTap: () {},
              ),
              Category(
                title: 'In Progress',
                color: const Color(0xFF007BFF),
                onAddTask: () {},
                onMoreTap: () {},
              ),
              Category(
                title: 'Done',
                color: const Color(0xFF33FF00),
                onAddTask: () {},
                onMoreTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: 150,
                  height: 40,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      size: 20,
                      color: Color(0xFF444444),
                    ),
                    label: const Text(
                      'Add Column',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFF8F6F5),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
