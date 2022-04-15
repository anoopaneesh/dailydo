import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

class MockData {
  static final updatedAt = DateTime(2003);
  static final createdAt = DateTime(2003);
  static const time =  TimeOfDay(hour: 17, minute: 17);
  static final mockTodosData = [
    Todo(
        id: 1,
        title: 'Task 1',
        desc: 'Description 1',
        date: DateTime(2009),
        time: const TimeOfDay(hour: 19, minute: 19),
        updatedAt: createdAt,
        createdAt: createdAt),
    Todo(
        id: 2,
        title: 'Task 2',
        desc: 'Description 2',
        date: DateTime(2009),
        time: const TimeOfDay(hour: 19, minute: 19),
        updatedAt: createdAt,
        createdAt: createdAt)
  ];
  static final toggledData = [
    Todo(
        id: 2,
        title: 'Task 2',
        desc: 'Description 2',
        date: DateTime(2009),
        time: const TimeOfDay(hour: 19, minute: 19),
        updatedAt: createdAt,
        createdAt: createdAt),
    Todo(
        id: 1,
        title: 'Task 1',
        desc: 'Description 1',
        date: DateTime(2009),
        time: const TimeOfDay(hour: 19, minute: 19),
        createdAt: createdAt,
        updatedAt: updatedAt,
        completed: true)
  ];
  static final editedData = [
    Todo(
        id: 2,
        title: 'Task 2',
        desc: 'Description 2',
        date: DateTime(2009),
        time: const TimeOfDay(hour: 19, minute: 19),
        updatedAt: createdAt,
        createdAt: createdAt),
    Todo(
        id: 1,
        title: 'Edited Title',
        desc: 'Edited Desc',
        date: createdAt,
        time: time,
        createdAt: createdAt,
        updatedAt: updatedAt,
        completed: false)
  ];
  static final deletedData = [
    Todo(
        id: 2,
        title: 'Task 2',
        desc: 'Description 2',
        date: DateTime(2009),
        time: const TimeOfDay(hour: 19, minute: 19),
        updatedAt: createdAt,
        createdAt: createdAt)
  ];
}
