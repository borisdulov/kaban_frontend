import 'package:kaban_frontend/feature/category/domain/entity/category_entity.dart';
import 'package:kaban_frontend/feature/category/domain/repository/category_repository.dart';
import 'package:kaban_frontend/feature/category/data/model/category_api_model.dart';

// final class TaskCategoryRepositoryImpl implements TaskCategoryRepository {
//   final ApiClient _apiClient;

//   CategoryRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

//   @override
//   Future<List<TaskCategory>> getCategoriesByProjectId(String projectId) async {
//     final response = await _apiClient.get('/projects/$projectId/categories');
//     final List<dynamic> data = response.data;
//     return data.map((json) => TaskCategoryAPIModel.fromJSON(json)).toList();
//   }

//   @override
//   Future<TaskCategory> getCategoryById(String id) async {
//     final response = await _apiClient.get('/categories/$id');
//     return TaskCategoryAPIModel.fromJSON(response.data);
//   }

//   @override
//   Future<TaskCategory> createCategory(TaskCategory category) async {
//     final categoryModel = category as TaskCategoryAPIModel;
//     final response =
//         await _apiClient.post('/categories', data: categoryModel.toJSON());
//     return TaskCategoryAPIModel.fromJSON(response.data);
//   }

//   @override
//   Future<TaskCategory> updateCategory(TaskCategory category) async {
//     final categoryModel = category as TaskCategoryAPIModel;
//     final response =
//         await _apiClient.put('/categories/${category.id}', data: categoryModel.toJSON());
//     return TaskCategoryAPIModel.fromJSON(response.data);
//   }

//   @override
//   Future<void> deleteCategory(String id) async {
//     await _apiClient.delete('/categories/$id');
//   }

//   @override
//   Future<List<TaskCategory>> reorderCategories(
//       String projectId, List<String> categoryIds) async {
//     final response = await _apiClient.put(
//         '/projects/$projectId/categories/reorder',
//         data: {'categoryIds': categoryIds});
//     final List<dynamic> data = response.data;
//     return data.map((json) => TaskCategoryAPIModel.fromJSON(json)).toList();
//   }
// }
