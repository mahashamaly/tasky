import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/core/services/Preferences_manager.dart';
import 'package:taskify/core/theme/dark-theme.dart';
import 'package:taskify/core/theme/light_theme.dart';
import 'package:taskify/pages/screen/main_Secreen.dart';
import 'package:taskify/pages/screen/welcome_screen.dart';


ValueNotifier<ThemeMode> themeNotifier=ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await PreferencesManager().init();
    print(themeNotifier.value);
    themeNotifier.value=ThemeMode.dark;
    print(themeNotifier.value);
  String? username=PreferencesManager().getString("username");
 // final pref = await SharedPreferences.getInstance();
  //String? username = pref.getString('username') ?? '';

  //print('username=$username');
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.username});
  final String? username;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context,ThemeMode value,Widget? child) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tasky',
        theme:lightTheme,  // ثيم افتراضي للفاتح
        darkTheme: darkTheme, // ثيم للدارك مود
        themeMode:value, // يعتمد على إعداد الجهاز
      
        //هنا علشان ما اخليه يرجع للصفحة الاولى
        //اذا اليوز نيم نل بروح لصفحة الويل كم يعنى ما فى اسم مستخدم محفوظ
        //اذا مش نل بفوت على صفحة التطبيق مباشرة
        home: username == null ? WelcomeScreen() : MainSecreen()
         
        
      );
      }
      
    );
      
  }
}
