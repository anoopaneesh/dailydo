import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todos_bloc/todos_bloc.dart';
import 'package:todo_app/helpers/firebase_helper.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/edit_task_screen.dart';
import 'package:todo_app/screens/login_screen.dart';

class HomeHelper {
  void deleteTodo(BuildContext ctx, int? id) {
    ctx.read<TodosBloc>().add(DeleteTodo(id));
  }

  void getAllTodos(BuildContext ctx) {
    ctx.read<TodosBloc>().add(GetAllTodos());
  }

  void logout(BuildContext context) async {
    try {
      await pref.remove('user');
      await FirebaseHelper.signOut();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext ctx) => LoginPage()),
          (route) => false);
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Something went wrong')));
    }
  }

  void navigateToTodoEdit(BuildContext context, Todo item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext ctx) => EditTaskScreen(item),
      ),
    );
  }

  void toggleCompleted(BuildContext context,Todo item) {
    context.read<TodosBloc>().add(ToggleCompleted(item.id));
  }
}
