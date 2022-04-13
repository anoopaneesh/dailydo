import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/models/todo_model.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosInitialState()) {
    on<AddTodo>((event, emit) async {
      var newList = state.todolist;
      try {
        final todoBox = await Hive.openBox<Todo>('todoBox');
        final hId = await todoBox.add(event.todo);
        event.todo.id = hId;
        await todoBox.putAt(hId, event.todo);
        newList = [event.todo, ...newList];
      } catch (e) {
        rethrow;
      }
      return emit(TodosState(todolist: newList));
    });

    on<ToggleCompleted>((event, emit) async {
      Todo todo =
          state.todolist.firstWhere((element) => element.id == event.id);
      todo.completed = !todo.completed;
      try {
        final todoBox = await Hive.openBox<Todo>('todoBox');
        await todoBox.put(todo.id, todo);
      } catch (e) {
        rethrow;
      }
      List<Todo> newList = [];
      for (var element in state.todolist) {
        if (element.id != event.id) {
          newList.add(element);
        }
      }
      newList.add(todo);
      return emit(TodosState(todolist: newList));
    });

    on<EditTodo>((event, emit) async {
      final index =
          state.todolist.indexWhere((element) => element.id == event.id);
      state.todolist[index].title = event.title;
      state.todolist[index].desc = event.desc;
      state.todolist[index].date = event.date;
      state.todolist[index].time = event.time;
      state.todolist[index].updatedAt = DateTime.now();

      try {
        final todoBox = await Hive.openBox<Todo>('todoBox');
        await todoBox.put(state.todolist[index].id, state.todolist[index]);
      } catch (e) {
        rethrow;
      }

      return emit(TodosState(todolist: state.todolist));
    });

    on<DeleteTodo>((event, emit) async {
      state.todolist.removeWhere((element) => element.id == event.id);
      try {
        final todoBox = await Hive.openBox<Todo>('todoBox');
        await todoBox.delete(event.id);
      } catch (e) {
        rethrow;
      }
      return emit(TodosState(todolist: state.todolist));
    });

    on<GetAllTodos>((event, emit) async {
      List<Todo> newList = [];
      try {
        final todoBox = await Hive.openBox<Todo>('todoBox');
        newList = todoBox.keys.map((key) {
          final todo = todoBox.get(key)!;
          todo.id = key;
          return todo;
        }).toList();
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
