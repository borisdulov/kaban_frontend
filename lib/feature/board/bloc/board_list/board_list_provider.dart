import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/config/bloc/config_bloc.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/board_list_bloc.dart';
import 'package:kaban_frontend/feature/board/data/repository/board_repository_mock_impl.dart';
import 'package:kaban_frontend/feature/board/domain/repository/board_repository.dart';

abstract final class BoardListProvider {
  static BlocProvider<BoardListBloc> get instance => BlocProvider(
    create: (context) {
      final config = context.configCubit.state;
      return BoardListBloc(
        boardRepository:
            config.useMocks
                ? BoardRepositoryMockImpl()
                : context.configCubit.get<BoardRepository>(),
        useMocks: config.useMocks,
      );
    },
  );
}
