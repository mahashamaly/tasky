import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/models/task_model.dart';

import 'package:taskify/pages/widgets/task-list-widgets.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String username = "";
  List<TaskModel> todoTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });

    final pref = await SharedPreferences.getInstance();
    final finalTask = pref.getString('tasks');

    if (finalTask != null && finalTask.isNotEmpty) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        todoTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        isLoading = false;

        todoTasks = todoTasks
            .where((element) => element.isDone == false)
            .toList();
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Text(
            "To Do Tasks",
            style: TextStyle(fontSize: 20, color: Color(0XFFFFFCFC)),
          ),
        ),
    
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      value: 0.5,
                      color: Colors.white,
                    ),
                  )
                : Tasklistwidgets(
                    tasks: todoTasks,
                    onTap: (value, index) async {
                      setState(() {
                        todoTasks[index!].isDone = value ?? false;
                      });
    
                      final pref = await SharedPreferences.getInstance();
                      // final updateTask = tasks.map((e) => e.toJson()).toList();
                      final allData = pref.getString('tasks');
                      if (allData != null) {
                        List<TaskModel> allDataList =
                            (jsonDecode(allData) as List)
                                .map((element) => TaskModel.fromJson(element))
                                .toList();
    
                        final newIndex = allDataList.indexWhere(
                          (e) => e.taskName == todoTasks[index!].taskName,
                        );
                        allDataList[newIndex] = todoTasks[index!];
                        pref.setString('tasks', jsonEncode(allDataList));
                        _loadTask();
                      }
                    },
                    emptyMessage: 'NO Tak Found',
                  ),
          ),
        ),
      ],
    );
  }
}
