import 'package:flutter/material.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:kaban_frontend/feature/task/data/model/task_api_model.dart';
import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/task/ui/widget/task_widget.dart';
import 'package:smooth_corner/smooth_corner.dart';

class MockBoardList extends StatefulWidget {
  const MockBoardList({super.key});

  @override
  State<MockBoardList> createState() => _MockBoardListState();
}

class _MockBoardListState extends State<MockBoardList> {
  final AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {},
    onMoveGroupItem: (groupId, fromIndex, toIndex) {},
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {},
  );

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    final columns = [
      _buildColumn('Backlog', [
        TaskMockModel(
          taskId: '1',
          title: 'Разработать дизайн',
          priority: TaskPriority.high,
          categoryId: '',
          isCompleted: false,
          createdAt: DateTime.now(),
        ),
        TaskMockModel(
          taskId: '2',
          title: 'Написать ТЗ',
          priority: TaskPriority.medium,
          categoryId: '',
          isCompleted: false,
          createdAt: DateTime.now(),
        ),
      ]),
      _buildColumn('In Progress', [
        TaskMockModel(
          taskId: '3',
          title: 'Реализация API',
          priority: TaskPriority.high,
          categoryId: '',
          isCompleted: false,
          createdAt: DateTime.now(),
        ),
      ]),
      _buildColumn('Done', [
        TaskMockModel(
          taskId: '4',
          title: 'Тестирование',
          priority: TaskPriority.low,
          categoryId: '',
          isCompleted: true,
          createdAt: DateTime.now(),
        ),
      ]),
    ];

    for (final column in columns) {
      controller.addGroup(column);
    }
  }

  AppFlowyGroupData _buildColumn(String name, List<Task> tasks) {
    return AppFlowyGroupData(
      id: name,
      name: name,
      items: tasks.map((task) => TaskItem(task)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AppFlowyBoard(
            background: Container(color: Colors.white),
            controller: controller,
            cardBuilder: (context, group, groupItem) {
              return AppFlowyGroupCard(
                key: ValueKey(groupItem.id),
                decoration: BoxDecoration(color: Colors.grey.shade100),
                child: _buildTaskCard(groupItem),
              );
            },
            headerBuilder: (context, columnData) {
              return SizedBox(
                width: 300,
                child: AppFlowyGroupHeader(
                  icon: const Icon(Icons.circle, color: Colors.green),
                  title: Text(columnData.headerData.groupName),
                  addIcon: Row(
                    children: [
                      SizedBox(width: 0 ),
                      const Icon(Icons.more_vert),
                    ],
                  ),
                  moreIcon: Row(
                    children: [SizedBox(width: 70), const Icon(Icons.add)],
                  ),
                  margin: const EdgeInsets.all(12),
                ),
              );
            },
            footerBuilder: (context, columnData) {
              return _buildAddTaskButton(columnData);
            },
            config: AppFlowyBoardConfig(
              groupBackgroundColor: Colors.grey.shade100,
              groupBodyPadding: const EdgeInsets.all(8),
            ),
            groupConstraints: BoxConstraints.tightFor(width: 300),
          ),
        ),
        _buildAddColumnButton(),
      ],
    );
  }

  Widget _buildTaskCard(AppFlowyGroupItem item) {
    if (item is TaskItem) {
      return TaskWidget(task: item.task);
    }
    return const SizedBox.shrink();
  }

  Widget _buildAddTaskButton(AppFlowyGroupData columnData) {
    return InkWell(
      onTap: () => _addNewTask(columnData.headerData.groupId),
      child: SmoothCard(
        margin: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Icon(Icons.add, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildAddColumnButton() {
    return SmoothCard(
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      child: InkWell(
        onTap: _addNewColumn,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Text('Добавить колонку', style: TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }

  void _addNewTask(String columnId) {
    final newTask = TaskAPIModel(
      taskId: DateTime.now().toString(),
      title: 'Новая задача',
      priority: TaskPriority.medium,
      categoryId: '',
      isCompleted: false,
      createdAt: DateTime.now(),
    );

    setState(() {
      controller.getGroupController(columnId)?.insert(0, TaskItem(newTask));
    });
  }

  void _addNewColumn() {
    final newColumn = _buildColumn('Новая колонка', []);

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
