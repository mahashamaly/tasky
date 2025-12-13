import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskify/core/services/Preferences_manager.dart';
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
  //  *********************
   final finalTask = PreferencesManager().getString('tasks');

    
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

//وظيفتها: حذف مهمة من SharedPreferences ومن القائمة المعروضة في الشاشة.
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
     completTasks.removeWhere((task)=>task.id==id);
 
   });
   //هنا علشان اضمن انها انحذفت من التطبيق كامل
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
   child: Text("Completed Tasks",style: Theme.of(context).textTheme.labelSmall),
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
       
                   // final pref = await SharedPreferences.getInstance();
                   // final updateTask = tasks.map((e) => e.toJson()).toList();
                    //final allData=pref.getString('tasks');
                    final allData= PreferencesManager().getString('tasks');
                    if(allData!=null){
                     
                      List<TaskModel> allDataList =
                    (jsonDecode(allData) as List)
                  .map((element) => TaskModel.fromJson(element))
                  .toList();
       
                final newIndex = allDataList.indexWhere((e)=>e.taskName==completTasks[index!].taskName);
                allDataList[newIndex]=completTasks[index!];
                await PreferencesManager().setString('tasks', jsonEncode(allDataList));
                //pref.setString('tasks', jsonEncode(allDataList));
                    _loadTask();
                  }
       
              },emptyMessage: 'NO Task Found', onDelete: (int? id ) { 
                _deleteTask(id);
               }, onEdit:(){
                _loadTask();
               } ,
       
       
             )
       
       
       
       
       
       
       
       
       
       
       
       
       
         
             
              
        ),
  )
 ]
    );
    
  }
}

