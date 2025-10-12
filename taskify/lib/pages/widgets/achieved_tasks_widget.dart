import 'dart:math';

import 'package:flutter/material.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({super.key, required this.totalTask, required this.doneTask, required this.percent,});
   final int totalTask;
    final int doneTask;
final  double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
   color: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Achieved Tasks",
            style:Theme.of(context).textTheme.titleMedium ,
         
            
            
            ),
            SizedBox(
              height: 4,
            ),
            Text("${doneTask} Out of ${totalTask} Done",style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
         Transform.rotate(
          angle:-pi/2,
           child: SizedBox(
            height: 48,
            width: 48,
             child: CircularProgressIndicator(
              value: percent, 
              backgroundColor: Color(0xff6D6D6D),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0Xff15B86C)),
              strokeWidth: 4,
                     ),
           ),
         ),
        Text("${((percent*100).toInt())} %",
        
        style:Theme.of(context).textTheme.titleMedium ),
          ],
        )
      ],
    ),

   );


  }
}