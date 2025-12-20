
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:taskify/constants/storage-key.dart';
import 'package:taskify/core/services/Preferences_manager.dart';
import 'package:taskify/models/task_model.dart';

class HomeController with ChangeNotifier{
List <TaskModel> taskList=[];

String username = "";
  int totalTask = 0;
  int totalDoneTasks = 0;
  double percent = 0;
  //قائمة المهام
  List<TaskModel> tasks = [];
  bool isLoading = false;
  String? userImagePath;


init(){
  LoadUserName();
  LoadTask();
}




   calPersent() {
    totalTask = tasks.length;
    totalTask = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
  }

 void LoadUserName() async {
    
    //استخدام ست ستيت لتحديث واجهة الصفحة بعد تحميل الاسم.
   

     username= PreferencesManager().getString(StorageKey.username)??'';
      userImagePath=PreferencesManager().getString('user-image');

    

    print("username == $username");
    notifyListeners();
  }




void LoadTask() async {
  
      isLoading = true; //بداية التحميل
  

    //await  Future.delayed(Duration(seconds: 5));
    final finalTask=PreferencesManager().getString('tasks');
    
    //هنا لو رجع نل ما فى بيانات ما نكمل الكود لو فيه بيانات ندخل ونعالجها

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      //نحول كل ماب بالقائمة الى تاسك مودل باستخدام  الفورم جسون
     
        tasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
         calPersent();

        //انتهى التحميل


     
        isLoading = false;
   
    }
    notifyListeners();
  }












 
  doneTask(bool? value, int? index) async {
  
      tasks[index!].isDone = value ?? false;
       calPersent();
    
          
    //final pref = await SharedPreferences.getInstance();
    final updateTask = tasks.map((e) => e.toJson()).toList();
    PreferencesManager().setString('tasks', jsonEncode(updateTask));
    //pref.setString('tasks', jsonEncode(updateTask));

    notifyListeners();
  }





  
  deleteTask(int?id) async {
    if(id==null)return;
  
     tasks.removeWhere((task)=>task.id==id);
       calPersent();
   
     final updateTask = tasks.map((e) => e.toJson()).toList();
    PreferencesManager().setString('tasks', jsonEncode(updateTask));
  }  
}