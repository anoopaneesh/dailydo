import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/models/todo_model.dart';


void main() {
  group('Todo Model Test', () {
    test('Create new todo', () {
      final date = DateTime.now();
      final time = TimeOfDay.now();
      final todo = Todo(title: 'ttitle', desc: 'tdesc', date: date, time: time);
      expect(todo.title, 'ttitle');
      expect(todo.desc, 'tdesc');
      expect(todo.date, date);
      expect(todo.time, time);
      expect(todo.completed, false);
      expect(todo.id, null);
    });

    test('todo toggle compelete', () {
      final todo = Todo(
          title: 'ttitle',
          desc: 'tdesc',
          date: DateTime.now(),
          time: TimeOfDay.now());
      expect(todo.completed, false);
      todo.toggleComplete();
      expect(todo.completed, true);
      todo.toggleComplete();
      expect(todo.completed, false);
    });

    test('Update todo', () {
      final todo = Todo(
          title: 'ttitle',
          desc: 'tdesc',
          date: DateTime.now(),
          time: TimeOfDay.now());
      todo.update(title: 'updated_title');
      expect(todo.title, 'updated_title');
      todo.update(desc: 'updated_desc');
      expect(todo.desc, 'updated_desc');
      todo.update(date: DateTime(2000));
      expect(todo.date, DateTime(2000));
      todo.update(time: const TimeOfDay(hour: 10, minute: 10));
      expect(todo.time, const TimeOfDay(hour: 10, minute: 10));
    });
  });
}
