import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/pages/home_screen.dart';
import 'package:taskify/pages/main_Secreen.dart';

import 'package:taskify/welcome_screen.dart';

void main() async{
  
    WidgetsFlutterBinding.ensureInitialized(); 
final pref=  await SharedPreferences.getInstance();

  String? username =pref.getString('username')??'';
  
  print('username=$username');
  runApp(  MyApp(username: username,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.username});
  final String? username;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Color(0xff181818),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xff181818),
        titleTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w400, color: Color(0XFFFFFCFC)),
        centerTitle: false,
        iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
        
      ),
      switchTheme: SwitchThemeData(
     trackColor: WidgetStateProperty.resolveWith((States){
    if(States.contains(WidgetState.selected)){
      return Color(0xff15B86C);

    }
    return Colors.white;
   }),
   thumbColor: WidgetStateProperty.resolveWith((States){
    if(States.contains(WidgetState.selected)){
     return Colors.white;

    }
    return Color(0XFF9E9E9E);
   }),
   //تغير لون البورد
   trackOutlineColor:WidgetStateProperty.resolveWith((States){
    if(States.contains(WidgetState.selected)){
      return Colors.transparent;
    }
    return   Color(0xff9E9E9E);



   }
   
   
   
   ),
   trackOutlineWidth: WidgetStateProperty.resolveWith((States){
if(States.contains(WidgetState.selected)){
  return 0;
}
return 2;
   })
      ),
      
    

      ),
      
      //هنا علشان ما اخليه يرجع للصفحة الاولى
      //اذا اليوز نيم نل بروح لصفحة الويل كم يعنى ما فى اسم مستخدم محفوظ
      //اذا مش نل بفوت على صفحة التطبيق مباشرة
     home:username==null? WelcomeScreen():MainSecreen()

    

    );
  }
}
