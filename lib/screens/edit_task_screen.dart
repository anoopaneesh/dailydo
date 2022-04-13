import 'package:flutter/material.dart';
import 'package:todo_app/helpers/edit_task_helper.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/widgets/pick_date_time.dart';

class EditTaskScreen extends StatelessWidget {
  final Todo todo;
  late final EditTaskHelper _editTaskHelper;
  EditTaskScreen(this.todo, {Key? key}) : super(key: key){
    _editTaskHelper = EditTaskHelper(todo: todo);
  }
  

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _editTaskHelper.titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 5 * 24.0,
                  child: TextField(
                    controller: _editTaskHelper.descController,
                    maxLines: 200,
                    decoration: const InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                  valueListenable: _editTaskHelper.currentDate,
                  builder: (BuildContext ctx, DateTime value, Widget? child) {
                    return PickDateTime(
                        currentDate: _editTaskHelper.dateFormater.format(value),
                        onPressed:(){ _editTaskHelper.pickDate(ctx);});
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                  valueListenable: _editTaskHelper.currentTime,
                  builder:(BuildContext ctx, TimeOfDay value, Widget? child) {
                    return PickDateTime(
                        currentDate: value.format(ctx),
                        onPressed: (){_editTaskHelper.pickTime(ctx);});
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _editTaskHelper.editTodo(context);
                  },
                  child: const Text(
                    'Edit Task',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
