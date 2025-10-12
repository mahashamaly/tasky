import 'package:flutter/material.dart';

ThemeData lightTheme=ThemeData(

useMaterial3: true,
brightness: Brightness.light,
colorScheme: ColorScheme.light(
  primaryContainer: Color(0xFFFFFFFF),
  

),
        scaffoldBackgroundColor: Color(0xffF6F7F9),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xffF6F7F9),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0XFF161F1B),
          ),
          centerTitle: false,
          iconTheme: IconThemeData(color: Color(0xff161F1B)),
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
    color: Color(0xff161F1B),
    fontWeight: FontWeight.w400,
  ),
   displaySmall: TextStyle(
    fontSize: 24,
   color:Color(0xff161F1B),
  fontWeight: FontWeight.w400,

  ),
labelMedium: TextStyle(
  color: Colors.black,
  fontSize: 16
),
displayLarge: TextStyle(
  fontSize: 32,
   fontWeight: FontWeight.w400,
    color: Color(0xff161F1B),
),
titleMedium: TextStyle(
  fontSize: 16,
 fontWeight: FontWeight.w400,
color: Color(0xff161F1B),
),
titleSmall: TextStyle(
   fontSize: 14,
 fontWeight: FontWeight.w400,
color: Color(0xff3A4640),
),
//done task
titleLarge: TextStyle(
 color: Color(0xFF6A6A6A),
  fontSize: 16,
 
  decoration: TextDecoration.lineThrough,
  // overflow: TextOverflow.ellipsis,
    //→ هذا لون الخط اللي فوق النص
   decorationColor: Color(0xFF49454F),
      fontWeight: FontWeight.w400,

),



  
),


inputDecorationTheme: InputDecorationTheme(
  hintStyle: TextStyle(
    color: Color(0xff9E9E9E),
  ),
    border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(0xffD1DAD6),
              width: 0.5),
            ),
              filled: true,
            fillColor:Color(0xffFFFFFF),


            focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(0xffD1DAD6),
              width: 0.5
              ),
              
            ),
             enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(0xffD1DAD6),
              width: 0.5
              ),
             ),
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
      color: Color(0xFFD1DAD6),
      width: 2,
    )
),
);




