// import 'package:flutter/material.dart';
// import 'package:kanban_board/custom/board.dart';
// import 'package:kanban_board/models/inputs.dart';

// class Example extends StatefulWidget {
//   const Example({super.key});

//   @override
//   State<Example> createState() => _ExampleState();
// }

// class _ExampleState extends State<Example> {
//   @override
//   Widget build(BuildContext context) {
//     return KanbanBoard(
//       List.generate(
//         8,
//         (index) => BoardListsData(
//             items: List.generate(
//           5,
//           (index) => Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(4),
//                 border: Border.all(
//                   color: Colors.grey.shade200,
//                 )),
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//                 "Lorem ipsum dolor sit amet, sunt in culpa qui officia deserunt mollit anim id est laborum. $index",
//                 style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500)),
//           ),
//         )),
//       ),
//       onItemLongPress: (cardIndex, listIndex) {},
//       onItemReorder:
//           (oldCardIndex, newCardIndex, oldListIndex, newListIndex) {},
//       onListLongPress: (listIndex) {},
//       onListReorder: (oldListIndex, newListIndex) {},
//       onItemTap: (cardIndex, listIndex) {},
//       onListTap: (listIndex) {},
//       onListRename: (oldName, newName) {},
//       backgroundColor: Colors.white,
//       displacementY: 124,
//       displacementX: 100,
//       textStyle: const TextStyle(
//           fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:kaban_frontend/feature/task/data/model/task_mock_model.dart';
import 'package:kaban_frontend/feature/task/domain/entity/task_priority_enum.dart';
import 'package:kaban_frontend/feature/task/ui/widget/task_widget.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final BoardViewController boardViewController = BoardViewController();
  final List<BoardList> _lists = [];

  @override
  void initState() {
    super.initState();
    initializeBoard();
  }

  void initializeBoard() {
    List<BoardItem> items = List.generate(5, (index) {
      return BoardItem(
          item: TaskWidget(
              task: TaskMockModel(
                  taskId: 'taskId',
                  title: 'title',
                  categoryId: 'categoryId',
                  isCompleted: false,
                  priority: TaskPriority.low,
                  createdAt: DateTime.now())));
    });

    for (int i = 0; i < 3; i++) {
      _lists.add(
        BoardList(
          headerBackgroundColor: Colors.blue,
          backgroundColor: Colors.grey[200],
          header: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'List $i',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
          items: List.from(items),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BoardView(
      lists: _lists,
      boardViewController: boardViewController,
    );
  }
}
