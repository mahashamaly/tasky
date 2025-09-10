import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/models/task_model.dart';
import 'package:taskify/pages/widgets/task-list-widgets.dart';

class CompletedTasksScreen extends StatefulWidget {
  const CompletedTasksScreen({super.key,});

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
List<TaskModel> completTasks = [];
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
       completTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        isLoading = false;

       completTasks=completTasks.where((element)=>element.isDone==true).toList();
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
   child: Text("Completed Tasks",style: TextStyle(fontSize: 20,color: Color(0XFFFFFCFC)),),
 ),
 
 
 
 
  Expanded(
    child: Padding(
       
       
          padding: const EdgeInsets.all(16),
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
       
             : Tasklistwidgets(
              tasks: completTasks,
              onTap: (value,index)async{
       
       
       
       
                    setState(() {
                      completTasks[index!].isDone = value ?? false;
                    });
       
                    final pref = await SharedPreferences.getInstance();
                   // final updateTask = tasks.map((e) => e.toJson()).toList();
                    final allData=pref.getString('tasks');
                    if(allData!=null){
                     
                      List<TaskModel> allDataList =
                    (jsonDecode(allData) as List)
                  .map((element) => TaskModel.fromJson(element))
                  .toList();
       
                final newIndex = allDataList.indexWhere((e)=>e.taskName==completTasks[index!].taskName);
                allDataList[newIndex]=completTasks[index!];
                pref.setString('tasks', jsonEncode(allDataList));
                    _loadTask();
                  }
       
              },emptyMessage: 'NO Task Found',
       
       
             )
       
       
       
       
       
       
       
       
       
       
       
       
       
         
             
              
        ),
  )
 ]
    );
    
  }
}

