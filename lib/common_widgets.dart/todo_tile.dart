import 'package:flutter/material.dart';
import 'package:flutter_todo_api/models/todo.dart';
import 'package:flutter_todo_api/screens/add_edit_todo_screen.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.todo,
    required this.number,
    required this.onDelete,
    required this.refreshTodos,
  });

  final Todo todo;
  final int number;
  final void Function() onDelete;
  final void Function() refreshTodos;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 54, 53, 53),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              child: Text(number.toString(), style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todo.title, style: TextStyle(color: Colors.white)),
                Text(
                  todo.description,
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
            Spacer(),
            PopupMenuButton(
              color: const Color.fromARGB(255, 54, 53, 53),
              icon: Icon(Icons.more_horiz, color: Colors.white),
              onSelected: (value) async {
                if (value == 'edit') {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddEditTodoScreen(isEditMode: true, todo: todo);
                      },
                    ),
                  ).then((value) {
                    if (value == true) {
                      refreshTodos();
                    }
                  });
                } else if (value == 'delete') {
                  onDelete();
                }
              },
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit', style: TextStyle(color: Colors.white)),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ];
              },
            ),
            // Icon(Icons.more_horiz, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
