part of 'todos_bloc.dart';


class TodosState extends Equatable{
  final List<Todo> todolist;
  const TodosState({required this.todolist});

  @override
  // TODO: implement props
  List<Object?> get props => [todolist];

}

class TodosInitialState extends TodosState{
  TodosInitialState() : super(todolist: []);
}