import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/models/todo_model.dart';

class DatabaseHelper {
  Future<int> addTodo({required Todo todo}) async {
    try {
      final todoBox = await Hive.openBox<Todo>('todoBox');
      final hId = await todoBox.add(todo);
      todo.id = hId;
      await todoBox.putAt(hId, todo);
      return hId;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTodo(int key,
      {String? title,
      String? desc,
      DateTime? date,
      TimeOfDay? time,
      bool? completed}) async {
    try {
      final todoBox = await Hive.openBox<Todo>('todoBox');
      final todo = todoBox.get(key);
      if (todo == null) return;
      todo.update(
          title: title,
          desc: desc,
          date: date,
          time: time,
          completed: completed);
      await todoBox.put(key, todo);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> deleteTodo(int key) async {
    try {
      final todoBox = await Hive.openBox<Todo>('todoBox');
      await todoBox.delete(key);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Todo>> getAllTodos() async {
    try {
      final todoBox = await Hive.openBox<Todo>('todoBox');
      final todoList = todoBox.keys.map((key) {
        final todo = todoBox.get(key)!;
        todo.setId(key);
        return todo;
      }).toList();
      return todoList;
    } catch (err) {
      rethrow;
    }
  }
}
