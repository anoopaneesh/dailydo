part of 'todos_bloc.dart';

@immutable
abstract class TodosEvent {}


class AddTodo extends TodosEvent {
  final Todo todo;

  AddTodo(this.todo);
}

class ToggleCompleted extends TodosEvent{
  final int? id;

  ToggleCompleted(this.id);
} 

class EditTodo extends TodosEvent{
  final String title;
  final String desc;
  final TimeOfDay time;
  final DateTime date;
  final int? id;

  EditTodo(this.id,{required this.title,required this.time,required this.date,required this.desc});
}

class DeleteTodo extends TodosEvent{
  final int? id;

  DeleteTodo(this.id);
}

class GetAllTodos extends TodosEvent{}