import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskify/pages/Profile_screen.dart';
import 'package:taskify/pages/completed_tasks_screen.dart';
import 'package:taskify/pages/home_screen.dart';
import 'package:taskify/pages/tasks_screen.dart';

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
        
        backgroundColor: Color(0xff181818),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0Xff15B86C),
        unselectedItemColor: Color(0xffC6C6C6),
        
        
        items: [
        BottomNavigationBarItem(icon:SvgPicture.asset("assets/svg/home.svg",
        colorFilter: ColorFilter.mode(
         _currentindex== 0? Color(0Xff15B86C):Color(0xffC6C6C6),
         BlendMode.srcIn),),
        label: "Home" 
        ),
       BottomNavigationBarItem(icon:SvgPicture.asset("assets/svg/todo.svg",
       colorFilter: ColorFilter.mode(
       _currentindex==1? Color(0Xff15B86C):Color(0xffC6C6C6), BlendMode.srcIn)),
        label: "To Do" ),
         BottomNavigationBarItem(icon:SvgPicture.asset("assets/svg/Completed.svg",
         colorFilter: 
         ColorFilter.mode(
         _currentindex==2? Color(0Xff15B86C):Color(0xffC6C6C6), BlendMode.srcIn),),
         label: "Completed" ),
         BottomNavigationBarItem(icon:SvgPicture.asset("assets/svg/Profile.svg",
         colorFilter: ColorFilter.mode(
        _currentindex==3?  Color (0Xff15B86C):Color(0xffC6C6C6), BlendMode.srcIn),),
         label: "Profile" ),
         
      ]),
      body:SafeArea(child: _screen [_currentindex]),

    );
  }
}