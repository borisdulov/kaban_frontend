import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/constants/app_assets.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 192,
      height: 96,
      child: Card(
        color: context.colorScheme.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: context.colorScheme.onSurface.withOpacity(0.2),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(AppRadius.r8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: AppSize.p12,
            left: AppSize.p12,
            bottom: AppSize.p8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(project.name),
              SizedBox(height: AppSize.p24),
              Image.asset(AppAssets.avatarAccount, width: AppSize.p24),
            ],
          ),
        ),
      ),
    );
  }
}
