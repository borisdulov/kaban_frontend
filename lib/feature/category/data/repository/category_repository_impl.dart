import 'package:kaban_frontend/core/network/api_client.dart';
import 'package:kaban_frontend/feature/category/data/model/category_api_model.dart';
import 'package:kaban_frontend/feature/category/domain/entity/category_entity.dart'
    as category_entity;
import 'package:kaban_frontend/feature/category/domain/repository/category_repository.dart';
import 'package:kaban_frontend/feature/task/data/model/task_api_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:flutter/material.dart' hide Category;
import 'package:flutter/foundation.dart';

final class CategoryRepositoryImpl implements CategoryRepository {
  final ApiClient _apiClient;

  CategoryRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<category_entity.Category>> getCategoriesByProjectId(
    String projectId,
  ) async {
    final response = await _apiClient.get('/category/getByBoard/$projectId');
    final List<dynamic> data = response.data;
    return data.map((json) => CategoryAPIModel.fromJSON(json)).toList();
  }

  @override
  Future<category_entity.Category> getCategoryById(String id) async {
    final response = await _apiClient.get('/category/getColumn/$id');
    return CategoryAPIModel.fromJSON(response.data);
  }

  @override
  Future<category_entity.Category> createCategory(
    category_entity.Category category,
  ) async {
    final categoryModel = category as CategoryAPIModel;
    final response = await _apiClient.post(
      '/category/create',
      data: categoryModel.toJSON(),
    );
    return CategoryAPIModel.fromJSON(response.data);
  }

  @override
  Future<category_entity.Category> updateCategory(
    category_entity.Category category,
  ) async {
    final categoryModel = category as CategoryAPIModel;
    final response = await _apiClient.post(
      '/category/update',
      data: categoryModel.toJSON(),
    );
    return CategoryAPIModel.fromJSON(response.data);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _apiClient.get('/category/delete/$id');
  }

  @override
  Future<List<Task>> getTasksByCategoryId(String categoryId) async {
    try {
      final response = await _apiClient.get('/category/findTasks/$categoryId');

      if (response.data is! List) {
        debugPrint(
          'Неверный формат данных при получении задач: ${response.data}',
        );
        return [];
      }

      final List<dynamic> data = response.data;
      return data.map((json) {
        if (json is! Map<String, dynamic>) {
          debugPrint('Неверный формат элемента в списке задач: $json');
          return TaskAPIModel(
            taskId: '',
            title: 'Ошибка формата',
            categoryId: categoryId,
            isCompleted: false,
            priority: TaskPriority.medium,
            createdAt: DateTime.now(),
          );
        }
        return TaskAPIModel.fromJSON(json);
      }).toList();
    } catch (e) {
      debugPrint('Ошибка при получении задач для колонки $categoryId: $e');
      return [];
    }
  }

  @override
  Future<List<category_entity.Category>> reorderCategories(
    String projectId,
    List<String> categoryIds,
  ) async {
    final response = await _apiClient.post(
      '/category/reorder',
      data: {'projectId': projectId, 'categoryIds': categoryIds},
    );
    final List<dynamic> data = response.data;
    return data.map((json) => CategoryAPIModel.fromJSON(json)).toList();
  }
}
