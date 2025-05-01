import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kaban_frontend/core/network/api_client.dart';
import 'package:kaban_frontend/feature/board/data/model/board_api_model.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/board/domain/repository/board_repository.dart';

final class BoardRepositoryImpl implements BoardRepository {
  final ApiClient _apiClient;

  BoardRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<List<Board>> getMyBoards() async {
    try {
      final response = await _apiClient.get('/board/');
      debugPrint('Get boards response: ${response.data}');
      final List<dynamic> data = response.data;
      return data.map((json) => BoardAPIModel.fromJSON(json)).toList();
    } catch (e) {
      debugPrint('Error fetching boards: $e');
      return [];
    }
  }

  @override
  Future<Board> getBoardById(String id) async {
    try {
      if (id.length != 24) {
        throw Exception(
          'Invalid board ID format. Must be a 24-character MongoDB ObjectId.',
        );
      }

      final response = await _apiClient.get('/board/$id');
      return BoardAPIModel.fromJSON(response.data);
    } catch (e) {
      debugPrint('Error fetching board $id: $e');
      rethrow;
    }
  }

  @override
  Future<Board> createBoard(Board board) async {
    try {
      final boardModel = board as BoardAPIModel;
      debugPrint('Creating board with data: ${boardModel.toJSON()}');

      final response = await _apiClient.post(
        '/board/create',
        data: boardModel.toJSON(),
      );

      debugPrint('Board creation response: ${response.data}');
      return BoardAPIModel.fromJSON(response.data);
    } catch (e) {
      debugPrint('Error creating board: $e');
      if (e is DioException) {
        debugPrint('DioError details: ${e.response?.data}');
      }
      rethrow;
    }
  }

  @override
  Future<void> deleteBoard(String id) async {
    try {
      if (id.length != 24) {
        throw Exception(
          'Invalid board ID format. Must be a 24-character MongoDB ObjectId.',
        );
      }

      await _apiClient.get('/board/delete/$id');
    } catch (e) {
      debugPrint('Error deleting board $id: $e');
      rethrow;
    }
  }

  @override
  Future<Board> updateBoard(Board board) async {
    try {
      final boardModel = board as BoardAPIModel;

      if (boardModel.id.length != 24) {
        throw Exception(
          'Invalid board ID format. Must be a 24-character MongoDB ObjectId.',
        );
      }

      final response = await _apiClient.post(
        '/board/update',
        data: {'boardId': boardModel.id, 'title': boardModel.title},
      );
      return BoardAPIModel.fromJSON(response.data);
    } catch (e) {
      debugPrint('Error updating board: $e');
      rethrow;
    }
  }
}
