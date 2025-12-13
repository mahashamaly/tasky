import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:taskify/core/enums/task-item-actionS-enum.dart';
import 'package:taskify/core/services/Preferences_manager.dart';
import 'package:taskify/core/theme/themeController.dart';
import 'package:taskify/core/widget/custom-checkBox.dart';
import 'package:taskify/core/widget/custom_text_form_faild.dart';
import 'package:taskify/models/task_model.dart';

class TaskItemwidget extends StatelessWidget {
  TaskItemwidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete, required this.onEdit,
  });
  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 56,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Themecontroller.isDark()
              ? Colors.transparent
              : Color(0xffD1DAD6),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          Customcheckbox(
            value: model.isDone,
            onChanged: (bool? value) => onChanged(value),
          ),

          //     activeColor: Color(0XFF15B86C),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,
                  style: TextStyle(
                    // color: model.isDone ? Color(0XFFA0A0A0) : Color(0XFFFFFCFC),
                    fontSize: 16,
                    decoration: model.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
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
          PopupMenuButton<TaskItemActionSEnum>(
            icon: Icon(Icons.more_vert),
            // color: Themecontroller.isDark()?(model.isDone?Color(0xFFA0A0A0):Color(0XFFC6C6C6)):
            // (model.isDone?Color(0xFF6A6A6A):Color(0xFF3A4640)),
            //مع onSelected → صار عندك تفاعل ديناميكي مع كل عنصر.
            // //onSelected: هو جسر التواصل بين اختيار المستخدم وبين الكود اللي يبغيتِ ينفذ.
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionSEnum.markASDone:
                  onChanged(!model.isDone);

                case TaskItemActionSEnum.delete:
                  await _showAlertDialog(context);

                case TaskItemActionSEnum.edit:
               final result=   await _showBottomSheet(context, model);
               print(result);
               if(result==true){
                 onEdit();
               }
              }
            },
            itemBuilder: (context) => TaskItemActionSEnum.values.map((e) {
              return PopupMenuItem<TaskItemActionSEnum>(
                value: e,
                child: Text(e.name),
              );
            }).toList(),

            // PopupMenuItem(child: Text("Delete",),
            // value: TaskItemActionSEnum.delete,
            // ),
            // PopupMenuItem(child: Text("Edit",),
            // value: TaskItemActionSEnum.edit
            // ),

            // ]
          ),
        ],
      ),
    );
  }

  Future<String?> _showAlertDialog(context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text("Are you sure you want to delete this task"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("cancel"),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);

                Navigator.pop(context);
              },
              child: Text("Delete"),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }

    Future<bool?>    _showBottomSheet(BuildContext context, TaskModel model) {
    TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );
    TextEditingController taskDescriptionController = TextEditingController(
      text: model.taskDescription,
    );
    bool isHighPriority = model.HighPriority;
    GlobalKey<FormState> _key = GlobalKey();
     return  showModalBottomSheet<bool>(
      
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    CustomTextFormFaild(
                      controller: taskNameController,
                      hintText: "Finish UI design for login screen",
                      title: "Task Name",
                      validator: (String? value) {
                        //if(value?.trim().isEmpty??false)
                        if (value == null || value.trim().isEmpty) {
                          return "Please Enter Task Name ";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    CustomTextFormFaild(
                      controller: taskDescriptionController,
                      maxLines: 5,
                      hintText:
                          "Finish onboarding UI and hand off to devs by Thursday.",
                      title: "Task Description",
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "HighPriority",
                          style: Theme.of(context).textTheme.titleSmall,
                     
                        ),

                        // هنا لتحديد اذا كانت المهمة عالية الاولوية
                        Switch(
                          value:
                              isHighPriority, // القيمة الحالية للمفتاح (صح/خطأ)
                          onChanged: (bool value) {
                            // دالة تُنفذ لما المستخدم يغيّر حالة المفتاح
                            setState(() {
                              isHighPriority =
                                  value; //تحديث قيمة المتغير داخل الـ State
                            });
                          },
                        ),
                      ],
                    ),

                    Spacer(),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {
                          //قراءة البيانات من التخزين
                          final taskjson = PreferencesManager().getString(
                            'tasks',
                          );

                          List<dynamic> ListTasks = [];
                          //هنا فك تشفير البيانات
                          if (taskjson != null) {
                            ListTasks = jsonDecode(taskjson);
                          }
                          //تحديث المهمة
                          TaskModel newModel = TaskModel(
                            id: model.id,


                            taskName: taskNameController.text,
                            taskDescription: taskDescriptionController.text,
                            HighPriority: isHighPriority,
                            isDone: model.isDone,
                          );

                          //يتم البحث عن المهمة في ListTasks باستخدام firstWhere للبحث عن العنصر الذي يحتوي على نفس id للمهمة التي يتم تعديلها. هذا يسمح بتحديث المهمة بناءً على id الموجود في القائمة.

                           final item= ListTasks.firstWhere((e) => e['id'] == model.id);
                          //
                          final int index = ListTasks.indexOf(item);
                          ListTasks[index]=newModel;
                          final taskEncode=jsonEncode(ListTasks);
                          await PreferencesManager().setString('tasks', taskEncode);
                          
                      Navigator.of(context).pop(true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),

                      icon: (Icon(Icons.edit)),
                      label: Text("Add Edit"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
