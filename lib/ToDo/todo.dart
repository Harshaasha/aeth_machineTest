import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ToDoApp extends StatefulWidget {
  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  final _tasksBox = Hive.box('tasksBox');
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _addTask() {
    if (_titleController.text.isNotEmpty) {
      final task = {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'completed': false,
      };
      _tasksBox.add(task);
      _titleController.clear();
      _descriptionController.clear();
      setState(() {});
      Navigator.of(context).pop();
    }
  }

  void _markTaskCompleted(int index) {
    final task = _tasksBox.getAt(index);
    _tasksBox.putAt(index, {
      'title': task['title'],
      'description': task['description'],
      'completed': true,
    });
    setState(() {});
  }

  void _deleteTask(int index) {
    _tasksBox.deleteAt(index);
    setState(() {});
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: _addTask,
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _tasksBox.values.toList();
    final pendingTasks = tasks.where((task) => !task['completed']).toList();
    final completedTasks = tasks.where((task) => task['completed']).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pendingTasks.length,
              itemBuilder: (context, index) {
                final task = pendingTasks[index];
                return ListTile(
                  title: Text(task['title']),
                  subtitle: Text(task['description']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () => _markTaskCompleted(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteTask(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(),
          Text(
            'Completed Tasks',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return ListTile(
                  title: Text(task['title']),
                  subtitle: Text(task['description']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTask(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddTaskDialog,
      ),
    );
  }
}
