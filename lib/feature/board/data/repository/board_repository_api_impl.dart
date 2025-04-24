import 'package:kaban_frontend/core/network/api_client.dart';
import 'package:kaban_frontend/feature/board/data/model/board_api_model.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/board/domain/repository/board_repository.dart';

final class BoardRepositoryImpl implements BoardRepository {
  final ApiClient _apiClient;

  BoardRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<List<Board>> getMyBoards() async {
    final response = await _apiClient.get('/board/');
    final List<dynamic> data = response.data;
    return data.map((json) => BoardAPIModel.fromJSON(json)).toList();
  }

  @override
  Future<Board> getBoardById(String id) async {
    final response = await _apiClient.get('/board/$id');
    return BoardAPIModel.fromJSON(response.data);
  }

  @override
  Future<Board> createBoard(Board board) async {
    final boardModel = board as BoardAPIModel;
    final response = await _apiClient.post(
      '/board/create',
      data: boardModel.toJSON(),
    );
    return BoardAPIModel.fromJSON(response.data);
  }

  @override
  Future<void> deleteBoard(String id) async {
    await _apiClient.get('/board/delete/$id');
  }

  @override
  Future<Board> updateBoard(Board board) async {
    final boardModel = board as BoardAPIModel;
    final response = await _apiClient.post(
      '/board/update',
      data: {'boardId': boardModel.id, 'title': boardModel.title},
    );
    return BoardAPIModel.fromJSON(response.data);
  }
}
