import 'package:flutter/material.dart';

import 'package:appflowy_board/appflowy_board.dart';

class SingleBoardListExample extends StatefulWidget {
  const SingleBoardListExample({super.key});

  @override
  State<SingleBoardListExample> createState() => _SingleBoardListExampleState();
}

class _SingleBoardListExampleState extends State<SingleBoardListExample> {
  final AppFlowyBoardController boardData = AppFlowyBoardController();

  @override
  void initState() {
    super.initState();
    final column = AppFlowyGroupData(
      id: "1",
      name: "1",
      items: [TextItem("a"), TextItem("b"), TextItem("c"), TextItem("d")],
    );

    boardData.addGroup(column);
  }

  @override
  Widget build(BuildContext context) {
    return AppFlowyBoard(
      controller: boardData,
      cardBuilder: (context, column, columnItem) {
        return _RowWidget(
          item: columnItem as TextItem,
          key: ObjectKey(columnItem),
        );
      },
    );
  }
}

class _RowWidget extends StatelessWidget {
  final TextItem item;
  const _RowWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ObjectKey(item),
      height: 60,
      color: Colors.green,
      child: Center(child: Text(item.s)),
    );
  }
}

class TextItem extends AppFlowyGroupItem {
  final String s;

  TextItem(this.s);

  @override
  String get id => s;
}
