import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/pages/home_screen.dart';
import 'package:taskify/pages/main_Secreen.dart';

class WelcomeScreen extends StatefulWidget {
   WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _MyWidgetState();
  
}

class _MyWidgetState extends State<WelcomeScreen> {

 
  @override
    final controller=TextEditingController();
    final GlobalKey<FormState>_key= GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFF181818),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key:_key ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/svg/logo.svg'),
                        
                      
                        SizedBox(
                        width:16 ,
                        ),
                
                        Text(
                          "Tasky",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ],
                         
                    ),
                
                   
                   SizedBox(
                    height: 118,
                
                   ),
                  
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                
                 Text("Welcome To Tasky ",style: TextStyle(fontSize: 24,fontWeight:FontWeight.w400, color:Color(0xffFFFCFC),),),
                 SvgPicture.asset('assets/svg/hand.svg'),
                
                
                    ],
                
                   ),
                   SizedBox(
                    height: 8,
                   ),
                
                    Text("Your productivity journey starts here.",style: TextStyle(fontSize:16 , fontWeight:FontWeight.w400,color: Color(0xffFFFCFC)),),
                    SizedBox(
                      height: 24,
                    ),
                    SvgPicture.asset('assets/svg/pana.svg',
                    width: 215,
                    height: 200,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                
                  Align(
                   alignment: Alignment.centerLeft,
                     child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("Full Name",style: TextStyle(fontSize:16 ,fontWeight: FontWeight.w400, color: Color(0xffFFFCFC)),),
                  ),
                        
                  ),
                
                  SizedBox(
                    height: 8,
                  ),
                  // حقل إدخال الاسم الكامل
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                      child: TextFormField(
                       controller: controller,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        // التحقق من صحة البيانات
                        validator: (String? value){
                           //if(value?.trim().isEmpty??false)
                          if(value==null||value.trim().isEmpty){
                            return"Please enter this field ";

                          }
                          return null;

                        },
                        
                
                
                
                                decoration: InputDecoration(
                                hintText: ("e.g. Maha Atef"),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16),borderSide: BorderSide.none),
                                
                                filled: true,
                                fillColor: Color(0xff282828),
                      
                      
                      
                                ),
                                cursorColor: Colors.white,
                      
                      
                      ),
                    ),
                
                    SizedBox(
                      height: 24,
                    ),
                    
                   ElevatedButton(onPressed: ()async{
                   // _key.currentState?.validate();
                 
                   
                    if( _key.currentState?.validate()??false){
                      final pref=  await SharedPreferences.getInstance();
                      // تخزين اسم المستخدم (⚠️ غير مشفّر)
                      pref.setString('username', controller. value.text);



                      Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(
                      builder:(BuildContext context){
                        return MainSecreen();
                      }
                      
                      ),
                   
                   );
                
                    }else{
                     //snakbar
                
                    }
                   
                   }, 
                   
                   child: Text("Let’s Get Started",style: TextStyle(fontSize: 14,fontWeight:FontWeight.w400 ),),
                
                   style:ElevatedButton.styleFrom(
                    backgroundColor:Color(0xff15B86C),
                    foregroundColor:Color(0xffFFFCFC),
                    fixedSize:Size(343, 40) ,
                   ),
                   
                   ),
                   
                
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}