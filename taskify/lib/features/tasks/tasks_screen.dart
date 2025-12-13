import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:taskify/core/services/Preferences_manager.dart';
import 'package:taskify/models/task_model.dart';

import 'package:taskify/core/components/task-list-widgets.dart';

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

final finalTask =PreferencesManager().getString('tasks');
    // final pref = await SharedPreferences.getInstance();
    // final finalTask = pref.getString('tasks');

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









 _deleteTask(int?id) async {
    List<TaskModel>tasks=[];
    if(id==null)return;
   final finalTask = PreferencesManager().getString('tasks');
 if (finalTask != null && finalTask.isNotEmpty) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks=taskAfterDecode.map((element)=>TaskModel.fromJson(element)).toList();
      tasks.removeWhere((e)=>e.id==id);
      }
    

   setState(() {
     todoTasks.removeWhere((task)=>task.id==id);
 
   });
     final updateTask = tasks.map((e) => e.toJson()).toList();
    PreferencesManager().setString('tasks', jsonEncode(updateTask));
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Text(
            "To Do Tasks",style: Theme.of(context).textTheme.labelSmall,
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
    
                      
                      // final updateTask = tasks.map((e) => e.toJson()).toList();
                       final allData=PreferencesManager().getString('tasks');
                     
                      if (allData != null) {
                        List<TaskModel> allDataList =
                            (jsonDecode(allData) as List)
                                .map((element) => TaskModel.fromJson(element))
                                .toList();
    
                        final newIndex = allDataList.indexWhere(
                          (e) => e.taskName == todoTasks[index!].taskName,
                        );
                        allDataList[newIndex] = todoTasks[index!];
                        await PreferencesManager().setString('tasks', jsonEncode(allDataList));
                        //pref.setString('tasks', jsonEncode(allDataList));
                        _loadTask();
                      }
                    },
                    emptyMessage: 'NO Tak Found', onDelete: (int?id ) { 
                      _deleteTask(id);
                     }, onEdit: (){
                      _loadTask();
                     }, 
                  ),
          ),
        ),
      ],
    );
  }
}
