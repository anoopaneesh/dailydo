import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:intl/intl.dart';

class TodoWidget extends StatelessWidget {
  final Todo item;
  final getDate = DateFormat('d/M/y');
  final void Function()? onTap;
  final void Function(bool?)? onChanged;
  TodoWidget(
      {Key? key,
      required this.item,
      this.onTap,
      this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const ValueKey('hello'),
      onTap:onTap,
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
            onChanged: onChanged,
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
