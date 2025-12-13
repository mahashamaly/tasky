import 'package:flutter/material.dart';
import 'package:taskify/core/services/Preferences_manager.dart';
//themeNotifierمتغير يخبر التطبيق بلحظة التغير بالثيم
  //هو يراقب قيمة الثيم الحالية، فإذا تغيّرت (من Dark إلى Light أو العكس)، التطبيق يعرف فورًا ويعيد بناء الواجهة تلقائيًا.
  
   class Themecontroller {
 static final ValueNotifier<ThemeMode> themeNotifier=ValueNotifier(ThemeMode.dark);
 
 //عند تشغيل التطبيق، لازم يعرف آخر وضع اختاره المستخدم من قبل (مظلم أو فاتح).
//فهو يذهب إلى PreferencesManager (اللي بتتعامل مع التخزين في الجهاز).
//initيقرأ آخر اختيار للمستخدم من التخزين
 init(){
   bool result= PreferencesManager().getBool("theme")??true;
   themeNotifier.value=result?ThemeMode.dark:ThemeMode.light;

 }
 //toggleThemeيبدّل بين الداكن والفاتح ويحفظ الحالة الجديدة
   static toggleTheme(){
  if(themeNotifier.value==ThemeMode.dark){
    themeNotifier.value=ThemeMode.light;
    PreferencesManager().setBool("theme", false);
  }else{
    themeNotifier.value=ThemeMode.dark;
    PreferencesManager().setBool("theme", true);
  }
 }



   static bool isDark()=>themeNotifier.value==ThemeMode.dark;
}
