import 'dart:convert';
import 'dart:math';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskify/constants/storage-key.dart';

import 'package:taskify/core/services/Preferences_manager.dart';
import 'package:taskify/core/widget/custom-svg-picture.dart';
import 'package:taskify/features/home/components/highprioritytasks_widget.dart';
import 'package:taskify/features/home/home-controller.dart';
import 'package:taskify/models/task_model.dart';
import 'package:taskify/features/add_task/add-Task-Screen.dart';

import 'package:taskify/features/home/components/achieved_tasks_widget.dart';
import 'package:taskify/features/home/components/sliver-task-list-widget.dart';
import 'package:taskify/core/components/task-list-widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Consumer<HomeController>(
        builder: (BuildContext context,HomeController value, child) {
          final HomeController controller=context.read<HomeController>();
          return   Scaffold(
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
                       value.  LoadTask();
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
                           backgroundImage:  value. userImagePath==null
                           
                           ? AssetImage('assets/image/person.png')
                          
                           //
                           //اعرض صورة موجودة على جهاز الهاتف المسار تبعها موجود
                           //userImagePath!
                           :FileImage(File( value. userImagePath!)),
                         ),
                         SizedBox(width: 10),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               "Good Evening ,${ value. username}",
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
                      totalDoneTaskS: value.totalDoneTasks,
                   totalTask: value.totalTask,
                       percent: value. percent,
                     ),
                     SizedBox(height: 8),
                     HighprioritytasksWidget(
                       tasks:  value. tasks,
                         
                       onTap: (bool? value, int? index) {
                    controller.doneTask (value, index);
                       }, refresh: (){
                         controller.  LoadTask();
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
          
        
        
        
        
        
        value.   isLoading
         ? SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          )
      
         : sliverTasklistwidgets(   // لاحظ الاسم CamelCase
            tasks:value. tasks,
            onTap: (bool? value, int? index) {
            controller.  doneTask(value, index);
            },
            emptyMessage: 'no data', onDelete: (int? id) { 
              controller.  deleteTask(id);
             }, onEdit: (){
              controller.  LoadTask();
             },
          ),
          ],
        ),
        
            
              
          
            
            
            
            
         
           );
        }
       
      ),
    );
  }
}