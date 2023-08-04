import 'package:flutter/material.dart';
import 'package:flutter_project/api/communication.dart';
import 'package:flutter_project/models/task.dart';

class TaskContainer extends StatefulWidget {
  const TaskContainer({
    Key? key,
    required this.task,
    required this.currentUser
  }) : super(key: key);

  final Task task;
  final Map currentUser;

  @override
  State<TaskContainer> createState() => _TaskContainer();
}

class _TaskContainer extends State<TaskContainer> {
  updateTaskStatus(status) async {
    Communication communication = Communication();
    await communication.put('/api/tasks/${widget.task.id}', {
      'task': {
        'content': widget.task.content,
        'userId' : widget.task.userId,
        'status' : status,
        'id': widget.task.id
      }
    });
  }

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
              if(widget.currentUser['user_id'] == widget.task.userId)
                SizedBox(
                width: 25,
                height: 15,
                child: Transform.scale(
                  scale: 0.6,
                  child: Checkbox(
                    value: widget.task.status,
                    onChanged: (value) {
                      setState(() {
                        updateTaskStatus(value);
                      }); 
                    }
                  )
                )
              ),
              Text(widget.task.content),
              Text("  ← created by user_id: ${widget.task.userId}")
            ]
          )
        )
      )
    );
  }
}
