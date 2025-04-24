import 'package:kaban_frontend/core/domain/entity/dependency.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';

abstract interface class BoardRepository implements Dependency {
  Future<List<Board>> getAllBoards();
  Future<Board> getBoardById(String id);
  Future<Board> createBoard(Board board);
  Future<Board> updateBoard(String id, Board board);
  Future<void> deleteBoard(String id);
  Future<Board> addUser(String boardId, String userId);
  Future<Board> removeUser(String boardId, String userId);
}
