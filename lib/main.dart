import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/bloc/todos_bloc/todos_bloc.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/login_screen.dart';

late final SharedPreferences pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  pref = await SharedPreferences.getInstance();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(TodoAdapter().typeId)){
    Hive.registerAdapter(TodoAdapter());
  }
  if(!Hive.isAdapterRegistered(TimeOfDayAdapter().typeId)){
    Hive.registerAdapter(TimeOfDayAdapter());
  }
  runApp(MyApp(
    isAuthorized: pref.getStringList('user') != null,
  ));
}

class MyApp extends StatelessWidget {
  final bool isAuthorized;
  const MyApp({Key? key, required this.isAuthorized}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.purple),
        home: isAuthorized ? HomeScreen() : LoginPage(),
      ),
    );
  }
}
