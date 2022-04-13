import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo{
  @HiveField(0)
  int? id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String desc;
  @HiveField(3)
  late DateTime date;
  @HiveField(4)
  late TimeOfDay time;
  @HiveField(5)
  late bool completed;
  @HiveField(6)
  late DateTime createdAt;
  @HiveField(7)
  late DateTime updatedAt;

  Todo({required this.title,required  this.desc,required this.date,required this.time}){
    createdAt = DateTime.now();
    updatedAt = DateTime.now();
    completed = false;
  }

  Todo.fromTodo({required Todo todo}){
    title = todo.title;
    desc = todo.desc;
    date = todo.date;
    time = todo.time;
    completed = todo.completed;
    createdAt = todo.createdAt;
    updatedAt = todo.updatedAt;
  }

  @override
  String toString() {
     return "Todo{ id:$id,title:$title,desc:$desc }";
  } 
}