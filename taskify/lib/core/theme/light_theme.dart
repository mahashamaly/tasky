import 'package:flutter/material.dart';

ThemeData lightTheme=ThemeData(

useMaterial3: true,
brightness: Brightness.light,
colorScheme: ColorScheme.light(
  primaryContainer: Color(0xFFFFFFFF),
  secondary: Color(0xff3A4640),
  

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
  
  backgroundColor:WidgetStateProperty.all(Color(0xff15B86C)) ,
  foregroundColor: WidgetStateProperty.all(Color(0xffFFFCFC)),
  textStyle:WidgetStateProperty.all(
TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500
)
  ),

)

),

floatingActionButtonTheme: FloatingActionButtonThemeData(
 backgroundColor: Color(0xff15B86C),
   foregroundColor: Color(0xffFFFCFC),
   extendedTextStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500
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
labelSmall: TextStyle(
      fontSize: 20,
       fontWeight: FontWeight.w400,
       color: Color(0XFF161F1B),
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


textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.black),
      textStyle: MaterialStateProperty.all(
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
),


listTileTheme: ListTileThemeData(
  titleTextStyle: TextStyle(
  color: Color(0xff161F1B),
    fontSize: 16,
    fontWeight: FontWeight.w400,
  )
),


dividerTheme: DividerThemeData(
  color: Color(0xffD1DAD6)
),

textSelectionTheme: TextSelectionThemeData(
  cursorColor: Colors.black,
  selectionColor: Colors.white,
  selectionHandleColor: Colors.black
),
bottomNavigationBarTheme: BottomNavigationBarThemeData(
   backgroundColor: Color(0xffF6F7F9),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0Xff14A662),
        unselectedItemColor: Color(0Xff3A4640),
        

),
splashFactory: NoSplash.splashFactory,
popupMenuTheme: PopupMenuThemeData(
  color:Color(0xffF6F7F9),
  shape: RoundedRectangleBorder(
   
    borderRadius: BorderRadius.circular(16)),
    elevation: 2,
    shadowColor:  Color(0xFF15B86C),
    labelTextStyle: WidgetStateProperty.all(TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.black
    ))
)
);




