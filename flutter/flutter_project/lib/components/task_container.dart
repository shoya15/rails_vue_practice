import 'package:flutter/material.dart';
import 'package:flutter_project/models/task.dart';

class TaskContainer extends StatefulWidget {
  const TaskContainer({
    Key? key,
    required this.task
  }) : super(key: key);

  final Task task;

  @override
  State<TaskContainer> createState() => _TaskContainer();
}

class _TaskContainer extends State<TaskContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(32),
        ),
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.content,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
              Text(
                "  ← created by user_id: ${widget.task.userId}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              )
            ]
          )
        )
      )
    );
  }
}
