import 'package:flutter/material.dart';
import 'package:flutter_app_demo/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_demo/models/task_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        home: TasksScreen(),
      ),
    );
  }
}
