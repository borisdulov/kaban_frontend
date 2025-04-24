import 'package:flutter/material.dart';
import 'package:kaban_frontend/feature/board/data/model/board_mock_model.dart';
import 'package:kaban_frontend/feature/board/ui/widget/app_bar_widget.dart';
import 'package:kaban_frontend/feature/board/ui/widget/board_list_widget.dart';

class BoardListPage extends StatelessWidget {
  const BoardListPage({super.key});

  static const String name = 'BoardList';
  static const String path = '/boardList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(board: BoardMockModel.random()),
      body: BoardListWidget(),
    );
  }
}
