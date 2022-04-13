import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/todos_bloc/todos_bloc.dart';
import 'package:todo_app/models/todo_model.dart';

class EditTaskHelper {
  final dateFormater = DateFormat('d/M/y');
  final Todo todo;
  late ValueNotifier<DateTime> currentDate;
  late ValueNotifier<TimeOfDay> currentTime;
  late TextEditingController titleController;
  late TextEditingController descController;

  EditTaskHelper({required this.todo}) {
    currentDate = ValueNotifier(todo.date);
    currentTime = ValueNotifier(todo.time);
    titleController = TextEditingController(text: todo.title);
    descController = TextEditingController(text: todo.desc);
  }

  void editTodo(BuildContext ctx) {
    final id = todo.id;
    final title = titleController.text;
    final desc = descController.text;
    final date = currentDate.value;
    final time = currentTime.value;
    String? errorMessage;
    if (title == '') {
      errorMessage = 'Please give a title';
    } else if (desc == '') {
      errorMessage = 'Please give a description';
    }
    if (errorMessage != null) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 1),
      ));
      return;
    }
    ctx
        .read<TodosBloc>()
        .add(EditTodo(id, title: title, desc: desc, date: date, time: time));
    Navigator.of(ctx).pop();
  }

  void pickDate(BuildContext ctx) async {
    final DateTime? pickedDate = await showDatePicker(
        context: ctx,
        initialDate: currentDate.value,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
        currentDate.value = pickedDate;
    }
  }

  void pickTime(BuildContext ctx) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: ctx, initialTime: currentTime.value);
    if (pickedTime != null) {
        currentTime.value = pickedTime;
    }
  }
}
