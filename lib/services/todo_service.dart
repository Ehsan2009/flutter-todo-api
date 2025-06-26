import 'dart:convert';

import 'package:flutter_todo_api/models/todo.dart';
import 'package:http/http.dart' as http;

class TodoService {
  final baseUrl = 'https://677c1f9320824100c07bf936.mockapi.io/test-api/todo';

  Future<List<Todo>> getTodos() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List decodedJson = jsonDecode(response.body);

      return decodedJson.map((todo) {
        return Todo.fromJson(todo);
      }).toList();
    } else {
      throw Exception('Failed to load todos: ${response.statusCode}');
    }
  }

  Future<void> addTodo(String title, String description) async {
    final request = {'title': title, 'description': description};

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add todo: ${response.body}');
    }
  }

  Future<void> updateTodo(String id, String title, String description) async {
    final request = {'title': title, 'description': description};

    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request),
    );

    print('Status: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo: ${response.body}');
    }
  }

  Future<void> deleteTodo(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Deleting todo failed: ${response.statusCode}');
    }
  }
}
