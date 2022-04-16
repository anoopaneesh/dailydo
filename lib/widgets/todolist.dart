import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/widgets/todo.dart';

class Todolist extends StatelessWidget {
  final List<Todo> list;
  final void Function(Todo item) onTodoClick;
  final void Function(Todo item) onTodoToggle;
  final void Function(int id) onTodoDelete;
  const Todolist({ Key? key,required this.list,required this.onTodoClick,required this.onTodoToggle,required this.onTodoDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
                            itemBuilder: (BuildContext ctx, int index) {
                              final item = list[index];
                              return Dismissible(
                                direction: DismissDirection.endToStart,
                                background: Container(),
                                secondaryBackground: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  alignment: Alignment.centerRight,
                                  color: Colors.red,
                                  child: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                  ),
                                ),
                                key: ObjectKey(item),
                                child: TodoWidget(
                                  key: ValueKey(item.id),
                                  item: item,
                                  onTap: () {
                                    onTodoClick(item);
                                  },
                                  onChanged: (bool? value) {
                                    onTodoToggle(item);
                                  },
                                ),
                                onDismissed: (direction) {
                                  onTodoDelete(item.id!);
                                },
                              );
                            },
                            separatorBuilder: (BuildContext ctx, _) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: list.length,
                          );
  }
}