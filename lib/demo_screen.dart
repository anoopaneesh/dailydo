import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/widgets/demo.dart';
import 'package:todo_app/widgets/todo.dart';
import 'package:todo_app/widgets/todolist.dart';

class DemoScreen extends StatelessWidget {
  DemoScreen({Key? key}) : super(key: key);
  static final updatedAt = DateTime(2003);
  static final createdAt = DateTime(2003);
  static const time = TimeOfDay(hour: 17, minute: 17);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:Todolist(list: mockTodosData, onTodoClick: (item){
            print('ontap');
          }, onTodoToggle: (item){
            print('ontoggle');
          }, onTodoDelete: (item){
            print('ondelete');
          }) 
        ),
    );
  }
}
