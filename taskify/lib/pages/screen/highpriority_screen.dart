import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:taskify/core/services/Preferences_manager.dart';
import 'package:taskify/models/task_model.dart';
import 'package:taskify/pages/widgets/task-list-widgets.dart';

class HighpriorityScreen extends StatefulWidget {
  const HighpriorityScreen({super.key});

  @override
  State<HighpriorityScreen> createState() => _HighpriorityScreenState();
}

 
class _HighpriorityScreenState extends State<HighpriorityScreen> {
List<TaskModel> HighPriorityTasks = [];
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
     final finalTask = PreferencesManager().getString('tasks');
    
    if (finalTask != null && finalTask.isNotEmpty) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
       HighPriorityTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        isLoading = false;

      HighPriorityTasks= HighPriorityTasks
            .where((element) => element.HighPriority )
            .toList();
            HighPriorityTasks=HighPriorityTasks.reversed.toList();
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
     HighPriorityTasks.removeWhere((task)=>task.id==id);
 
   });
     final updateTask = tasks.map((e) => e.toJson()).toList();
    PreferencesManager().setString('tasks', jsonEncode(updateTask));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("High Priority Tasks"),
),
body:  Padding(
  padding: const EdgeInsets.all(16),
  child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        value: 0.5,
                        color: Colors.white,
                      ),
                    )
                  : Tasklistwidgets(
                      tasks: HighPriorityTasks,
                      onTap: (value, index) async {
                        setState(() {
                        HighPriorityTasks[index!].isDone = value ?? false;
                        });
                     final allData= PreferencesManager().getString('tasks');
                        //final pref = await SharedPreferences.getInstance();
                        // final updateTask = tasks.map((e) => e.toJson()).toList();
                        //final allData = pref.getString('tasks');
                        if (allData != null) {
                          List<TaskModel> allDataList =
                              (jsonDecode(allData) as List)
                                  .map((element) => TaskModel.fromJson(element))
                                  .toList();
      
                          final newIndex = allDataList.indexWhere(
                            (e) => e.taskName == HighPriorityTasks[index!].taskName,
                          );
                          allDataList[newIndex] = HighPriorityTasks[index!];
                        await  PreferencesManager().setString('tasks', jsonEncode(allDataList));
                          //pref.setString('tasks', jsonEncode(allDataList));
                          _loadTask();
                        }
                      },
                      emptyMessage: 'NO Task Found', onDelete: (int? id ) { 
                        _deleteTask(id);
                       }, onEdit: (){
                        _loadTask();
                       },
                    ),
),








    );
  }
}