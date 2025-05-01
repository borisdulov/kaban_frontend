import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/config/bloc/config_bloc.dart';
import 'package:kaban_frontend/core/domain/entity/status.dart';
import 'package:kaban_frontend/feature/board/data/model/board_api_model.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/board_list_state.dart';
import 'package:kaban_frontend/feature/board/domain/repository/board_repository.dart';

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

      final updatedBoards = await _boardRepository.getMyBoards();
      emit(state.copyWith(status: Status.success, boards: updatedBoards));

      return createdBoard.id;
    } catch (e) {
      print('Error creating board: $e');
      emit(state.copyWith(status: Status.failure, error: e.toString()));
      return null;
    }
  }

  static BlocProvider<BoardListCubit> provider() {
    return BlocProvider(
      create: (context) {
        final repo = context.configCubit.get<BoardRepository>();
        return BoardListCubit(boardRepository: repo);
      },
    );
  }
}

typedef BoardSelector<T> = BlocSelector<BoardListCubit, BoardListState, T>;
typedef BoardListener = BlocListener<BoardListCubit, BoardListState>;
