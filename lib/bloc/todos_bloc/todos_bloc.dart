import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/helpers/database_helper.dart';
import 'package:todo_app/models/todo_model.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final DatabaseHelper databaseHelper;
  TodosBloc(this.databaseHelper) : super(TodosInitialState()) {
    on<AddTodo>((event, emit) async {
      var newList = state.todolist;
      try {
        final hId = await databaseHelper.addTodo(todo: event.todo);
        event.todo.setId(hId);
        newList = [event.todo, ...newList];
      } catch (e) {
        rethrow;
      }
      return emit(TodosState(todolist: newList));
    });

    on<ToggleCompleted>((event, emit) async {
      if(state.todolist.isEmpty) return;
      Todo todo = state.todolist.firstWhere((element) => element.id == event.id);
      state.todolist.removeWhere((element) => element.id == event.id);
      try {
        todo = await databaseHelper.updateTodo(todo.id!,completed:!(todo.completed));
      } catch (e) {
        rethrow;
      }
      state.todolist.add(todo);
      return emit(TodosState(todolist: state.todolist));
    });

    on<EditTodo>((event, emit) async {
      var todo =
          state.todolist.firstWhere((element) => element.id == event.id);
      state.todolist.removeWhere((element) => element.id == event.id);

      try {
        todo = await databaseHelper.updateTodo(todo.id!,
            title: event.title,
            desc: event.desc,
            date: event.date,
            time: event.time);
        state.todolist.add(todo);
      } catch (e) {
        rethrow;
      }

      return emit(TodosState(todolist: state.todolist));
    });

    on<DeleteTodo>((event, emit) async {
      try {
        await databaseHelper.deleteTodo(event.id!);
        state.todolist.removeWhere((element) => element.id == event.id);
      } catch (e) {
        rethrow;
      }
      return emit(TodosState(todolist: state.todolist));
    });

    on<GetAllTodos>((event, emit) async {
      List<Todo> newList = [];
      try {
        newList = await databaseHelper.getAllTodos();
      } catch (e) {
        rethrow;
      }
      newList.sort((a, b) {
        if (a.completed && b.completed) {
          return 0;
        } else if (a.completed) {
          return 1;
        } else if (b.completed) {
          return -1;
        } else {
          return 0;
        }
      });
      return emit(TodosState(todolist: newList));
    });
  }
}
