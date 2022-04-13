import 'package:flutter/material.dart';
import 'package:todo_app/helpers/add_task_helper.dart';
import 'package:todo_app/widgets/pick_date_time.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);
  
  final _addTaskHelper = AddTaskHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _addTaskHelper.titleController,
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
                    controller: _addTaskHelper.descController,
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
                  valueListenable: _addTaskHelper.currentDate,
                  builder: (BuildContext ctx,DateTime value,Widget? child) {
                    return PickDateTime(
                      currentDate: _addTaskHelper.dateFormater.format(value),
                      onPressed: (){_addTaskHelper.pickDate(ctx);},
                    );
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder(
                  valueListenable: _addTaskHelper.currentTime,
                  builder: (BuildContext ctx,TimeOfDay value,Widget? child) {
                    return PickDateTime(
                        currentDate: value.format(ctx),
                        onPressed: (){_addTaskHelper.pickTime(ctx);});
                  }
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _addTaskHelper.addTodo(context);
                  },
                  child: const Text(
                    'Add Task',
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
