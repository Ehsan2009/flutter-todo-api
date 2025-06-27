import 'package:flutter/material.dart';
import 'package:flutter_todo_api/common_widgets.dart/todo_tile.dart';
import 'package:flutter_todo_api/models/todo.dart';
import 'package:flutter_todo_api/screens/add_edit_todo_screen.dart';
import 'package:flutter_todo_api/services/todo_service.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  Future<List<Todo>>? todos;

  @override
  void initState() {
    super.initState();

    fetchTodos();
  }

  void fetchTodos() {
    setState(() {
      todos = TodoService().getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text('Todo List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 54, 53, 53),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: todos,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!asyncSnapshot.hasData || asyncSnapshot.data!.isEmpty) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 240),
                    child: Text(
                      'No Todo Item',
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                  ),
                );
              }

              final todoList = asyncSnapshot.data;

              return Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                  itemCount: todoList!.length,
                  itemBuilder: (ctx, value) {
                    return TodoTile(
                      todo: todoList[value],
                      number: value + 1,
                      onDelete: () async {
                        await TodoService().deleteTodo(todoList[value].id);
                        fetchTodos();
                      },
                      refreshTodos: fetchTodos,
                    );
                  },
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 56,
              width: 100,
              margin: const EdgeInsets.all(30),
              child: FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddEditTodoScreen(isEditMode: false);
                      },
                    ),
                  ).then((value) {
                    if (value == true) {
                      fetchTodos();
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: const Color.fromARGB(255, 5, 238, 180),
                child: Text(
                  'Add Todo',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
