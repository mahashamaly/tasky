import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/core/widget/custom_text_form_faild.dart';
import 'dart:convert';

import 'package:taskify/models/task_model.dart';


class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _addTaskState();
}

class _addTaskState extends State<AddTaskScreen> {
  //dispose controller
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =TextEditingController();

  final GlobalKey<FormState>_key=GlobalKey();

    bool isHighPriority =true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
      
       
        title: Text("New Task"),
        
      ),

      body: SafeArea(


        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _key,
            child: Column(
            
              
              children: [



                           
               SizedBox(height: 8),
               CustomTextFormFaild(controller: taskNameController, hintText: "Finish UI design for login screen",title: "Task Name",
                 validator: (String? value) {
                   //if(value?.trim().isEmpty??false)
                   if (value == null || value.trim().isEmpty) {
                     return "Please Enter Task Name ";
                   }
                   return null;
                 },
                 
               
               ),
                           
              
               SizedBox(
                 height: 20,
               ),
                           
                           
                   
                    CustomTextFormFaild(controller: taskDescriptionController,
                    maxLines: 5,
                    hintText: "Finish onboarding UI and hand off to devs by Thursday.",
                    title: "Task Description",
                    ),
            
               
               
               SizedBox(
               height: 20,
                 ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("HighPriority",style:TextStyle(fontSize:16 ,fontWeight: FontWeight.w400,color:Color(0xffFFFCFC)),),
                   Switch(
                     value: isHighPriority, // القيمة الحالية للمفتاح (صح/خطأ)
                    onChanged:(bool value){// دالة تُنفذ لما المستخدم يغيّر حالة المفتاح
                      setState(() {
                        isHighPriority=value;  //تحديث قيمة المتغير داخل الـ State
                      });
                   
                    },
                     
                   
                   
                   ),
                 ],
               ),
          
          
            Spacer(),
            ElevatedButton.icon(onPressed: ()async{
              
             
              if( _key.currentState?.validate()??false){
                // Navigator.of(context).pop();
                
                //save data{SharedPreferences}
                //افتح الدرج
               final pref= await SharedPreferences.getInstance();
               //check by key{tasks}
               //getString return string
               
              final taskjson= pref.getString('tasks');
                //هنا عملت ليست علشان اجيب التاسك القديمة
              // نجهز لست فاضية مؤقتًا عشان نحط فيها المهام القديمة + الجديدة
               // خُدي الورقة باسم "tasks" (String أو null)
              //
              List<dynamic> ListTasks=[];
              // لو مفيش ورقة → رجّعي قائمة فاضية
              if(taskjson !=null){
                ListTasks=jsonDecode(taskjson);
              }

              TaskModel model=TaskModel(
                id: ListTasks.length +1,
  
                taskName: taskNameController.text,
               taskDescription: taskDescriptionController.text,
                HighPriority: isHighPriority);


               print(model.toJson());


            
              //إضافة المهمة الجديدة للقائمة
              print("Listtask befor add $ListTasks");
              ListTasks.add(model.toJson());
               print("Listtask aftar add $ListTasks");
              print(taskjson);

               final taskEncode = jsonEncode(ListTasks);
              await pref.setString("tasks",taskEncode);
               print(taskEncode);
            


             Navigator.of(context).pop(true);
                
              }
             }, 
               style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFF15B86C),
                foregroundColor: Color(0xffFFFCFC),
                fixedSize: Size(MediaQuery.of(context).size.width,40)


               ),
               
               icon: (Icon(Icons.add)),
               label: Text("Add Task"),
               
               
               ),
            
            
            
              ],





            ),


          ),
       
       
       
       
      
       
        ),
      ),
    );
  }
}
