import 'package:flutter/material.dart';


import 'package:taskify/core/services/Preferences_manager.dart';
import 'package:taskify/core/widget/custom-svg-picture.dart';
import 'package:taskify/core/widget/custom_text_form_faild.dart';
import 'package:taskify/pages/screen/main_Secreen.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WelcomeScreen> {
  @override
  final controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0XFF181818),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Customsvgpicture.withColorFilter(path: 'assets/svg/logo.svg',),
               

                      SizedBox(width: 16),

                      Text(
                        "Tasky",
                        style: 
                        Theme.of(context).textTheme.displayMedium
                     
                      ),
                    ],
                  ),

                  SizedBox(height: 118),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Tasky ",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Customsvgpicture.withColorFilter(path:'assets/svg/hand.svg' )
                     
                    ],
                  ),
                  SizedBox(height: 8),

                  Text(
                    "Your productivity journey starts here.",

                    style:Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 16
                    )
                    
                  ),
                  SizedBox(height: 24),
                  Customsvgpicture.withColorFilter(path:'assets/svg/pana.svg',width: 215,height: 200, ),
                 
                  SizedBox(height: 24),

               
                  Padding(
               padding: const EdgeInsets.symmetric(
                       horizontal: 16,
                      vertical: 16,
                    ),
                    child: CustomTextFormFaild(
                      controller: controller, 
                      hintText: "e.g. Maha Atef", 
                      title: "Full Name",
                        validator: (String? value) {
                          //if(value?.trim().isEmpty??false)
                          if (value == null || value.trim().isEmpty) {
                            return "please Enter Your Full Name";
                          }
                          return null;
                        },
                      
                      ),
                  ),
                
                  SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: () async {
                   
                      if (_key.currentState?.validate() ?? false) {
                              //هيك قدرت اختصر السطرين 
                             await   PreferencesManager().setString('username', controller.value.text);

                     

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MainSecreen();
                            },
                          ),
                        );
                      } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("please Enter Your Full Name")),
                      );
                      }
                    },

                    child: Text(
                      "Let’s Get Started",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(fixedSize: Size(343, 40)),
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
