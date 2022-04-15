import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/widgets/demo.dart';
import 'package:todo_app/widgets/todo.dart';

class DemoScreen extends StatelessWidget {
  DemoScreen({Key? key}) : super(key: key);
  static final updatedAt = DateTime(2003);
  static final createdAt = DateTime(2003);
  static const time = TimeOfDay(hour: 17, minute: 17);
  final todo = Todo(
      id: 1,
      title: 'Task 1',
      desc: 'Description 1',
      date: DateTime(2009),
      time: const TimeOfDay(hour: 19, minute: 19),
      updatedAt: createdAt,
      createdAt: createdAt);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: TodoWidget(
        item: todo,
        onTap: () {
          print('hello tap');
        },
        onChanged: (bool? cal) {
          print('changed');
        },
      )),
    );
  }
}
