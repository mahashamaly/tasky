import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskify/models/task_model.dart';
import 'package:taskify/pages/screen/highpriority_screen.dart';


class HighprioritytasksWidget extends StatelessWidget {
  const HighprioritytasksWidget({
    super.key,
    required this.onTap, required this.tasks, required this.refresh,
  });
  final Function(bool?, int?) onTap;
  final List<TaskModel> tasks;
   final Function  refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
    
      decoration: BoxDecoration(
        color: Color(0Xff282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "High Priority Tasks",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF15B86C),
                    ),
                  ),
                ),
            
                ...tasks.reversed.where((e)=>e.HighPriority).take(4).map((element) {
                  return Row(
                    children: [
                      Checkbox(
                        activeColor: Color(0XFF15B86C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        value: element.isDone,
                        onChanged: (bool? value) {
                          final index = tasks.indexWhere((e) {
                            return e.id == element.id;
                          });
                          onTap(value, index);
                        },
                      ),
                     
                      Flexible(
                        child: Text(
                          element.taskName,
                          style: TextStyle(
                            color: element.isDone
                                ? Color(0XFFA0A0A0)
                                : Color(0XFFFFFCFC),
                            fontSize: 16,
                            decoration: element.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        
        
        GestureDetector(
          onTap: ()async{
      final result=    await  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return HighpriorityScreen() ;

            }
            )
            
            );
            refresh();
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
             color: Color(0Xff282828),
             shape: BoxShape.circle,
             border: Border.all(color: Color(0XFF6E6E6E))
              ),
              child:SvgPicture.asset('assets/svg/arrow-up-right.svg',
              height: 24,
              width: 24,
              )
            ),
          ),
        ),
        ],


      ),
    );
  }
}
