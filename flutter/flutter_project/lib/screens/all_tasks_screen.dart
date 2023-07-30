import 'package:flutter/material.dart';
import 'dart:convert';

import '../api/communication.dart';
import '../models/task.dart';
import '../components/task_container.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

enum RadioValue { done, yet }

class _AllTasksScreenState extends State<AllTasksScreen> {
  List<Task> tasks = [];
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
    if(groupValue == RadioValue.done) {
      return tasks.where((task) => task.status).toList();
    }else {
      return tasks.where((task) => !task.status).toList();
    }
  }

  /// 完了/未完了ボタンのステータスを更新するための関数
  _onRadioSelected(value) {
    setState(() {
      groupValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Tasks')),
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
                    ),
                    Expanded(
                      child: RadioListTile(
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
                  ]
                ),
                Expanded(
                  child: ListView(
                    children: 
                      filterTasks()
                      .map((task) => TaskContainer(task: task))
                      .toList()
                  )
                ),
              ],
            );
          }
        }
      )
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
