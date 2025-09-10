import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/models/task_model.dart';
import 'package:taskify/pages/screen/add-Task-Screen.dart';

import 'package:taskify/pages/widgets/achieved_tasks_widget.dart';
import 'package:taskify/pages/widgets/highprioritytasks_widget.dart';
import 'package:taskify/pages/widgets/sliver-task-list-widget.dart';
import 'package:taskify/pages/widgets/task-list-widgets.dart';

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
    final pref = await SharedPreferences.getInstance();
    final finalTask = pref.getString('tasks');
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

    final pref = await SharedPreferences.getInstance();
    final updateTask = tasks.map((e) => e.toJson()).toList();
    pref.setString('tasks', jsonEncode(updateTask));
  }

  void _LoadUserName() async {
    final pref = await SharedPreferences.getInstance();
    //استخدام ست ستيت لتحديث واجهة الصفحة بعد تحميل الاسم.
    setState(() {
      username = pref.getString('username') ?? '';
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


         

          backgroundColor: Color(0xff15B86C),
          foregroundColor: Color(0xffFFFCFC),
          icon: Icon(Icons.add),
          label: Text("Add New Task"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      backgroundColor: Color(0xff181818),
      body: CustomScrollView(
         slivers: [
          SliverToBoxAdapter(
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/image/person.png'),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Evening ,$username",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFFFCFC),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "One task at a time.One step closer.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffC6C6C6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
         SizedBox(height: 16),
              Text(
                "Yuhuu ,Your work Is ",
        
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFFFFFCFC),
                ),
              ),
         Row(
                children: [
                  Text(
                    "almost done !",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFFFFFCFC),
                    ),
                  ),
                  SvgPicture.asset('assets/svg/hand.svg'),
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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFFFFFCFC),
                  ),
                ),
              ),
             
             
           
        

              ],
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
        emptyMessage: 'no data',
      ),
  ],
),

        
          
      
        
        
        
        
     
   );
  }
}