import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kaban_frontend/core/constants/app_size.dart';
import 'package:kaban_frontend/core/extensions/build_context_exntension.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/board_list_bloc.dart';
import 'package:kaban_frontend/feature/board/bloc/board_list/board_list_state.dart';
import 'package:kaban_frontend/feature/board/ui/widget/add_board_card.dart';
import 'package:kaban_frontend/feature/board/ui/widget/board_card.dart';

class BoardListWidget extends StatelessWidget {
  const BoardListWidget({super.key});

  Future<void> _handleCreateBoard(BuildContext context) async {
    final titleController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final String? title = await showDialog<String>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Create New Board'),
            content: Form(
              key: formKey,
              child: TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Board Title',
                  hintText: 'Enter board title',
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.pop(titleController.text);
                  }
                },
                child: const Text('Create'),
              ),
            ],
          ),
    );

    if (title != null && title.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Creating board...'),
          duration: Duration(seconds: 1),
        ),
      );

      try {
        final String? boardId = await context.boardListCubit
            .createBoardWithTitle(title);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Board created successfully'),
              duration: Duration(seconds: 2),
            ),
          );

          if (boardId != null && boardId.isNotEmpty) {
            await Future.delayed(const Duration(milliseconds: 500));
            await context.boardListCubit.fetchBoardById(boardId);
          }
        }
      } catch (e) {
        if (context.mounted) {
          _showErrorSnackBar(context, 'Error creating board: $e');
        }
      }
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardListCubit, BoardListState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.isFailed) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Failed to load boards: ${state.error}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.boardListCubit.fetchBoards(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(AppSize.p8),
          child: Card(
            elevation: 0,
            color: context.colorScheme.surfaceContainerLow,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Padding(
                padding: const EdgeInsets.all(AppSize.p16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Boards',
                      style: TextStyle(fontSize: AppSize.p24),
                    ),
                    const SizedBox(height: AppSize.p32),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton.icon(
                          onPressed: () => _handleCreateBoard(context),
                          style: TextButton.styleFrom(
                            foregroundColor: context.colorScheme.secondary,
                            iconColor: context.colorScheme.secondary,
                          ),
                          icon: const Icon(Icons.add),
                          label: const Text(
                            'Add new board',
                            style: TextStyle(fontSize: AppSize.p16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.p16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: AppSize.p4,
                          runSpacing: AppSize.p4,
                          children: [
                            ...state.boards.map(
                              (board) => BoardCard(board: board),
                            ),
                            AddBoardCard(
                              onPressed: () => _handleCreateBoard(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
