import 'package:flutter/material.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaban_frontend/core/theme/domain/entity/app_theme_size.dart';
import 'package:kaban_frontend/core/theme/entity/app_theme_radius.dart';
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
          title: 'Я устал сидеть в фигме',
          priority: TaskPriority.high,
          categoryId: '',
          isCompleted: false,
          createdAt: DateTime.now(),
        ),
        TaskMockModel(
          taskId: '2',
          title: 'Название задачи.',
          priority: TaskPriority.medium,
          categoryId: '',
          isCompleted: false,
          createdAt: DateTime.now(),
        ),
        TaskMockModel(
          taskId: '3',
          title: 'Название задачи',
          categoryId: '',
          isCompleted: false,
          priority: TaskPriority.high,
          createdAt: DateTime.now(),
        ),
      ]),
      _buildColumn('In Progress', [
        TaskMockModel(
          taskId: '4',
          title: 'Устал уставать',
          priority: TaskPriority.high,
          categoryId: '',
          isCompleted: false,
          createdAt: DateTime.now(),
        ),
        TaskMockModel(
          taskId: '5',
          title: 'Название задачи',
          categoryId: '',
          isCompleted: false,
          priority: TaskPriority.low,
          createdAt: DateTime.now(),
        ),
      ]),
      _buildColumn('Done', [
        TaskMockModel(
          taskId: '6',
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
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppThemeSize.p40),
              child: AppFlowyBoard(
                controller: controller,
                background: Container(color: Colors.white),
                cardBuilder: (context, group, groupItem) {
                  return AppFlowyGroupCard(
                    key: ValueKey(groupItem.id),

                    margin: EdgeInsets.symmetric(vertical: AppThemeSize.p8),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppThemeRadius.r16),
                      border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.2)),
                    ),

                    child: _buildTaskCard(groupItem),
                  );
                },

                headerBuilder: (context, columnData) {
                  return AppFlowyGroupHeader(
                    icon: const Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 16,
                    ),

                    title: SizedBox(
                      width: 120,
                      child: Text(columnData.headerData.groupName),
                    ),

                    addIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add,
                        size: 20,
                        color: Color.fromRGBO(68, 68, 68, 1),
                      ),
                    ),

                    moreIcon: IconButton(
                      onPressed:
                          () => _addNewTask(columnData.headerData.groupId),
                      icon: Icon(
                        Icons.more_vert,
                        size: 20,
                        color: Color.fromRGBO(68, 68, 68, 1),
                      ),
                    ),

                    margin: const EdgeInsets.only(
                      left: AppThemeSize.p16,
                      right: AppThemeSize.p16,
                    ),
                  );
                },

                config: AppFlowyBoardConfig(
                  stretchGroupHeight: false,
                  groupBackgroundColor: Color.fromRGBO(248, 246, 245, 1),
                  groupMargin: EdgeInsets.all(AppThemeSize.p12),
                  groupCornerRadius: AppThemeRadius.r16,
                ),
                groupConstraints: BoxConstraints.tightFor(width: 300),
                trailing: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: AppThemeSize.p8,
                    horizontal: AppThemeSize.p16,
                  ),
                  decoration: BoxDecoration(),
                  child: _buildAddColumnButton(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(AppFlowyGroupItem item) {
    if (item is TaskItem) {
      return TaskWidget(task: item.task);
    }
    return const SizedBox.shrink();
  }

  Widget _buildAddColumnButton() {
    return SmoothCard(
      borderRadius: BorderRadius.circular(AppThemeRadius.r16),
      color: const Color.fromRGBO(248, 246, 245, 1),
      child: SizedBox(
        height: AppThemeSize.p40,
        child: IconButton(
          onPressed: _addNewColumn,
          icon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppThemeSize.p8),
            child: Row(
              children: [
                Icon(Icons.add, size: 20),
                SizedBox(width: AppThemeSize.p4),
                Text(
                  'Add Column',
                  style: GoogleFonts.inter(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          ),
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
