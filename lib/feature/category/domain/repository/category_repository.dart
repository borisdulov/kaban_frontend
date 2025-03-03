import 'package:kaban_frontend/feature/category/domain/entity/category_entity.dart';

abstract interface class CategoryRepository {
  Future<List<Category>> getCategoriesByProjectId(String projectId);
  Future<Category> getCategoryById(String id);
  Future<Category> createCategory(Category category);
  Future<Category> updateCategory(Category category);
  Future<void> deleteCategory(String id);
  Future<List<Category>> reorderCategories(
      String projectId, List<String> categoryIds);
}
