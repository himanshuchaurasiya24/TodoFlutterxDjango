import 'package:flutter/material.dart';
import 'package:todo_django_frontend/list_todo.dart';

void main() {
  runApp(const MyApp());
}
// for devs other than android use port 127.....
// but for android it is 10.0.2.2:8000
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const TodoList(),
    );
  }
}
