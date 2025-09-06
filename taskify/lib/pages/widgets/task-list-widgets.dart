import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/models/task_model.dart';

class Tasklistwidgets extends StatelessWidget {
  const Tasklistwidgets({super.key,required this.tasks, required this.onTap,required this.emptyMessage});
  final List<TaskModel> tasks;

  //دالة تأخذ قيمة الـ checkbox و index لتحديث المهمة.
  final Function(bool?,int?) onTap;

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
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        alignment: Alignment.center,
                      height: 56,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xff282828),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                             SizedBox(width: 8),
                            Checkbox(
                              activeColor: Color(0XFF15B86C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              value: tasks[index].isDone,
                             onChanged: (bool? value) {
                              onTap(value,index);
                               },
                           ),
                          SizedBox(width: 16),
                           Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.taskName,
                                    style: TextStyle(
                                      color: task.isDone
                                         ? Color(0XFFA0A0A0)
                                          : Color(0XFFFFFCFC),
                                      fontSize: 16,
                                      decoration: task.isDone
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                  if (task.taskDescription.isNotEmpty)
                                    Text(
                                      task.taskDescription,
                                      style: TextStyle(
                                        color: Color(0XFFC6C6C6),
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                ],
                              ),
                            ),
                         ],
                        ),
                      ),
                    );
                  },
                   
                 );
                
  }
}