import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taskify/core/widget/custom-checkBox.dart';

import 'package:taskify/models/task_model.dart';
import 'package:taskify/pages/widgets/task_item-widget.dart';

class Tasklistwidgets extends StatelessWidget {
  const Tasklistwidgets({super.key,required this.tasks, required this.onTap,required this.emptyMessage, required this.onDelete,required this.onEdit});
  final List<TaskModel> tasks;
  final Function onEdit;

  //دالة تأخذ قيمة الـ checkbox و index لتحديث المهمة.
  final Function(bool?,int?) onTap;
final Function (int?)onDelete;
   final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return  tasks.isEmpty
              ? Center(
                  child: Text(
                     emptyMessage,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                 )
              : ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 60),
                   itemCount: tasks.length,
                   separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemBuilder: (BuildContext context, int index) {
                    final task = tasks[index];

                    return TaskItemwidget(model: tasks[index], 
                        onChanged: (bool?value ) {  
                              onTap(value,index);
                        }, onDelete: (int id) { 
                          onDelete(id);
                         },onEdit: (){
                          onEdit();
                         },
                        
                        
                        );
                  
                  },
                   
                 );
                
  }
}