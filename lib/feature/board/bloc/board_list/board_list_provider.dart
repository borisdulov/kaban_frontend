import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaban_frontend/core/config/bloc/config_bloc.dart';
import 'package:kaban_frontend/feature/board/domain/repository/board_repository.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/board_list_bloc.dart';

abstract final class BoardListProvider {
  static BlocProvider<BoardListCubit> get instance => BlocProvider(
    create: (context) {
      var repo = context.configCubit.get<BoardRepository>();
      return BoardListCubit(boardRepository: repo);
    },
  );
}
