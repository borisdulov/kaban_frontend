import 'package:flutter/material.dart';
import 'package:appflowy_board/appflowy_board.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaban_frontend/core/theme/domain/entity/app_theme_size.dart';
import 'package:kaban_frontend/core/theme/entity/app_theme_radius.dart';
import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_entity.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/task/ui/widget/task_widget.dart';
import 'package:smooth_corner/smooth_corner.dart';

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
      _buildColumn('Backlog', [
        TaskMockModel.random(),
        TaskMockModel.random(),
        TaskMockModel.random(),
        TaskMockModel.random(),
      ]),
      _buildColumn('In Progress', [
        TaskMockModel.random(),
        TaskMockModel.random(),
      ]),
      _buildColumn('Done', [TaskMockModel.random()]),
    ];

    for (final column in columns) {
      controller.addGroup(column);
    }
  }

  AppFlowyGroupData _buildColumn(String name, List<Task> tasks) {
    return AppFlowyGroupData(
      id: name,
      name: name,
      items: List<AppFlowyGroupItem>.from(
        tasks.map((task) => TaskItem(task)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppThemeSize.p32),
      child: AppFlowyBoard(
        controller: controller,
        boardScrollController: boardController,
        cardBuilder: (context, group, groupItem) {
          return AppFlowyGroupCard(
            key: ValueKey(groupItem.id),
    
            margin: EdgeInsets.symmetric(vertical: AppThemeSize.p8),
    
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppThemeRadius.r16),
              border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
    
            child: _buildCard(groupItem),
          );
        },
    
        headerBuilder: (context, columnData) {
          return AppFlowyGroupHeader(
            onAddButtonClick: () {
              boardController.scrollToBottom(columnData.id);
            },
            icon: const Icon(Icons.circle, color: Colors.green, size: 16),
    
            title: SizedBox(
              width: 140,
              child: Expanded(
                child: Text(
                  columnData.headerData.groupName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
    
            moreIcon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed:
                          () => _addNewTask(columnData.headerData.groupId),
                      icon: Icon(
                        Icons.add,
                        size: 20,
                        color: Color.fromRGBO(68, 68, 68, 1),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        size: 20,
                        color: Color.fromRGBO(68, 68, 68, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    
            margin: const EdgeInsets.only(left: AppThemeSize.p16),
          );
        },
    
        config: AppFlowyBoardConfig(
          stretchGroupHeight: false,
          groupBackgroundColor: Color.fromRGBO(248, 246, 245, 1),
          groupMargin: EdgeInsets.all(AppThemeSize.p12),
          groupCornerRadius: AppThemeRadius.r16,
          cardMargin: EdgeInsets.all(0),
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
    );
  }

  Widget _buildCard(AppFlowyGroupItem item) {
    if (item is TaskItem) {
      return TaskWidget(task: item.task);
    }

    throw UnimplementedError();
  }

  Widget _buildAddColumnButton() {
    return SmoothCard(
      elevation: 0,
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
    final newTask = TaskMockModel(
      taskId: DateTime.now().toString(),
      title: 'New task',
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
