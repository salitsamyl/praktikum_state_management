import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_data.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider To-Do (${Provider.of<TaskData>(context).taskCount})'),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<TaskData>(
        builder: (context, taskData, child) {
          return ListView.builder(
            itemCount: taskData.taskCount,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(
                  taskData.tasks[index].name,
                  style: TextStyle(
                    decoration: taskData.tasks[index].isDone
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                value: taskData.tasks[index].isDone,
                onChanged: (newValue) {
                  taskData.toggleTask(index);
                },
                controlAffinity: ListTileControlAffinity.leading,
                secondary: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    taskData.deleteTask(index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskSheet(),
          );
        },
      ),
    );
  }
}

class AddTaskSheet extends StatelessWidget {
  AddTaskSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String newTaskTitle = '';

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Tambah Tugas',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: Colors.green),
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newTaskTitle = newText;
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
            child: Text('Add'),
            onPressed: () {
              if (newTaskTitle.isNotEmpty) {
                Provider.of<TaskData>(context, listen: false).addTask(newTaskTitle);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}