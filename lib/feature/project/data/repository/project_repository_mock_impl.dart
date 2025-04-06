import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/project/data/model/project_mock_model.dart';
import 'package:kaban_frontend/feature/project/domain/entity/project_entity.dart';
import 'package:kaban_frontend/feature/project/domain/repository/project_repository.dart';

final class ProjectRepositoryMockImpl implements ProjectRepository {

  final List<Project> _projects = [];

  @override
  Future<Project> addMember(String projectId, String userId) {
    // TODO: implement addMember
    throw UnimplementedError();
  }

  @override
  Future<Project> createProject(Project project) async {
    _projects.add(project);
    return project;
  }

  @override
  Future<void> deleteProject(String id) {
    // TODO: implement deleteProject
    throw UnimplementedError();
  }

  @override
  Future<List<Project>> getAllProjects() async => _projects;

  @override
  Future<Project> getProjectById(String id) async {
    await Future.delayed(Durations.medium1);
    return ProjectMockModel.random();
  }

  @override
  Future<Project> removeMember(String projectId, String userId) {
    // TODO: implement removeMember
    throw UnimplementedError();
  }

  @override
  Future<Project> updateProject(String id, Project project) {
    // TODO: implement updateProject
    throw UnimplementedError();
  }
}
