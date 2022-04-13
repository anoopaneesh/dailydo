import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/bloc/todos_bloc/todos_bloc.dart';
import 'package:todo_app/helpers/database_helper.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_app/models/todo_model.dart';
import 'mock_data.dart';
import 'todos_bloc_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  late DatabaseHelper databaseHelper;
  late TodosBloc todoBloc;
  group('TodosBloc test', () {
    setUp(() {
      EquatableConfig.stringify = true;
      databaseHelper = MockDatabaseHelper();
      todoBloc = TodosBloc(databaseHelper);
    });

    blocTest<TodosBloc, TodosState>(
      'testing getalltodos event',
      build: () {
        when(databaseHelper.getAllTodos())
            .thenAnswer((_) async => Future.value([...MockData.mockTodosData]));
        return todoBloc;
      },
      act: (bloc) => bloc.add(GetAllTodos()),
      expect: () => <TodosState>[TodosState(todolist: [...MockData.mockTodosData])],
    );

    blocTest<TodosBloc, TodosState>(
      'testing togglecompleted event',
      build: () {
        when(databaseHelper.getAllTodos())
            .thenAnswer((_) async => Future.value([...MockData.mockTodosData]));
        when(databaseHelper.updateTodo(1, completed: true))
            .thenAnswer((_) async {
          final todo = Todo(
              id: 1,
              title: 'Task 1',
              desc: 'Description 1',
              date: DateTime(2009),
              time: const TimeOfDay(hour: 19, minute: 19),
              createdAt: MockData.createdAt,
              updatedAt: MockData.updatedAt,
              completed: true);
          return Future.value(todo);
        });
        return todoBloc;
      },
      act: (bloc) async {
        bloc.add(GetAllTodos());
        await Future.delayed(const Duration(milliseconds: 1000));
        bloc.add(ToggleCompleted(1));
      },
      expect: () => [TodosState(todolist: MockData.toggledData)],
    );

    blocTest<TodosBloc, TodosState>(
      'testing edittodo event',
      build: () {
        when(databaseHelper.getAllTodos())
            .thenAnswer((_) async => Future.value([...MockData.mockTodosData]));
        when(databaseHelper.updateTodo(1,title: 'Edited Title',desc:'Edited Desc' ,time: MockData.time,date: MockData.createdAt)).thenAnswer((_) async {
          final todo = Todo(
              id: 1,
              title: 'Edited Title',
              desc: 'Edited Desc',
              date: MockData.createdAt,
              time:MockData.time,
              createdAt: MockData.createdAt,
              updatedAt: MockData.updatedAt);
          return Future.value(todo);
        });
        return todoBloc;
      },
      act: (bloc) async{
        bloc.add(GetAllTodos());
        await Future.delayed(const Duration(milliseconds: 1000));
        bloc.add(EditTodo(1,title: 'Edited Title',desc:'Edited Desc' ,time: MockData.time,date: MockData.createdAt));
      },
      expect: () => <TodosState>[TodosState(todolist: MockData.editedData)],
    );

    blocTest<TodosBloc, TodosState>(
      'testing deletetodo event',
      build: () {
        when(databaseHelper.getAllTodos())
            .thenAnswer((_) async => Future.value([...MockData.mockTodosData]));
        when(databaseHelper.deleteTodo(1)).thenAnswer((_) async => Future.value());
        return todoBloc;
      },
      act: (bloc) async {
        bloc.add(GetAllTodos());
        await Future.delayed(const Duration(milliseconds: 1000));
        bloc.add(DeleteTodo(1));
      },
      expect: () =>  <TodosState>[TodosState(todolist: MockData.deletedData)],
    );


    tearDown(() {
      todoBloc.close();
    });
  });
}
