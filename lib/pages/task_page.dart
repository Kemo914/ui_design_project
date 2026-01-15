import 'package:flutter/material.dart';
import '../data/hive_database.dart';
import '../models/task.dart';
import '../widget/task_tile.dart';
import '../widget/dialog_box.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final HiveDatabase db = HiveDatabase();
  final TextEditingController controller = TextEditingController();

  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    tasks = db.loadTasks();
  }

  void addTask() {
    if (controller.text.isNotEmpty) {
      setState(() {
        db.addTask(Task(title: controller.text));
        tasks = db.loadTasks();
        controller.clear();
      });
    }
    Navigator.pop(context);
  }

  void toggleTask(int index) {
    setState(() {
      db.toggleTask(index);
      tasks = db.loadTasks();
    });
  }

  void deleteTask(int index) {
    setState(() {
      db.deleteTask(index);
      tasks = db.loadTasks();
    });
  }

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => DialogBox(
        controller: controller,
        onSave: addTask,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text('My Tasks 📝'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: tasks[index],
            onChanged: (_) => toggleTask(index),
            onDelete: () => deleteTask(index),
          );
        },
      ),
    );
  }
}