import 'package:hive/hive.dart';
import '../models/task.dart';

class HiveDatabase {
  final _box = Hive.box<Task>('taskBox');

  List<Task> loadTasks() {
    return _box.values.toList();
  }

  void addTask(Task task) {
    _box.add(task);
  }

  void toggleTask(int index) {
    final task = _box.getAt(index)!;
    task.isCompleted = !task.isCompleted;
    task.save();
  }

  void deleteTask(int index) {
    _box.deleteAt(index);
  }
}