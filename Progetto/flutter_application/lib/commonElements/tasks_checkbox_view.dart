// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application/data/database_helper.dart';
import '../classes/all.dart';


class TasksCheckboxViewForHomepage extends StatefulWidget {
  TasksCheckboxViewForHomepage({super.key, required this.tasks});
  List<Task> tasks;

  @override
  State<TasksCheckboxViewForHomepage> createState() =>
      _TasksCheckboxViewForHomepageState();
}

class _TasksCheckboxViewForHomepageState extends State<TasksCheckboxViewForHomepage> {
  @override
  Widget build(BuildContext context) {
    return widget.tasks.isEmpty ? Text('Non sono presenti task.') : ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            activeColor: Colors.pink,
            //side: BorderSide(color: Colors.lightBlue, width: 2),
            checkboxShape: const CircleBorder(),
            title: Text(widget.tasks[index].getName()),
            value: widget.tasks[index].getCompleted(),
            onChanged: (bool? value) {
                  setState(() {
                    widget.tasks[index].completed = value ??
                        false; // Imposta completed a value se value non è nullo, altrimenti a false.
                    DatabaseHelper.instance.updateCompleted(
                        widget.tasks[index].name, value ?? false);
                      Future.delayed(Duration(milliseconds: 1200), () {
                        if (widget.tasks[index].completed == true) {
                          setState(() {
                            widget.tasks.removeAt(index);
                        });
                      };
                      });
                  });
            },
            secondary: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  String taskName = widget.tasks[index].name;
                  widget.tasks.removeAt(index);
                  setState(() {});
                  DatabaseHelper.instance.deleteTask(taskName);
                }), //Text((ProjectList().getTaskList().indexOf(task) + 1).toString(), style: TextStyle(fontSize: 16),),
          );
        });

  }
}

class TasksCheckboxView extends StatefulWidget {
  TasksCheckboxView({super.key, required this.tasks});
  List<Task> tasks;

  @override
  State<TasksCheckboxView> createState() =>
      _TasksCheckboxViewState();
}

class _TasksCheckboxViewState extends State<TasksCheckboxView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            activeColor: Colors.pink,
            //side: BorderSide(color: Colors.lightBlue, width: 2),
            checkboxShape: const CircleBorder(),
            title: Text(widget.tasks[index].getName()),
            value: widget.tasks[index].getCompleted(),
            onChanged: (bool? value) {
              setState(() {
                widget.tasks[index].completed =
                    value! ?  true : false;
                DatabaseHelper.instance.updateCompleted(widget.tasks[index].name, value);
              });
            },
            secondary: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  widget.tasks.removeAt(index);
                  setState(() {});
                  //DatabaseHelper.instance.deleteTask(widget.tasks[index].name);
                }), //Text((ProjectList().getTaskList().indexOf(task) + 1).toString(), style: TextStyle(fontSize: 16),),
          );
        });

  }
}