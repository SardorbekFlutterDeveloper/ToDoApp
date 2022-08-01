import 'package:hive/hive.dart';
import 'package:todoapp/model/task.dart';

class TodoService {
  late Box<Task> _tasks;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox("taska");

    await _tasks.clear();

    await _tasks.add(Task("testuser1", "Subscribe to Flutter from Scratch", true));

    await _tasks.add(Task("testuser2", "Comment on the Video", false));
  }

  List<Task> getTasks(final String username) {
    final tasks = _tasks.values.where((element) => element.user == username);
    return tasks.toList();
  }

  void addTasks(final String task, final String username) {
    _tasks.add(Task(username, task, false));
  }

  void removeTasks(final String task, final String username) async {
    final taskToRemove = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == username);
    await taskToRemove.delete();
  }

  Future<void> updateTask(final String task, final String username,) async {
    final taskToEdit = _tasks.values.firstWhere(
        (element) => element.task == task && element.user == username);
    final index = taskToEdit.key as int;

    await _tasks.put(
        index, Task(username, task, !taskToEdit.iscomplated));
  }
}
