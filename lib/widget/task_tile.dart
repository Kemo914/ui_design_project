import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool?) onChanged;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: onChanged,
            activeColor: Colors.deepPurple,
          ),
          title: Text(
            task.title,
            style: TextStyle(
              decoration:
              task.isCompleted ? TextDecoration.lineThrough : null,
              fontSize: 18,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}