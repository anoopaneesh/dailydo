import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/bloc/todos_bloc/todos_bloc.dart';
import 'package:todo_app/helpers/home_helper.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/widgets/todo.dart';
import 'package:todo_app/widgets/todolist.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final _homeHelper = HomeHelper();
  @override
  Widget build(BuildContext context) {
    _homeHelper.getAllTodos(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do'),
        actions: [
          IconButton(
              onPressed: () {
                _homeHelper.logout(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext ctx) => AddTaskScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: BlocBuilder<TodosBloc, TodosState>(
                  builder: (context, state) {
                    return state.todolist.isEmpty
                        ? Center(
                            child:
                                SvgPicture.asset('assets/images/no_task.svg'),
                          )
                        : Todolist(list: state.todolist, onTodoClick: (item){
                          _homeHelper.navigateToTodoEdit(context, item);
                        }, onTodoToggle: (item){
                          _homeHelper.toggleCompleted(context, item);
                        }, onTodoDelete: (id){
                          _homeHelper.deleteTodo(context, id);
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
