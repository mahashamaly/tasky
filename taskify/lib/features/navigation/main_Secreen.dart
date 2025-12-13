import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:taskify/features/profile/Profile_screen.dart';
import 'package:taskify/features/tasks/completed_tasks_screen.dart';
import 'package:taskify/features/home/home_screen.dart';
import 'package:taskify/features/tasks/tasks_screen.dart';




class MainSecreen extends StatefulWidget {
  const MainSecreen({super.key});

  @override
  State<MainSecreen> createState() => _MainSecreenState();
}

class _MainSecreenState extends State<MainSecreen> {
 
  List<Widget> _screen =[
HomeScreen(),
TasksScreen(),
CompletedTasksScreen(),
ProfileScreen(),

  ];
//يمثل المكان الحالى
  int  _currentindex=  0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        onTap: ( int? index){
          setState(() {
            _currentindex = index??0;
          });

        },
        
        // backgroundColor: Color(0xff181818),
        // type: BottomNavigationBarType.fixed,
        // selectedItemColor: Color(0Xff15B86C),
        // unselectedItemColor: Color(0xffC6C6C6),
        
        
        items: [
        BottomNavigationBarItem(icon:_buildSvgPicture('assets/svg/home.svg',0),
        label: "Home" 
        ),
       BottomNavigationBarItem(icon:_buildSvgPicture('assets/svg/todo.svg',1),
        label: "To Do" ),


         BottomNavigationBarItem(icon:_buildSvgPicture('assets/svg/Completed.svg',2),
         label: "Completed" ),
         BottomNavigationBarItem(icon:_buildSvgPicture('assets/svg/Profile.svg',3),
         label: "Profile" ),
         
      ]),
      body:SafeArea(child: _screen [_currentindex]),

    );
  }



  SvgPicture _buildSvgPicture(String path, int index){
    return SvgPicture.asset(path,
        colorFilter: ColorFilter.mode(
         _currentindex== index? Color(0Xff15B86C):Color(0xffC6C6C6),
         BlendMode.srcIn),
         );
     
  }
}