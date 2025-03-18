import 'dart:math';

import 'package:flutter/material.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:kaban_frontend/core/theme/domain/entity/app_theme_size.dart';
import 'package:kaban_frontend/core/constants/app_radius.dart';
import 'package:kaban_frontend/feature/project/ui/widget/add_column_button.dart';
import 'package:kaban_frontend/feature/project/ui/widget/column_board_header.dart';
import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/ui/widget/task_widget.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({super.key});

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  final AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );

  late AppFlowyBoardScrollController boardController;

  @override
  void initState() {
    super.initState();
    boardController = AppFlowyBoardScrollController();
    _initializeBoard();
  }

  void _initializeBoard() {
    final columns = [
      _createColumnData('Backlog', [
        TaskMockModel.random(),
        TaskMockModel.random(),
        TaskMockModel.random(),
        TaskMockModel.random(),
      ]),
      _createColumnData('In Progress', [
        TaskMockModel.random(),
        TaskMockModel.random(),
      ]),
      _createColumnData('Done', [TaskMockModel.random()]),
    ];

    for (final column in columns) {
      controller.addGroup(column);
    }
  }

  AppFlowyGroupData _createColumnData(String name, List<Task> tasks) {
    return AppFlowyGroupData(
      id: name + Random().nextInt(300).toString(),
      name: name,
      items: List<AppFlowyGroupItem>.from(tasks.map((e) => TaskItem(e))),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppFlowyBoard(
      controller: controller,
      boardScrollController: boardController,
      cardBuilder: (context, group, groupItem) {
        if (groupItem is TaskItem) {
          return TaskWidget(task: groupItem.task, key: ValueKey(groupItem.id));
        }
        return Text(
          'Error: groupItem is not TaskItem',
          key: ValueKey(groupItem.id),
        );
      },

      headerBuilder: (context, columnData) {
        return ColumnBoardHeader(
          key: ValueKey(columnData.id),
          onTaskCreate: () => _addNewTask(columnData.id),
          onMenuPressed: () {},
          title: columnData.headerData.groupName,
        );
      },

      config: AppFlowyBoardConfig(
        stretchGroupHeight: false,
        groupBackgroundColor: Color.fromRGBO(248, 246, 245, 1),
        groupMargin: EdgeInsets.all(AppThemeSize.p12),
        groupCornerRadius: AppRadius.r16,
        cardMargin: EdgeInsets.all(0),
      ),

      groupConstraints: BoxConstraints.tightFor(width: 300),

      trailing: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppThemeSize.p8,
          horizontal: AppThemeSize.p16,
        ),
        decoration: BoxDecoration(),
        child: AddColumnButton(onPressed: _addNewColumn),
      ),
    );
  }

  void _addNewTask(String columnId) {
    final newTask = TaskMockModel.random();

    setState(() {
      controller.getGroupController(columnId)?.insert(0, TaskItem(newTask));
    });
  }

  void _addNewColumn() {
    final newColumn = _createColumnData('Новая колонка', []);

    setState(() {
      controller.addGroup(newColumn);
    });
  }
}

class TaskItem extends AppFlowyGroupItem {
  final Task task;

  TaskItem(this.task);

  @override
  String get id => task.taskId;
}
