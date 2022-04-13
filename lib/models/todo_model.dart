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

  void toggleComplete(){
    completed = !completed;
  }
  void update({String? title,String? desc,DateTime? date,TimeOfDay? time,bool? completed}){
    this.title = title ?? this.title;
    this.desc = desc ?? this.desc;
    this.date = date ?? this.date;
    this.time = time ?? this.time;
    this.completed = completed ?? this.completed;
    updatedAt = DateTime.now();
  }

  void setId(int id){
    this.id = id;
  }

  @override
  String toString() {
     return "Todo{ id:$id,title:$title,desc:$desc }";
  } 
}