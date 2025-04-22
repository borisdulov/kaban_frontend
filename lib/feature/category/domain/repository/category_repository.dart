import 'package:kaban_frontend/core/domain/entity/dependency.dart';
import 'package:kaban_frontend/feature/category/domain/entity/category_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';

abstract interface class CategoryRepository implements Dependency {
  Future<List<Category>> getCategoriesByProjectId(String projectId);
  Future<Category> getCategoryById(String id);
  Future<Category> createCategory(Category category);
  Future<Category> updateCategory(Category category);
  Future<void> deleteCategory(String id);
  Future<List<Task>> getTasksByCategoryId(String categoryId);
  Future<List<Category>> reorderCategories(
    String projectId,
    List<String> categoryIds,
  );
}
