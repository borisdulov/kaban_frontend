import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/board/data/model/board_mock_model.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/board_list_state.dart';
import 'package:kaban_frontend/feature/board/domain/repository/board_repository.dart';
import 'package:kaban_frontend/feature/board/data/repository/board_repository_mock_impl.dart'
    as board;

extension BoardListExtension on BuildContext {
  BoardListCubit get boardListCubit => read<BoardListCubit>();
}

typedef BoardListBuilder = BlocBuilder<BoardListCubit, BoardListState>;

class BoardListCubit extends Cubit<BoardListState> {
  final BoardRepository _boardRepository;

  BoardListCubit({required BoardRepository boardRepository})
    : _boardRepository = boardRepository,
      super(const BoardListState(status: Status.loading)) {
    fetchBoards();
  }

  Future<void> fetchBoards() async {
    emit(state.copyWith(status: Status.loading));
    try {
      final boards = await _boardRepository.getAllBoards();
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

  Future<void> createBoard() async {
    if (!state.isLoaded) return;

    try {
      emit(state.copyWith(status: Status.loading));
      final newBoard = BoardMockModel.random();
      await _boardRepository.createBoard(newBoard);

      final updatedBoards = await _boardRepository.getAllBoards();
      emit(state.copyWith(status: Status.success, boards: updatedBoards));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }

  static BlocProvider<BoardListCubit> provider({required String boardId}) {
    return BlocProvider(
      create:
          (context) =>
              BoardListCubit(boardRepository: board.BoardRepositoryMockImpl()),
    );
  }
}

typedef BoardSelector<T> = BlocSelector<BoardListCubit, BoardListState, T>;
typedef BoardListener = BlocListener<BoardListCubit, BoardListState>;
