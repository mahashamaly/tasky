import 'dart:convert';
import 'dart:math';
import 'dart:io';


import 'package:flutter/material.dart';

import 'package:taskify/core/services/Preferences_manager.dart';
import 'package:taskify/core/widget/custom-svg-picture.dart';
import 'package:taskify/models/task_model.dart';
import 'package:taskify/features/add_task/add-Task-Screen.dart';

import 'package:taskify/features/home/components/achieved_tasks_widget.dart';
import 'package:taskify/features/home/highprioritytasks_widget.dart';
import 'package:taskify/features/home/components/sliver-task-list-widget.dart';
import 'package:taskify/core/components/task-list-widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
  int totalTask = 0;
  int doneTask = 0;
  double percent = 0;
  //قائمة المهام
  List<TaskModel> tasks = [];
  bool isLoading = false;
  String? userImagePath;

  //يتم استدعاؤها مرة وحدة عند انشاء الصفحة
  //تحميل اسم المستخدم والمهام
  void initState() {
    super.initState();
    _LoadUserName();
    _LoadTask();
  }

  void _LoadTask() async {
    setState(() {
      isLoading = true; //بداية التحميل
    });

    //await  Future.delayed(Duration(seconds: 5));
    final finalTask=PreferencesManager().getString('tasks');
    
    //هنا لو رجع نل ما فى بيانات ما نكمل الكود لو فيه بيانات ندخل ونعالجها

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      //نحول كل ماب بالقائمة الى تاسك مودل باستخدام  الفورم جسون
      setState(() {
        tasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        _calPersent();

        //انتهى التحميل
      });

      setState(() {
        isLoading = false;
      });
    }
  }

  _calPersent() {
    totalTask = tasks.length;
    doneTask = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : doneTask / totalTask;
  }

  _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calPersent();
    });
          
    //final pref = await SharedPreferences.getInstance();
    final updateTask = tasks.map((e) => e.toJson()).toList();
    PreferencesManager().setString('tasks', jsonEncode(updateTask));
    //pref.setString('tasks', jsonEncode(updateTask));
  }





  
  _deleteTask(int?id) async {
    if(id==null)return;
   setState(() {
     tasks.removeWhere((task)=>task.id==id);
      _calPersent();
   });
     final updateTask = tasks.map((e) => e.toJson()).toList();
    PreferencesManager().setString('tasks', jsonEncode(updateTask));
  }


  void _LoadUserName() async {
    
    //استخدام ست ستيت لتحديث واجهة الصفحة بعد تحميل الاسم.
    setState(() {

     username= PreferencesManager().getString('username')??'';
      userImagePath=PreferencesManager().getString('user-image');

    });

    print("username == $username");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
          onPressed: () async {
           final result= await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext Context) {
                  return AddTaskScreen();
                 


                },
              ),
            );

         if (result == true){
                   _LoadTask();
                 }

          },


         

         
          icon: Icon(Icons.add),
          label: Text("Add New Task"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
     
      body: CustomScrollView(
         slivers: [
           SliverToBoxAdapter(
             child: Padding(
               padding: const EdgeInsets.all(16),
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                     Row(
                   children: [
                     CircleAvatar(
                       backgroundImage:userImagePath==null
                       
                       ? AssetImage('assets/image/person.png')
                      
                       //
                       //اعرض صورة موجودة على جهاز الهاتف المسار تبعها موجود
                       //userImagePath!
                       :FileImage(File(userImagePath!)),
                     ),
                     SizedBox(width: 10),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           "Good Evening ,$username",
                        style:Theme.of(context).textTheme.titleMedium,
                           
                         ),
                         SizedBox(height: 4),
                         Text(
                           "One task at a time.One step closer.",
                           style:Theme.of(context).textTheme.titleSmall,
                           
                         ),
                       ],
                     ),
                   ],
                 ),
                      SizedBox(height: 16),
                 Text(
                   "Yuhuu ,Your work Is ",
                   style:Theme.of(context).textTheme.displayLarge,
                     
                 ),
                      Row(
                   children: [
                     Text(
                       "almost done !",
                            style:Theme.of(context).textTheme.displayLarge,
                       
                     ),
                  
                    Customsvgpicture.withColorFilter(path:'assets/svg/hand.svg' ),
                   ],
                 ),
                 SizedBox(height: 16),
                     
               
                 AchievedTasksWidget(
                   totalTask: totalTask,
                   doneTask: doneTask,
                   percent: percent,
                 ),
                 SizedBox(height: 8),
                 HighprioritytasksWidget(
                   tasks: tasks,
                     
                   onTap: (bool? value, int? index) {
                     _doneTask(value, index);
                   }, refresh: (){
                     _LoadTask();
                   },
                 ),
                     
                 Padding(
                   padding: EdgeInsets.only(top: 24, bottom: 16),
                   child: Text(
                     "My Tasks",
                     style: Theme.of(context).textTheme.labelSmall
                   ),
                 ),
                
                
                           
                     
                          
                 ],
               ),
             ),
           ),
      





       if (isLoading)
      SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      )
    else
      sliverTasklistwidgets(   // لاحظ الاسم CamelCase
        tasks: tasks,
        onTap: (bool? value, int? index) {
          _doneTask(value, index);
        },
        emptyMessage: 'no data', onDelete: (int? id) { 
          _deleteTask(id);
         }, onEdit: (){
          _LoadTask();
         },
      ),
  ],
),

        
          
      
        
        
        
        
     
   );
  }
}