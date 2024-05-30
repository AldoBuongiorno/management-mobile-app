import 'package:flutter/material.dart';

import '../classes/all.dart';

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
            title: Text(widget.tasks[index].taskName),
            value: widget.tasks[index].finished,
            onChanged: (bool? value) {
              setState(() {
                widget.tasks[index].finished =
                    value! ? true : false;
              });
            },
            secondary: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  widget.tasks.removeAt(widget.tasks
                      .indexOf(widget.tasks[index]));
                  setState(() {});
                }), //Text((ProjectList().getTaskList().indexOf(task) + 1).toString(), style: TextStyle(fontSize: 16),),
          );
        });

  }
}