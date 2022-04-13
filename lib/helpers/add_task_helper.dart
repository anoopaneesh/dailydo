import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/todos_bloc/todos_bloc.dart';
import 'package:todo_app/models/todo_model.dart';

class AddTaskHelper {
  final dateFormater = DateFormat('d/M/y');

  final currentDate = ValueNotifier(DateTime.now());
  final currentTime = ValueNotifier(TimeOfDay.now());

  final titleController = TextEditingController();
  final descController = TextEditingController();

  void addTodo(BuildContext ctx) {
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
    final todo = Todo(title: title, desc: desc, date: date, time: time);
    ctx.read<TodosBloc>().add(AddTodo(todo));
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
