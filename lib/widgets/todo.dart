import 'package:flutter/material.dart';
import 'package:todo_app/bloc/todos_bloc/todos_bloc.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/screens/edit_task_screen.dart';

class TodoWidget extends StatelessWidget {
  final Todo item;
  final getDate =  DateFormat('d/M/y'); 
  TodoWidget({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext ctx) => EditTaskScreen(item),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 2))
            ]),
        child: ListTile(
          trailing: Checkbox(
            activeColor: const Color.fromARGB(255, 28, 31, 132),
            value: item.completed,
            onChanged: (bool? currentVal) {
              context.read<TodosBloc>().add(ToggleCompleted(item.id));
            },
          ),
          title: Text(
            item.title,
            style: TextStyle(
                decoration: item.completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          //activeColor: const Color.fromARGB(255, 28, 31, 132),
          subtitle: item.completed
              ? Text(
                  item.desc,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style:
                      const TextStyle(decoration: TextDecoration.lineThrough),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.desc,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.time.format(context)),
                        Text(getDate.format(item.date)),
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
