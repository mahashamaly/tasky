import 'package:flutter/material.dart';

ThemeData darkTheme=ThemeData(

useMaterial3: true,
brightness: Brightness.dark,

//هادا للكونتينر
colorScheme: ColorScheme.dark(
  primaryContainer: Color(0xff282828)
),
        scaffoldBackgroundColor: Color(0xff181818),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff181818),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0XFFFFFCFC),
          ),
          centerTitle: false,
          iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
        ),
        switchTheme: SwitchThemeData(
          trackColor: WidgetStateProperty.resolveWith((States) {
            if (States.contains(WidgetState.selected)) {
              return Color(0xff15B86C);
            }
            return Colors.white;
          }),
          thumbColor: WidgetStateProperty.resolveWith((States) {
            if (States.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return Color(0XFF9E9E9E);
          }),
          //تغير لون البورد
          trackOutlineColor: WidgetStateProperty.resolveWith((States) {
            if (States.contains(WidgetState.selected)) {
              return Colors.transparent;
            }
            return Color(0xff9E9E9E);
          }),
          trackOutlineWidth: WidgetStateProperty.resolveWith((States) {
            if (States.contains(WidgetState.selected)) {
              return 0;
            }
            return 2;
          }),
        ),


elevatedButtonTheme: ElevatedButtonThemeData(
style: ButtonStyle(
  
  backgroundColor:MaterialStateProperty.all(Color(0xff15B86C)) ,
  foregroundColor: MaterialStateProperty.all(Color(0xffFFFCFC))

)

),


textTheme: TextTheme(
  displayMedium: TextStyle(
    fontSize: 28,
    color: Color(0xffFFFFFF),
    fontWeight: FontWeight.w400,
  ),

  displaySmall: TextStyle(
    fontSize: 24,
   color:Color(0xffFFFCFC),
  fontWeight: FontWeight.w400,

  ),
  displayLarge: TextStyle(
fontSize: 32,
   fontWeight: FontWeight.w400,
    color: Color(0xffFFFCFC),
  ),
  labelMedium: TextStyle(
  color: Colors.white,
  fontSize: 16
),
titleMedium: TextStyle(
  fontSize: 16,
 fontWeight: FontWeight.w400,
color: Color(0xffFFFCFC),
),
titleSmall: TextStyle(
   fontSize: 14,
 fontWeight: FontWeight.w400,
color: Color(0xffC6C6C6),
),
//done task
titleLarge: TextStyle(
 color: Color(0xFFA0A0A0),
  fontSize: 16,
 
  decoration: TextDecoration.lineThrough,
   //overflow: TextOverflow.ellipsis,
    //→ هذا لون الخط اللي فوق النص
   decorationColor: Color(0xFF49454F),
   fontWeight: FontWeight.w400,
),


  
),


inputDecorationTheme: InputDecorationTheme(
  hintStyle: TextStyle(
    color: Color(0xff6D6D6D),
  ),
    border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
              filled: true,
            fillColor: Color(0xff282828),

             errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color:Colors.red,
              width: 0.5
             )

            ),
),



checkboxTheme: CheckboxThemeData(
   shape: RoundedRectangleBorder(
   borderRadius: BorderRadius.circular(4),
    ),
    side: BorderSide(
      color: Color(0xFF6E6E6E),
      width: 2,
    )
),





);
