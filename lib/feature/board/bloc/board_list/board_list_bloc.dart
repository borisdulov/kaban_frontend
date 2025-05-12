import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/board_list_state.dart';
import 'package:kaban_frontend/feature/board/data/model/board_mock_model.dart';
import 'package:kaban_frontend/feature/board/data/repository/board_repository_mock_impl.dart';
import 'package:kaban_frontend/feature/board/domain/entity/board_entity.dart';
import 'package:kaban_frontend/feature/board/domain/repository/board_repository.dart';
import 'package:kaban_frontend/feature/board/data/model/board_api_model.dart';

extension BoardListExtension on BuildContext {
  BoardListCubit get boardListCubit => read<BoardListCubit>();
}

typedef BoardListBuilder = BlocBuilder<BoardListCubit, BoardListState>;

class BoardListCubit extends Cubit<BoardListState> {
  final BoardRepository _boardRepository;
  final bool _useMocks;

  BoardListCubit({
    required BoardRepository boardRepository,
    required bool useMocks,
  }) : _boardRepository = boardRepository,
       _useMocks = useMocks,
       super(const BoardListState(status: Status.loading)) {
    _initMocks();
    fetchBoards();
  }

  void _initMocks() {
    if (_useMocks && _boardRepository is BoardRepositoryMockImpl) {
      final mockRepo = _boardRepository;
      mockRepo
        ..createBoard(BoardMockModel.random())
        ..createBoard(BoardMockModel.random());
    }
  }

  Future<void> fetchBoards() async {
    emit(state.copyWith(status: Status.loading));
    try {
      final boards = await _boardRepository.getMyBoards();
      emit(BoardListState(status: Status.success, boards: boards));
    } catch (e) {
      emit(BoardListState(status: Status.failure, error: e.toString()));
    }
  }

  Future<void> fetchBoardById(String id) async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      final board = await _boardRepository.getBoardById(id);
      emit(
        state.copyWith(
          status: Status.success,
          boards: [...state.boards.where((p) => p.id != id), board],
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  Future<String?> createBoard() async {
    return createBoardWithTitle('New Board');
  }

  Future<String?> createBoardWithTitle(String title) async {
    if (!state.isLoaded) return null;

    try {
      emit(state.copyWith(status: Status.loading));

      final newBoard = BoardAPIModel(
        id: '',
        title: title,
        ownerId: '',
        userIds: [],
        columnIds: [],
      );

      final createdBoard = await _boardRepository.createBoard(newBoard);
      print('Created board: ${createdBoard.id}');

      emit(
        state.copyWith(
          status: Status.success,
          boards: [...state.boards, createdBoard],
        ),
      );

      return createdBoard.id;
    } catch (e) {
      print('Error creating board: $e');
      emit(state.copyWith(status: Status.failure, error: e.toString()));
      return null;
    }
  }

  void startEditing(String boardId) {
    emit(state.copyWith(editingBoardId: boardId));
  }

  Future<void> renameBoard(String boardId, String newTitle) async {
    final boardId = state.editingBoardId;
    if (boardId == null) return;

    try {
      final board = state.boards.firstWhere((p) => p.id == boardId);

      Board updatedBoard;
      if (board is BoardMockModel) {
        updatedBoard = board.copyWith(title: newTitle);
      } else if (board is BoardAPIModel) {
        updatedBoard = BoardAPIModel(
          id: board.id,
          title: newTitle,
          ownerId: board.ownerId,
          userIds: board.userIds,
          columnIds: board.columnIds,
        );
      } else {
        throw Exception('Unsupported board type');
      }

      await _boardRepository.updateBoard(updatedBoard);

      final newBoards =
          state.boards.map((p) => p.id == boardId ? updatedBoard : p).toList();
      emit(state.copyWith(boards: newBoards, editingBoardId: null));
    } catch (e) {
      emit(state.copyWith(editingBoardId: null, error: e.toString()));
    }
  }
}

typedef BoardSelector<T> = BlocSelector<BoardListCubit, BoardListState, T>;
typedef BoardListener = BlocListener<BoardListCubit, BoardListState>;
