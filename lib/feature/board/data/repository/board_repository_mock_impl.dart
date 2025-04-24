import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/board/domain/repository/board_repository.dart';
import 'package:kaban_frontend/feature/board/data/model/board_mock_model.dart';

final class BoardRepositoryMockImpl implements BoardRepository {
  final List<BoardMockModel> _boards = [BoardMockModel.random()];

  @override
  Future<List<Board>> getMyBoards() async {
    return Future.value(_boards);
  }

  @override
  Future<Board> getBoardById(String id) async {
    return Future.value(
      _boards.firstWhere(
        (board) => board.id == id,
        orElse: () => BoardMockModel.random(),
      ),
    );
  }

  @override
  Future<Board> createBoard(Board board) async {
    final newBoard = BoardMockModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: board.title,
      ownerId: board.ownerId,
      userIds: board.userIds,
      columnIds: board.columnIds,
      owner: board.owner,
      users: board.users,
      columns: board.columns,
    );
    _boards.add(newBoard);
    return Future.value(newBoard);
  }

  @override
  Future<Board> updateBoard(String id, Board board) async {
    final index = _boards.indexWhere((p) => p.id == id);
    if (index != -1) {
      _boards[index] = BoardMockModel(
        id: id,
        title: board.title,
        ownerId: board.ownerId,
        userIds: board.userIds,
        columnIds: board.columnIds,
        owner: board.owner,
        users: board.users,
        columns: board.columns,
      );
      return Future.value(_boards[index]);
    }
    throw Exception("Board not found");
  }

  @override
  Future<void> deleteBoard(String id) async {
    _boards.removeWhere((board) => board.id == id);
    return Future.value();
  }

  @override
  Future<Board> addUser(String boardId, String userId) async {
    final board = _boards.firstWhere((p) => p.id == boardId);
    final updatedBoard = board.copyWith(userIds: [...board.userIds, userId]);
    final index = _boards.indexWhere((p) => p.id == boardId);
    _boards[index] = updatedBoard;
    return Future.value(updatedBoard);
  }

  @override
  Future<Board> removeUser(String boardId, String userId) async {
    final board = _boards.firstWhere((p) => p.id == boardId);
    final updatedBoard = board.copyWith(
      userIds: board.userIds.where((id) => id != userId).toList(),
    );
    final index = _boards.indexWhere((p) => p.id == boardId);
    _boards[index] = updatedBoard;
    return Future.value(updatedBoard);
  }
}
