import 'package:kaban_frontend/core/domain/entity/dependency.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';

abstract interface class BoardRepository implements Dependency {
  Future<List<Board>> getMyBoards();
  Future<Board> getBoardById(String id);
  Future<Board> createBoard(Board board);
  Future<Board> updateBoard(Board board);
  Future<void> deleteBoard(String id);
}
