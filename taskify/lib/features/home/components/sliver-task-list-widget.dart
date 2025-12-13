import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskify/core/widget/custom-checkBox.dart';
import 'package:taskify/models/task_model.dart';
import 'package:taskify/core/components/task_item-widget.dart';

class  sliverTasklistwidgets extends StatelessWidget {
  const sliverTasklistwidgets({super.key,required this.tasks, required this.onTap,required this.emptyMessage, required this.onDelete, required this.onEdit});
  final List<TaskModel> tasks;

  //دالة تأخذ قيمة الـ checkbox و index لتحديث المهمة.
  final Function(bool?,int?) onTap;
  final Function(int?)onDelete; 
   final String emptyMessage;
   final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return  tasks.isEmpty
              ? SliverToBoxAdapter(
                child: Center(
                    child: Text(
                       emptyMessage,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                   ),
              )
              : SliverPadding(
                padding: EdgeInsets.only(bottom: 80),
                sliver: SliverList.separated(
                  
                     itemCount: tasks.length,
                     separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemBuilder: (BuildContext context, int index) {
                      final task = tasks[index];
                     // return Padding(
                        //padding: const EdgeInsets.only(top: 8),
                        return TaskItemwidget(model: tasks[index], 
                        onChanged: (bool?value ) {  
                              onTap(value,index);
                        }, onDelete: (int id) { 
                          onDelete(id);

                         }, onEdit: (){
                          onEdit();
                         },
                        
                        
                        );
                     
                    },
                     
                   ),
              );
                
  }
}