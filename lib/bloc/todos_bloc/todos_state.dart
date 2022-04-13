part of 'todos_bloc.dart';


class TodosState {
  final List<Todo> todolist;
  TodosState({required this.todolist});
}

class TodosInitialState extends TodosState{
  TodosInitialState() : super(todolist: []);
}