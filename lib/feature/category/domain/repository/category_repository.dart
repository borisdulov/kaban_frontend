import 'package:kaban_frontend/feature/category/domain/entity/category_entity.dart';

abstract interface class TaskCategoryRepository {
  Future<List<TaskCategory>> getCategoriesByProjectId(String projectId);
  Future<TaskCategory> getCategoryById(String id);
  Future<TaskCategory> createCategory(TaskCategory category);
  Future<TaskCategory> updateCategory(TaskCategory category);
  Future<void> deleteCategory(String id);
  Future<List<TaskCategory>> reorderCategories(
      String projectId, List<String> categoryIds);
}
