import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:todo_django_frontend/add_todo.dart';
import 'package:todo_django_frontend/constants.dart';
import 'package:todo_django_frontend/model.dart';
import 'package:http/http.dart' as http;

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  int workDone = 0;
  int notDone = 0;
  void refreshData() {
    setState(() {
      fetchData();
    });
  }

  Future<List<Todo>> fetchData() async {
    var response = await http.get(Uri.parse(api_link));
    try {
      List<Todo> todos = List<Todo>.from(
          json.decode(response.body).map((model) => Todo.fromJson(model)));
      workDone = 0;
      notDone = 0;
      for (var todo in todos) {
        if (todo.isDone!) {
          workDone += 1;
        }
      }
      notDone = todos.length - workDone;
      return todos;
    } catch (e) {
      debugPrint(e.toString());
    }
    return [
      Todo(
        id: 0,
        date: 'date',
        desc: 'desc',
        isDone: false,
        title: 'title',
      )
    ];
  }

  void deleteTodo(int id) async {
    try {
      await http.delete(Uri.parse('${api_link}${id}'));
      refreshData();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Listtt'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const AddTodo();
              },
            )).then(
              (value) {
                setState(() {});
              },
            );
          },
          label: Text('Enter a new task')),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 4,
            child: PieChart(dataMap: {
              'done': workDone.toDouble(),
              'notDone': notDone.toDouble()
            }),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Some Error'),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No data to display'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        snapshot.data![index].title.toString(),
                      ),
                      subtitle: Text(snapshot.data![index].desc.toString()),
                      trailing: IconButton(
                          onPressed: () {
                            deleteTodo(snapshot.data![index].id!);
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          )),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
