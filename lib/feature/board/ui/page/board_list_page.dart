import 'package:flutter/material.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/board/ui/widget/board_list_widget.dart';
import 'package:kaban_frontend/feature/board/ui/widget/search_widget.dart';

class BoardListPage extends StatelessWidget {
  const BoardListPage({super.key});

  static const String name = 'BoardList';
  static const String path = '/boardList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchWidget(),
        centerTitle: true,
        toolbarHeight: 64,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: context.colorScheme.onSurface.withOpacity(0.2),
            height: 1,
          ),
        ),
      ),
      body: BoardListWidget(),
    );
  }
}
