import 'package:flutter/material.dart';

import '../api/communication.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  final Map currentUser;

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  String newTask = "";
  final _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Communication communication = Communication();
    return Scaffold(
      appBar: AppBar(title: const Text('Create Task')),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 36,
        ),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _editController,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  hintText: 'タスクを入力してください',
                ),
                onChanged: (value) => {
                  setState(() {
                    newTask = value;
                  })
                }
              ),

              OutlinedButton(
                child: const Text('登録する'),
                onPressed: () async {
                  dynamic res = await communication.post('/api/tasks', { 
                    'task': {
                      'content': newTask,
                      'status': false,
                      'user_id': widget.currentUser['user_id']
                    }
                  });
                  if(res.statusCode == 200) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: 
                          const Text(
                            'タスクを追加しました',
                            style: TextStyle(fontSize: 16)
                          ),
                          actions: [
                            TextButton(
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.blue)
                              ),
                              onPressed: () {
                                _editController.clear();
                                Navigator.pop(context);
                              }
                            )
                          ]
                        );
                      }
                    );
                  }
                }
              )
            ]
          )
        )
      )
    );
  }
}
