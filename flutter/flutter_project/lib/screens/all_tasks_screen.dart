import 'package:flutter/material.dart';
import 'dart:convert';

import '../api/communication.dart';
import '../models/task.dart';
import '../components/task_container.dart';
import 'package:flutter_project/screens/sign_in_screen.dart';
import 'package:flutter_project/screens/create_task_screen.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

enum RadioValue { done, yet }

class _AllTasksScreenState extends State<AllTasksScreen> {
  List<Task> tasks = [];
  Map currentUser = {};
  bool isChecked = false;

  Future setTasks() async {
    final res = await getTasks();
    setState(() {
      tasks = res;
    });
  }

  @override
  void initState() {
    super.initState();
    setTasks();
  }

  RadioValue groupValue = RadioValue.yet;

  List<Task> filterTasks() {
    if(isChecked) {
      List<Task> mytasks = tasks.where((task) => task.userId == currentUser['user_id']).toList();
      return groupValue == RadioValue.done ? 
             mytasks.where((task) => task.status).toList() :
             mytasks.where((task) => !task.status).toList();
    }else {
      return groupValue == RadioValue.done ? 
             tasks.where((task) => task.status).toList() :
             tasks.where((task) => !task.status).toList();
    }
  }

  /// 完了/未完了ボタンのステータスを更新するための関数
  _onRadioSelected(value) {
    setState(() {
      groupValue = value;
    });
  }

  _onChecked(value) {
    setState(() {
      isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Communication communication = Communication();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tasks'),
        actions: [
          if(currentUser.isNotEmpty)
            TextButton(
              child: const Text(
                'タスク登録',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => CreateTaskScreen(currentUser: currentUser))
                  ),
                );
              }
            ),
          if(currentUser.isEmpty)
            TextButton(
              child: const Text(
                'サインイン',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              onPressed: () async {
                RouteSettings settings = RouteSettings(arguments: currentUser);
                var result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: settings,
                    builder: (context) => const SignInScreen(),
                  ),
                );
                setState(() {
                  currentUser = result as Map;
                });
              },
            ),
          if(currentUser.isNotEmpty)
            TextButton(
              child: const Text(
                'サインアウト',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              onPressed: () async {
                await communication.delete('/api/sign_out');
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: 
                      const Text(
                        'サインアウトしました',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              currentUser = {};
                            });
                            Navigator.pop(context);
                          }
                        )
                      ]
                    );
                  }
                );
              },
            )
        ],
      ),
      body: FutureBuilder(
        future: getTasks(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("LOADING...", style: TextStyle(color: Colors.black),));
          }else {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ListTileTheme(
                        horizontalTitleGap: 0.0,
                        child: RadioListTile(
                          title: const Text(
                              '完了済み',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          value: RadioValue.done,
                          groupValue: groupValue,
                          onChanged: (value) => _onRadioSelected(value)
                        )
                      )
                    ),
                    Expanded(
                      child: ListTileTheme(
                        horizontalTitleGap: 0.0,
                        child: RadioListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: const Text(
                            '未完了',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          value: RadioValue.yet,
                          groupValue: groupValue,
                          onChanged: (value) => _onRadioSelected(value)
                        )
                      )
                    ),
                    if(currentUser.isNotEmpty)
                      Expanded(
                        child: ListTileTheme(
                          horizontalTitleGap: 0.0,
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text(
                              '自分のタスク',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12
                              ),
                            ),
                            value: isChecked,
                            onChanged: (value) => _onChecked(value)
                          )
                        )
                      ),
                  ]
                ),
                Expanded(
                  child: ListView(
                    children: 
                      filterTasks()
                      .map((task) => TaskContainer(task: task, currentUser: currentUser))
                      .toList()
                  )
                ),
              ],
            );
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await getTasks();
          setState(() {
            tasks = res;
          });
        },
        child: const Icon(Icons.autorenew)
       ),
    );
  }
}

Future<List<Task>> getTasks() async {
  final Communication communication = Communication();
  final res = await communication.get('/api/tasks');

  if(res.statusCode == 200) {
    final body = jsonDecode(res.body);
    final List<dynamic> tasks = body["tasks"].toList();
    return tasks.map((dynamic json) => Task.fromJson(json)).toList();
  }else {
    return [];
  }
}
